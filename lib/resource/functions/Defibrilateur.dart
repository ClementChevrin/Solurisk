import 'dart:convert';

class Defibrilateur {
  static int enFonctionnement = 1;
  static int aLarret = 2;
  static int interieur = 1;
  static int exterieur = 2;
  String? nom;
  String? numero;
  String? modele;
  String? type;
  int? accessibilite;
  int? status;
  String? datePose;
  Defibrilateur({this.nom, this.numero, this.modele, this.type, this.accessibilite, this.status, this.datePose});

  /// Instancie un objet [Defibrilateur] à partir d'un [Map]
  factory Defibrilateur.fromJson(dynamic json) {
    return Defibrilateur(nom: json['nom'] as String, numero: json['numero'] as String, modele: json['modele'] as String, type: json['type'] as String, accessibilite: json['accessibilite'] as int, status: json['status'] as int, datePose: json['datePose'] as String);
  }

  /// Convertie une classe [Defibrilateur] en Json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nom': nom,
      'numero': numero,
      'modele': modele,
      'type': type,
      'accessibilite': accessibilite,
      'status': status,
      'datePose': datePose,
    };
  }

  /// Instancie un objet [Defibrilateur] à partir d'un [String] json
  factory Defibrilateur.fromString(String json) {
    return Defibrilateur.fromJson(jsonDecode(json));
  }

  /// Renvoie une chaine contenant un Json de l'objet
  @override
  String toString() {
    return jsonEncode(toJson());
  }

  /// Convertie une [List] de json au format [String] en [List][Defibrilateur]
  static List<Defibrilateur> fromStringToList(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>).map((item) => Defibrilateur.fromJson(item)).toList();
  }

  /// Convertie une [List][Defibrilateur] en [List] de json au format [String]
  static String listToString(List<Defibrilateur> listDefibrilateur) {
    List<String> lst = listDefibrilateur.map((item) => item.toString()).toList();
    return lst.toString();
  }
}
