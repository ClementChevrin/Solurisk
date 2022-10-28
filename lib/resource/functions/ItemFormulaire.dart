import 'dart:convert';
import 'Defibrilateur.dart';

class ItemFormulaire {
  /// Défini une card de type Titre
  static const int title = 1;

  /// Défini une card de type saisis d'image
  static const int picture = 2;

  ///Défini une card de type signature
  static const int sign = 3;

  /// Défini une card de type bouton dropdown
  static const int dropdown = 4;

  /// Défini une card de type toggle oui/non avec descriptif
  static const int yesno = 5;

  /// Défini une card de type toggle avec oui/non/nul avec descriptif
  static const int yesnonull = 6;

  /// Défini une card de type peremption avec descriptif
  static const int peremption = 7;

  late final int? type;
  late final String? titlecard;
  late final List<String>? itemListe;
  ItemFormulaire({required this.type, this.titlecard, this.itemListe}) : assert(true);

  /// Instancie un objet [ItemFormulaire] à partir d'un [Map]
  factory ItemFormulaire.fromJson(dynamic json) {
    return ItemFormulaire(
      type: json['type'] as int,
      titlecard: (json['titlecard'] != null) ? json['titlecard'] as String : null,
      itemListe: (json['itemListe'] != null) ? json['itemListe'] as List<String> : null,
    );
  }

  /// Convertie une classe [ItemFormulaire] en Json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'titlecard': titlecard,
      'itemListe': itemListe,
    };
  }

  /// Instancie un objet [ItemFormulaire] à partir d'un [String] json
  factory ItemFormulaire.fromString(String json) {
    return ItemFormulaire.fromJson(jsonDecode(json));
  }

  /// Renvoie une chaine contenant un Json de l'objet
  @override
  String toString() {
    return jsonEncode(toJson());
  }

  /// Convertie une [List] de json au format [String] en [List][ItemFormulaire]
  static List<ItemFormulaire> fromStringToList(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>).map((item) => ItemFormulaire.fromJson(item)).toList();
  }

  /// Convertie une [List][ItemFormulaire] en [List] de json au format [String]
  static String listToString(List<ItemFormulaire> listEntreprise) {
    List<String> lst = listEntreprise.map((item) => item.toString()).toList();
    return lst.toString();
  }
}
