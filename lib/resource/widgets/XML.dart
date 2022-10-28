/// Permet de lire, créer et d'interpréter des chaines xml
///
/// Valeur:
///```dart
///String balise; // Nom de la balise
///Map<String, String> attribut; // Liste d'attribut de la balise
///Map<String, String> property; // Liste des propriétés de l'xml(contenu entre "<?" et "?>")
///List<Object> child; // Liste des enfants de la balise (String ou XML)
///int _type; // Type de la balise (<balise/> ou <balise></balise>)
///```
class XML {
  late String balise = "";
  late Map<String, String> attribut = <String, String>{};
  late Map<String, String> property = <String, String>{};
  late List<Object> child = [];
  late int _type = 2;

  /// Balise de type <type/>
  static int simple = 1;

  /// Balise de type <type></type>
  static int double = 2;

  /// Créer un objet XML
  XML({required String baliseName, int type = 2, List<Object> child = const [], Map<String, String> listAttribut = const <String, String>{}, Map<String, String> xmlProperty = const <String, String>{}}) {
    balise = baliseName;
    attribut = listAttribut;
    property = xmlProperty;
    this.child = ((type == 1) ? [] : child);
    _type = type;
  }

  /// Créer un objet XML à partir d'une chaine xml
  ///
  /// Exemple:
  ///```dart
  ///String xml1 = XML.byString("<balise>texte<balise/>"); // Valide
  ///String xml2 = XML.byString("text"); // Erreur (Exception)
  ///```
  XML.byString(String xml) {
    List<String> allBalise = [];
    RegExp(r"<[^<>$]*>").allMatches(xml).forEach((element) {
      allBalise.add(element[0]!);
    });
    List<String> allWord = [];
    RegExp(r"(?!(>[\ \t\n\r\0]*<))>[-\s\w\d\ &\t\n\r\0à.@Ü-ü]*<").allMatches(xml).forEach((element) {
      allWord.add(element[0]!.substring(1, element[0]!.length - 1));
    });
    List<String> allEndBalise = [];
    RegExp(r"<[\/]()(\w*(:)*(\.)*(,)*(\?)*(!)*\s*)*>").allMatches(xml).forEach((element) {
      allEndBalise.add(element[0]!);
    });

    // Récupération des propriétés de l'xml
    if (allBalise.isNotEmpty) {
      if (allBalise.elementAt(0)[1] == '?' && allBalise.elementAt(0)[allBalise.elementAt(0).length - 2] == '?') {
        List<String> prop = allBalise.elementAt(0).substring(0, allBalise.elementAt(0).length - 2).split(' ');
        for (var i = 1; i < prop.length; i++) {
          List<String> uneProp = prop.elementAt(i).split('=');
          if (uneProp.length == 2) {
            try {
              property.addAll({uneProp[0]: uneProp[1].substring(1, uneProp[1].length - 1)});
            } catch (e) {
              throw Exception("Problème rencontré au niveau de : " + uneProp[0] + "=" + uneProp[0] + " , l'élément [" + uneProp[0] + "] n'as pas pu être identifié");
            }
          }
        }
        xml = xml.substring(xml.indexOf(allBalise.elementAt(0)) + allBalise.elementAt(0).length, xml.length);
        allBalise.remove(allBalise.elementAt(0));
      }
    }

    // Récupération de la premier balise
    if (allBalise.isNotEmpty) {
      if (RegExp(r'<[(\w\s(:,\?!"=))]*[\/]>').allMatches(allBalise.elementAt(0)).isEmpty) {
        _type = XML.double;
        List<String> contentSplit = allBalise.elementAt(0).substring(1, allBalise.elementAt(0).length - 1).split(' ');
        if (contentSplit.isNotEmpty) balise = contentSplit.elementAt(0);
        for (var i = 1; i < contentSplit.length; i++) {
          List<String> uneProp = contentSplit.elementAt(i).split('=');
          if (uneProp.length == 2) {
            try {
              attribut.addAll({uneProp[0]: uneProp[1].substring(1, uneProp[1].length - 1)});
            } catch (e) {
              throw Exception("Problème rencontré au niveau de : " + uneProp[0] + "=" + uneProp[0] + " , l'élément [" + uneProp[0] + "] n'as pas pu être identifié");
            }
          }
        }
        // Trouver la balise fermante associé
        if (allEndBalise.isNotEmpty) {
          int index = 1;
          int posOfBalise = 0;
          int nbOfBalise = 1;
          for (int i = 1; i < allBalise.length && index != 0; i++) {
            if (allBalise.elementAt(i).contains(balise) && allBalise.elementAt(i).contains("</")) {
              index--;
              nbOfBalise++;
            } else if (allBalise.elementAt(i).contains(balise)) {
              index++;
              nbOfBalise++;
            }
            posOfBalise = i;
          }
          Iterable<Match> lstOfIndex = (balise).allMatches(xml);
          if (lstOfIndex.length >= nbOfBalise) {
            int pos = 0;
            for (int i = lstOfIndex.elementAt(nbOfBalise - 1).start; i > 0 && pos == 0; i--) {
              if (xml[i] == '/' && xml[i - 1] == '<') {
                pos = i - 1;
              }
            }
            xml = xml.substring(xml.indexOf(allBalise.elementAt(0)) + allBalise.elementAt(0).length, pos);
            allBalise.removeAt(0);
            allBalise.removeAt(posOfBalise - 1);
          }
        } else {
          throw Exception("Problème rencontré : aucune balise fermante n'a été trouvée");
        }
        // Récupérer les enfants de la balise
        bool haveNode = true;
        while (xml != "" && haveNode) {
          if (allWord.isNotEmpty) {
            if (allBalise.isNotEmpty) {
              if (allBalise.elementAt(0).allMatches(xml).elementAt(0).start < allWord.elementAt(0).allMatches(xml).elementAt(0).start) {
                String newBalise = allBalise.elementAt(0).substring(1, allBalise.elementAt(0).length - 1).split(' ').elementAt(0);
                if (newBalise[newBalise.length - 1] != '/') {
                  int index = 1;
                  int posOfBalise = 0;
                  int nbOfBalise = 1;
                  for (int i = 1; i < allBalise.length && index != 0; i++) {
                    if (allBalise.elementAt(i).contains(newBalise) && allBalise.elementAt(i).contains("</")) {
                      index--;
                      nbOfBalise++;
                    } else if (allBalise.elementAt(i).contains(newBalise)) {
                      index++;
                      nbOfBalise++;
                    }
                    posOfBalise = i;
                  }
                  Iterable<Match> lstOfIndex = (newBalise).allMatches(xml);
                  if (lstOfIndex.length >= nbOfBalise) {
                    int pos = 0;
                    for (int i = lstOfIndex.elementAt(nbOfBalise - 1).start; i > 0 && pos == 0; i--) {
                      if (xml[i] == '/' && xml[i - 1] == '<') {
                        pos = i - 1;
                      }
                    }
                    child.add(XML.byString(xml.substring(xml.indexOf(allBalise.elementAt(0)), pos + allBalise.elementAt(posOfBalise).length)));
                    xml = xml.substring(pos + allBalise.elementAt(posOfBalise).length);
                    for (var i = 0; i <= posOfBalise; i++) {
                      allBalise.removeAt(0);
                    }
                    for (var i = 0; i < allWord.length; i++) {
                      if (!xml.contains(allWord.elementAt(0))) {
                        allWord.removeAt(0);
                      }
                    }
                  }
                } else {
                  child.add(XML.byString(allBalise.elementAt(0)));
                  xml = xml.substring(xml.indexOf(allBalise.elementAt(0)) + allBalise.elementAt(0).length);
                  allBalise.removeAt(0);
                }
                if (allBalise.isEmpty) {
                  allWord.clear();
                }
              } else {
                child.add(allWord.elementAt(0));
                xml = xml.substring(xml.indexOf(allWord.elementAt(0)) + allWord.elementAt(0).length);
                allWord.remove(0);
              }
            } else {
              child.add(allWord.elementAt(0));
              haveNode = false;
            }
          } else {
            if (allBalise.isNotEmpty) {
              String newBalise = allBalise.elementAt(0).substring(1, allBalise.elementAt(0).length - 1).split(' ').elementAt(0);
              if (newBalise[newBalise.length - 1] != '/') {
                int index = 1;
                int posOfBalise = 0;
                int nbOfBalise = 1;
                for (int i = 1; i < allBalise.length && index != 0; i++) {
                  if (allBalise.elementAt(i).contains(newBalise) && allBalise.elementAt(i).contains("</")) {
                    index--;
                    nbOfBalise++;
                  } else if (allBalise.elementAt(i).contains(newBalise)) {
                    index++;
                    nbOfBalise++;
                  }
                  posOfBalise = i;
                }
                Iterable<Match> lstOfIndex = (newBalise).allMatches(xml);
                if (lstOfIndex.length >= nbOfBalise) {
                  int pos = 0;
                  for (int i = lstOfIndex.elementAt(nbOfBalise - 1).start; i > 0 && pos == 0; i--) {
                    if (xml[i] == '/' && xml[i - 1] == '<') {
                      pos = i - 1;
                    }
                  }
                  child.add(XML.byString(xml.substring(xml.indexOf(allBalise.elementAt(0)), pos + allBalise.elementAt(posOfBalise).length)));
                  xml = xml.substring(pos + allBalise.elementAt(posOfBalise).length);
                  for (var i = 0; i <= posOfBalise; i++) {
                    allBalise.removeAt(0);
                  }
                  for (var i = 0; i < allWord.length; i++) {
                    if (!xml.contains(allWord.elementAt(0))) {
                      allWord.removeAt(0);
                    }
                  }
                }
              } else {
                child.add(XML.byString(allBalise.elementAt(0)));
                xml = xml.substring(xml.indexOf(allBalise.elementAt(0)) + allBalise.elementAt(0).length);
                allBalise.removeAt(0);
              }
              if (allBalise.isEmpty) {
                allWord.clear();
              }
            } else {
              haveNode = false;
            }
          }
        }
      } else {
        _type = XML.simple;
        List<String> contentSplit = allBalise.elementAt(0).substring(1, allBalise.elementAt(0).length - 2).split(' ');
        if (contentSplit.isNotEmpty) balise = contentSplit.elementAt(0);
        for (var i = 1; i < contentSplit.length; i++) {
          List<String> uneProp = contentSplit.elementAt(i).split('=');
          if (uneProp.length == 2) {
            try {
              attribut.addAll({uneProp[0]: uneProp[1].substring(1, uneProp[1].length - 1)});
            } catch (e) {
              throw Exception("");
            }
          }
        }
      }
    } else {
      throw Exception("Problème rencontré : aucune donnée xml detecté");
    }
  }

  /// Recupère le type d'XML
  int get type {
    return _type;
  }

  static XML empty() {
    return XML(baliseName: "");
  }

  /// Encode une chaine au format XML
  ///
  /// Exemple:
  ///```dart
  ///String xmlEncode = XML.encode("xml=<test>&'\"<test/>");
  /// //"xml&eq&lttest&gt&amp&apos&quot&lttest&sla&gt"
  ///```
  static String encode(String xml) {
    String xmlEncoded = "";
    Map<String, String> xmlSyntaxe = {"&": "&amp", "/": "&sla", "=": "&eq", "<": "&lt", ">": "&gt", "'": "&apos", "\"": "&quot"};
    xmlSyntaxe.forEach((key, value) {
      xmlEncoded = "";
      List<String> equalsList = xml.split(key);
      xmlEncoded = equalsList.elementAt(0);
      for (var i = 1; i < equalsList.length; i++) {
        xmlEncoded += value + equalsList.elementAt(i);
      }
      xml = xmlEncoded;
    });
    return xmlEncoded;
  }

  /// Decode une chaine au format XML
  ///
  /// Exemple:
  ///```dart
  ///String xmlDescode = XML.encode("xml&eq&lttest&gt&amp&apos&quot&lttest&sla&gt");
  /// // "xml=<test>&'\"<test/>"
  ///```
  static String decode(String xml) {
    String xmlEncoded = "";
    Map<String, String> xmlSyntaxe = {"&amp": "&", "&sla": "/", "&eq": "=", "&lt": "<", "&gt": ">", "&apos": "'", "&quot": "\""};
    xmlSyntaxe.forEach((key, value) {
      xmlEncoded = "";
      List<String> equalsList = xml.split(key);
      xmlEncoded = equalsList.elementAt(0);
      for (var i = 1; i < equalsList.length; i++) {
        xmlEncoded += value + equalsList.elementAt(i);
      }
      xml = xmlEncoded;
    });
    return xmlEncoded;
  }

  /// Retire tout les commentaires d'une chaine [xml]
  ///
  /// Exemple:
  ///```dart
  ///String xmlDecommente = XML.decommente("<!-- commentaire --><exemple>texte</exemple>");
  /// // "<exemple>texte</exemple>"
  ///```
  static String decommente(String xml) {
    List<String> allcomment = [];
    RegExp(r"<!--[^<>$]*-->").allMatches(xml).forEach((element) {
      allcomment.add(element[0]!);
    });
    for (var i = 0; i < allcomment.length; i++) {
      xml = xml.substring(0, xml.indexOf(allcomment.elementAt(i))) + xml.substring(xml.indexOf(allcomment.elementAt(i)) + allcomment.elementAt(i).length);
    }
    return xml;
  }

  /// Insert à une position précise un Objet dans un objet XML
  ///
  /// `/ : racine si mit au début de la chaine`
  ///
  /// `{node:$value} : position de l'insertion`
  ///
  /// `Valeur possible: {first;start;last;end;1;2;3;...}`
  ///
  /// Exemple:
  ///```dart
  ///String xml = '''
  ///<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <C/>
  ///    <D>texte 4</D>
  ///    <E/>
  ///    <E>texte 5</E>
  ///  </B>
  ///</A>'''
  ///List<Object> lstObj = XML.byString(Xml).insertAt("/A/B{node:2}/E/{node:end}",XML(baliseName: "objXML", type: XML.simple));
  ////*<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <C/>
  ///    <D>texte 4</D>
  ///    <E/>
  ///    <E>
  ///       texte 5
  ///       <objXML/>
  ///    </E>
  ///  </B>
  ///</A>*/
  ///```
  bool insertAt(String pattern, Object content) {
    int possub = 0;
    while (possub < pattern.length && pattern[possub] == ' ') {
      possub++;
    }
    pattern = pattern.substring(possub);
    List<String> lstbalise = pattern.split('/');
    if (lstbalise.elementAt(0) == "") {
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").elementAt(0) == balise) {
          if (lstbalise.elementAt(1).split("{").length == 2) {
            lstbalise.insert(2, "{" + lstbalise.elementAt(1).split("{").elementAt(1));
          }
          lstbalise.removeAt(1);
          lstbalise.removeAt(0);
          if (lstbalise.isNotEmpty) {
            String newpattern = "";
            for (int j = 1; j < lstbalise.length; j++) {
              newpattern += "/" + lstbalise[j];
            }
            List<String> lstbal = lstbalise.elementAt(0).split("{");
            if (lstbal.elementAt(0) == "") {
              lstbal.removeAt(0);
            }
            if (lstbal.length == 2) {
              late XML next;
              String node = lstbalise.elementAt(0).split("{").elementAt(1);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return false;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              if (pos < 1) {
                return false;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    next = (child.elementAt(i) as XML);
                    pos--;
                  }
                }
              }
              if (!(pos == 0 || pos > 999999)) {
                return false;
              }
              return next.insertAt("/" + next.balise + newpattern, content);
            } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
              late XML next;
              String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return false;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              int mempos = pos;
              if (pos < 1) {
                return false;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  next = (child.elementAt(i) as XML);
                  pos--;
                }
              }
              if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
                return false;
              }
              if (newpattern == "") {
                if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
                  child.add(content);
                  return true;
                } else if (type == XML.double) {
                  child.insert(mempos - 1, content);
                  return true;
                } else {
                  return false;
                }
              } else {
                return next.insertAt("/" + next.balise + newpattern, content);
              }
            } else {
              for (int i = 0; i < child.length; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    return (child.elementAt(i) as XML).insertAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern, content);
                  }
                }
              }
            }
          } else {
            child.add(content);
            return true;
          }
        } else {
          return false;
        }
      }
    } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains(balise)) {
      String newpattern = "";
      for (int j = 2; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").length == 2) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(1);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return false;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return false;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                next = (child.elementAt(i) as XML);
                pos--;
              }
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return false;
          }
          next.insertAt("/" + next.balise + newpattern, content);
        } else if (lstbalise.elementAt(1).split("{").elementAt(0).contains("}")) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(0);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return false;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return false;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return false;
          }
          next.insertAt("/" + next.balise + newpattern, content);
        } else {
          for (int i = 0; i < child.length; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                return (child.elementAt(i) as XML).insertAt("/" + lstbalise.elementAt(1).split("{").elementAt(0) + newpattern, content);
              }
            }
          }
        }
      } else {
        child.add(content);
        return true;
      }
    } else {
      String newpattern = "";
      for (int j = 1; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      List<String> lstbal = lstbalise.elementAt(0).split("{");
      if (lstbal.elementAt(0) == "") {
        lstbal.removeAt(0);
      }
      if (lstbal.length == 2) {
        late XML next;
        String node = lstbalise.elementAt(0).split("{").elementAt(1);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return false;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        if (pos < 1) {
          return false;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
        }
        if (!(pos == 0 || pos > 999999)) {
          return false;
        }
        return next.insertAt("/" + next.balise + newpattern, content);
      } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
        late XML next;
        String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return false;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        int mempos = pos;
        if (pos < 1) {
          return false;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            next = (child.elementAt(i) as XML);
            pos--;
          }
        }
        if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
          return false;
        }
        if (newpattern == "") {
          if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
            child.add(content);
            return true;
          } else if (type == XML.double) {
            child.insert(mempos - 1, content);
            return true;
          }
        } else {
          return next.insertAt("/" + next.balise + newpattern, content);
        }
      } else {
        bool contain = false;
        for (int i = 0; i < child.length && !contain; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              contain = true;
            }
          }
        }
        bool succes = false;
        if (contain) {
          for (int i = 0; i < child.length && !succes; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                succes = (child.elementAt(i) as XML).insertAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern, content);
              }
            }
          }
        } else {
          for (int i = 0; i < child.length && !succes; i++) {
            if (child.elementAt(i) is XML) {
              succes = (child.elementAt(i) as XML).insertAt(pattern, content);
            }
          }
        }
        return succes;
      }
    }
    return false;
  }

  /// Supprime à une position précise un Objet dans un objet XML
  ///
  /// `/ : racine si mit au début de la chaine`
  ///
  /// `{node:$value} : position de l'insertion`
  ///
  /// `Valeur possible: {first;start;last;end;1;2;3;...}`
  ///
  /// Exemple:
  ///```dart
  ///String xml = '''
  ///<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <C/>
  ///    <D>texte 4</D>
  ///    <E/>
  ///    <E>
  ///       texte 5
  ///       <objXML/>
  ///    </E>
  ///  </B>
  ///</A>'''
  ///List<Object> lstObj = XML.byString(Xml).removeAt("/A/B{node:2}/E/{node:end}");
  ////*<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <C/>
  ///    <D>texte 4</D>
  ///    <E/>
  ///    <E>texte 5</E>
  ///  </B>
  ///</A>*/
  ///```
  bool removeAt(String pattern) {
    int possub = 0;
    while (possub < pattern.length && pattern[possub] == ' ') {
      possub++;
    }
    pattern = pattern.substring(possub);
    List<String> lstbalise = pattern.split('/');
    if (lstbalise.elementAt(0) == "") {
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").elementAt(0) == balise) {
          if (lstbalise.elementAt(1).split("{").length == 2) {
            lstbalise.insert(2, "{" + lstbalise.elementAt(1).split("{").elementAt(1));
          }
          lstbalise.removeAt(1);
          lstbalise.removeAt(0);
          if (lstbalise.isNotEmpty) {
            String newpattern = "";
            for (int j = 1; j < lstbalise.length; j++) {
              newpattern += "/" + lstbalise[j];
            }
            List<String> lstbal = lstbalise.elementAt(0).split("{");
            if (lstbal.elementAt(0) == "") {
              lstbal.removeAt(0);
            }
            if (lstbal.length == 2) {
              late XML next;
              String node = lstbalise.elementAt(0).split("{").elementAt(1);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return false;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              if (pos < 1) {
                return false;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    next = (child.elementAt(i) as XML);
                    pos--;
                  }
                }
              }
              if (!(pos == 0 || pos > 999999)) {
                return false;
              }
              return next.removeAt("/" + next.balise + newpattern);
            } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
              late XML next;
              String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return false;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              int mempos = pos;
              if (pos < 1) {
                return false;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  next = (child.elementAt(i) as XML);
                  pos--;
                }
              }
              if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
                return false;
              }
              if (newpattern == "") {
                if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
                  //child.add(content);
                  child.removeAt(child.length - 1);
                  return true;
                } else if (type == XML.double) {
                  //child.insert(mempos - 1, content);
                  child.removeAt(mempos - 1);
                  return true;
                } else {
                  return false;
                }
              } else {
                return next.removeAt("/" + next.balise + newpattern);
              }
            } else {
              for (int i = 0; i < child.length; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    return (child.elementAt(i) as XML).removeAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern);
                  }
                }
              }
            }
          } else {
            child.removeAt(child.length - 1);
            return true;
          }
        } else {
          return false;
        }
      }
    } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains(balise)) {
      String newpattern = "";
      for (int j = 2; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").length == 2) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(1);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return false;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return false;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                next = (child.elementAt(i) as XML);
                pos--;
              }
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return false;
          }
          next.removeAt("/" + next.balise + newpattern);
        } else if (lstbalise.elementAt(1).split("{").elementAt(0).contains("}")) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(0);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return false;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return false;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return false;
          }
          next.removeAt("/" + next.balise + newpattern);
        } else {
          for (int i = 0; i < child.length; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                return (child.elementAt(i) as XML).removeAt("/" + lstbalise.elementAt(1).split("{").elementAt(0) + newpattern);
              }
            }
          }
        }
      } else {
        //child.add(content);
        child.removeAt(child.length - 1);
        return true;
      }
    } else {
      String newpattern = "";
      for (int j = 1; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      List<String> lstbal = lstbalise.elementAt(0).split("{");
      if (lstbal.elementAt(0) == "") {
        lstbal.removeAt(0);
      }
      if (lstbal.length == 2) {
        late XML next;
        String node = lstbalise.elementAt(0).split("{").elementAt(1);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return false;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        if (pos < 1) {
          return false;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
        }
        if (!(pos == 0 || pos > 999999)) {
          return false;
        }
        return next.removeAt("/" + next.balise + newpattern);
      } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
        late XML next;
        String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return false;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        int mempos = pos;
        if (pos < 1) {
          return false;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            next = (child.elementAt(i) as XML);
            pos--;
          }
        }
        if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
          return false;
        }
        if (newpattern == "") {
          if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
            //child.add(content);
            child.removeAt(child.length - 1);
            return true;
          } else if (type == XML.double) {
            //child.insert(mempos, content);
            child.removeAt(mempos - 1);
            return true;
          }
        } else {
          return next.removeAt("/" + next.balise + newpattern);
        }
      } else {
        bool contain = false;
        for (int i = 0; i < child.length && !contain; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              contain = true;
            }
          }
        }
        bool succes = false;
        if (contain) {
          for (int i = 0; i < child.length && !succes; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                succes = (child.elementAt(i) as XML).removeAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern);
              }
            }
          }
        } else {
          for (int i = 0; i < child.length && !succes; i++) {
            if (child.elementAt(i) is XML) {
              succes = (child.elementAt(i) as XML).removeAt(pattern);
            }
          }
        }
        return succes;
      }
    }
    return false;
  }

  /// Retourne la valeur d' Objet à une position précise dans un objet XML
  ///
  /// `/` : racine si mit au début de la chaine
  ///
  /// `{node:$value}` : position de l'insertion
  ///
  /// `Valeur possible`: {first;start;last;end;1;2;3;...}
  ///
  /// Exemple:
  ///```dart
  ///String xml = '''
  ///<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <C/>
  ///    <D>texte 4</D>
  ///    <E/>
  ///    <E>
  ///       texte 5
  ///       <objXML/>
  ///    </E>
  ///  </B>
  ///</A>'''
  ///var obj = XML.byString(Xml).elementAt("/A/B{node:2}/E/{node:end}");
  ///// <objXML/>
  ///```
  Object elementAt(String pattern) {
    int possub = 0;
    while (possub < pattern.length && pattern[possub] == ' ') {
      possub++;
    }
    pattern = pattern.substring(possub);
    List<String> lstbalise = pattern.split('/');
    if (lstbalise.elementAt(0) == "") {
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").elementAt(0) == balise) {
          if (lstbalise.elementAt(1).split("{").length == 2) {
            lstbalise.insert(2, "{" + lstbalise.elementAt(1).split("{").elementAt(1));
          }
          lstbalise.removeAt(1);
          lstbalise.removeAt(0);
          if (lstbalise.isNotEmpty) {
            String newpattern = "";
            for (int j = 1; j < lstbalise.length; j++) {
              newpattern += "/" + lstbalise[j];
            }
            List<String> lstbal = lstbalise.elementAt(0).split("{");
            if (lstbal.elementAt(0) == "") {
              lstbal.removeAt(0);
            }
            if (lstbal.length == 2) {
              late XML next;
              String node = lstbalise.elementAt(0).split("{").elementAt(1);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return Null;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              if (pos < 1) {
                return Null;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    next = (child.elementAt(i) as XML);
                    pos--;
                  }
                }
              }
              if (!(pos == 0 || pos > 999999)) {
                return Null;
              }
              return next.elementAt("/" + next.balise + newpattern);
            } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
              late XML next;
              String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return Null;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              int mempos = pos;
              if (pos < 1) {
                return Null;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  next = (child.elementAt(i) as XML);
                  pos--;
                }
              }
              if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
                return Null;
              }
              if (newpattern == "") {
                if ((mempos > 999999 || child.isNotEmpty) && type == XML.double) {
                  return child.elementAt(child.length - 1);
                } else if (type == XML.double && child.isNotEmpty) {
                  return child.elementAt(mempos - 1);
                } else {
                  return Null;
                }
              } else {
                return next.elementAt("/" + next.balise + newpattern);
              }
            } else {
              for (int i = 0; i < child.length; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    return (child.elementAt(i) as XML).elementAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern);
                  }
                }
              }
            }
          } else {
            return child.elementAt(child.length - 1);
          }
        } else {
          return Null;
        }
      }
    } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains(balise)) {
      String newpattern = "";
      for (int j = 2; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").length == 2) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(1);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return Null;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return Null;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                next = (child.elementAt(i) as XML);
                pos--;
              }
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return Null;
          }
          next.removeAt("/" + next.balise + newpattern);
        } else if (lstbalise.elementAt(1).split("{").elementAt(0).contains("}")) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(0);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return Null;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return Null;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return Null;
          }
          return next.elementAt("/" + next.balise + newpattern);
        } else {
          for (int i = 0; i < child.length; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                return (child.elementAt(i) as XML).elementAt("/" + lstbalise.elementAt(1).split("{").elementAt(0) + newpattern);
              }
            }
          }
        }
      } else {
        return child.elementAt(child.length - 1);
      }
    } else {
      String newpattern = "";
      for (int j = 1; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      List<String> lstbal = lstbalise.elementAt(0).split("{");
      if (lstbal.elementAt(0) == "") {
        lstbal.removeAt(0);
      }
      if (lstbal.length == 2) {
        late XML next;
        String node = lstbalise.elementAt(0).split("{").elementAt(1);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return Null;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        if (pos < 1) {
          return Null;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
        }
        if (!(pos == 0 || pos > 999999)) {
          return Null;
        }
        return next.elementAt("/" + next.balise + newpattern);
      } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
        late XML next;
        String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return Null;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        int mempos = pos;
        if (pos < 1) {
          return Null;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            next = (child.elementAt(i) as XML);
            pos--;
          }
        }
        if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
          return Null;
        }
        if (newpattern == "") {
          if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
            return child.elementAt(child.length - 1);
          } else if (type == XML.double) {
            return child.elementAt(mempos - 1);
          }
        } else {
          return next.elementAt("/" + next.balise + newpattern);
        }
      } else {
        bool contain = false;
        for (int i = 0; i < child.length && !contain; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              contain = true;
            }
          }
        }
        Object succes = Null;
        if (contain) {
          for (int i = 0; i < child.length && succes == Null; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                succes = (child.elementAt(i) as XML).removeAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern);
              }
            }
          }
        } else {
          for (int i = 0; i < child.length && succes == Null; i++) {
            if (child.elementAt(i) is XML) {
              succes = (child.elementAt(i) as XML).removeAt(pattern);
            }
          }
        }
        return succes;
      }
    }
    return Null;
  }

  /// Retourne la valeur d' Objet à une position précise dans un objet XML
  ///
  /// `/` : racine si mit au début de la chaine
  ///
  /// `{node:$value}` : position de l'insertion
  ///
  /// `Valeur possible`: {first;start;last;end;1;2;3;...}
  ///
  /// Exemple:
  ///```dart
  ///String xml = '''
  ///<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <C/>
  ///    <D>texte 4</D>
  ///    <E/>
  ///    <E>
  ///       texte 5
  ///       <objXML/>
  ///    </E>
  ///  </B>
  ///</A>'''
  ///var obj = XML.byString(Xml).elementAt("/A/B{node:2}/E/{node:end}");
  ///// <objXML/>
  ///```
  bool setAt(String pattern, Object content) {
    int possub = 0;
    while (possub < pattern.length && pattern[possub] == ' ') {
      possub++;
    }
    pattern = pattern.substring(possub);
    List<String> lstbalise = pattern.split('/');
    if (lstbalise.elementAt(0) == "") {
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").elementAt(0) == balise) {
          if (lstbalise.elementAt(1).split("{").length == 2) {
            lstbalise.insert(2, "{" + lstbalise.elementAt(1).split("{").elementAt(1));
          }
          lstbalise.removeAt(1);
          lstbalise.removeAt(0);
          if (lstbalise.isNotEmpty) {
            String newpattern = "";
            for (int j = 1; j < lstbalise.length; j++) {
              newpattern += "/" + lstbalise[j];
            }
            List<String> lstbal = lstbalise.elementAt(0).split("{");
            if (lstbal.elementAt(0) == "") {
              lstbal.removeAt(0);
            }
            if (lstbal.length == 2) {
              late XML next;
              String node = lstbalise.elementAt(0).split("{").elementAt(1);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return false;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              if (pos < 1) {
                return false;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    next = (child.elementAt(i) as XML);
                    pos--;
                  }
                }
              }
              if (!(pos == 0 || pos > 999999)) {
                return false;
              }
              return next.setAt("/" + next.balise + newpattern, content);
            } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
              late XML next;
              String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
              if (node.split(":").length == 2) {
                node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
              } else {
                return false;
              }
              int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
              int mempos = pos;
              if (pos < 1) {
                return false;
              }
              for (int i = 0; i < child.length && pos != 0; i++) {
                if (child.elementAt(i) is XML) {
                  next = (child.elementAt(i) as XML);
                  pos--;
                }
              }
              if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
                return false;
              }
              if (newpattern == "") {
                if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
                  child[child.length - 1] = content;
                  return true;
                } else if (type == XML.double) {
                  child[mempos - 1] = content;
                  return true;
                } else {
                  return false;
                }
              } else {
                return next.setAt("/" + next.balise + newpattern, content);
              }
            } else {
              for (int i = 0; i < child.length; i++) {
                if (child.elementAt(i) is XML) {
                  if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                    return (child.elementAt(i) as XML).setAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern, content);
                  }
                }
              }
            }
          } else {
            child[child.length - 1] = content;
            return true;
          }
        } else {
          return false;
        }
      }
    } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains(balise)) {
      String newpattern = "";
      for (int j = 2; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      if (lstbalise.length > 1) {
        if (lstbalise.elementAt(1).split("{").length == 2) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(1);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return false;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return false;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                next = (child.elementAt(i) as XML);
                pos--;
              }
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return false;
          }
          next.removeAt("/" + next.balise + newpattern);
        } else if (lstbalise.elementAt(1).split("{").elementAt(0).contains("}")) {
          late XML next;
          String node = lstbalise.elementAt(1).split("{").elementAt(0);
          if (node.split(":").length == 2) {
            node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
          } else {
            return false;
          }
          int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
          if (pos < 1) {
            return false;
          }
          for (int i = 0; i < child.length && pos != 0; i++) {
            if (child.elementAt(i) is XML) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
          if (!(pos == 0 || pos > 999999)) {
            return false;
          }
          return next.setAt("/" + next.balise + newpattern, content);
        } else {
          for (int i = 0; i < child.length; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(1).split("{").elementAt(0))) {
                return (child.elementAt(i) as XML).setAt("/" + lstbalise.elementAt(1).split("{").elementAt(0) + newpattern, content);
              }
            }
          }
        }
      } else {
        child[child.length - 1] = content;
        return true;
      }
    } else {
      String newpattern = "";
      for (int j = 1; j < lstbalise.length; j++) {
        newpattern += "/" + lstbalise[j];
      }
      List<String> lstbal = lstbalise.elementAt(0).split("{");
      if (lstbal.elementAt(0) == "") {
        lstbal.removeAt(0);
      }
      if (lstbal.length == 2) {
        late XML next;
        String node = lstbalise.elementAt(0).split("{").elementAt(1);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return false;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        if (pos < 1) {
          return false;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              next = (child.elementAt(i) as XML);
              pos--;
            }
          }
        }
        if (!(pos == 0 || pos > 999999)) {
          return false;
        }
        return next.setAt("/" + next.balise + newpattern, content);
      } else if (lstbalise.elementAt(0).split("{").elementAt(0).contains("}") || lstbal.elementAt(0).contains("}")) {
        late XML next;
        String node = (lstbal.length != 1) ? lstbalise.elementAt(1).split("{").elementAt(0) : lstbal.elementAt(0);
        if (node.split(":").length == 2) {
          node = node.split(":").elementAt(1).substring(0, node.split(":").elementAt(1).length - 1);
        } else {
          return false;
        }
        int pos = (node == "start" || node == "first" || node == "1") ? 1 : ((node == "end" || node == "last") ? 999999999 : int.parse(node));
        int mempos = pos;
        if (pos < 1) {
          return false;
        }
        for (int i = 0; i < child.length && pos != 0; i++) {
          if (child.elementAt(i) is XML) {
            next = (child.elementAt(i) as XML);
            pos--;
          }
        }
        if (!((pos == 0 || pos > 999999) || !(pos != mempos))) {
          return false;
        }
        if (newpattern == "") {
          if ((mempos > 999999 || child.isEmpty) && type == XML.double) {
            child[child.length - 1] = content;
            return true;
          } else if (type == XML.double) {
            child[mempos - 1] = content;
            return true;
          }
        } else {
          return next.setAt("/" + next.balise + newpattern, content);
        }
      } else {
        bool contain = false;
        for (int i = 0; i < child.length && !contain; i++) {
          if (child.elementAt(i) is XML) {
            if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
              contain = true;
            }
          }
        }
        bool succes = false;
        if (contain) {
          for (int i = 0; i < child.length && !succes; i++) {
            if (child.elementAt(i) is XML) {
              if ((child.elementAt(i) as XML).balise.contains(lstbalise.elementAt(0).split("{").elementAt(0))) {
                succes = (child.elementAt(i) as XML).removeAt("/" + lstbalise.elementAt(0).split("{").elementAt(0) + newpattern);
              }
            }
          }
        } else {
          for (int i = 0; i < child.length && !succes; i++) {
            if (child.elementAt(i) is XML) {
              succes = (child.elementAt(i) as XML).removeAt(pattern);
            }
          }
        }
        return succes;
      }
    }
    return false;
  }

  /// Retourne une liste d'Objet correspondant au pattern donné
  ///
  /// Exemple:
  ///```dart
  ///String xml = '''
  ///<?xml version="1.0" encoding="UTF-8"?>
  ///<A>
  ///  <B>
  ///    <C>texte 1</C>
  ///    <C>texte 2</C>
  ///  </B>
  ///  <B>
  ///    <C>texte 3</C>
  ///    <D>texte 4</D>
  ///  </B>
  ///</A>'''
  ///List<Object> lstObj = XML.byString(Xml).allMatches("/A/B/C");
  /// // {texte 1,texte 2,texte 3}
  ///```
  List<Object> allMatches(String pattern) {
    int pos = 0;
    while (pos < pattern.length && pattern[pos] == ' ') {
      pos++;
    }
    pattern = pattern.substring(pos);
    List<String> lstbalise = pattern.split('/');
    if (lstbalise.isNotEmpty && pattern != "") {
      List<Object> lstOfMatches = [];
      if (lstbalise[0] != "") {
        if (lstbalise[0].contains(balise)) {
          String newBaliseSequence = "";
          for (var i = 1; i < lstbalise.length; i++) {
            newBaliseSequence += "/" + lstbalise[i];
          }
          if (newBaliseSequence != "") {
            for (var i = 0; i < child.length; i++) {
              if (child[i] is XML) {
                lstOfMatches += (child[i] as XML).allMatches(newBaliseSequence);
              }
            }
          } else {
            for (var i = 0; i < child.length; i++) {
              lstOfMatches.add(child[i]);
            }
          }
        } else {
          for (var i = 0; i < child.length; i++) {
            if (child[i] is XML) {
              //lstOfMatches = List.from((child[i] as XML).allMatches(pattern));
              lstOfMatches += (child[i] as XML).allMatches(pattern);
            }
          }
        }
      } else {
        lstbalise.removeAt(0);
        if (lstbalise.isNotEmpty) {
          if (lstbalise[0].contains(balise)) {
            String newBaliseSequence = "";
            for (var i = 1; i < lstbalise.length; i++) {
              newBaliseSequence += "/" + lstbalise[i];
            }
            if (newBaliseSequence != "") {
              for (var i = 0; i < child.length; i++) {
                if (child[i] is XML) {
                  lstOfMatches += (child[i] as XML).allMatches(newBaliseSequence);
                }
              }
            } else {
              for (var i = 0; i < child.length; i++) {
                lstOfMatches.add(child[i]);
              }
            }
          }
        }
      }
      return lstOfMatches;
    } else {
      return List.empty();
    }
  }

  /// Convertir en String un objet XML
  @override
  String toString() {
    String xml = "";
    if (property.isNotEmpty) {
      xml += "<?xml";
      property.forEach((key, value) {
        xml += " " + key + "=\"" + value + "\"";
      });
      xml += "?>";
    }

    if (balise == "") {
      if (child.isNotEmpty) {
        xml += child.elementAt(0).toString();
      }
    } else {
      xml += "<" + balise;
      if (_type == simple) {
        attribut.forEach((key, value) {
          xml += " " + key + "=\"" + value + "\"";
        });
        xml += "/>";
      } else {
        attribut.forEach((key, value) {
          xml += " " + key + "=\"" + value + "\"";
        });
        xml += ">";
        for (var i = 0; i < child.length; i++) {
          if (child.elementAt(i) is XML) {
            xml += child.elementAt(i).toString();
          } else if (child.elementAt(i) is String) {
            xml += child.elementAt(i).toString();
          }
        }
        xml += "</" + balise + ">";
      }
    }
    return xml;
  }
}
