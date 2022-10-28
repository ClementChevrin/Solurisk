import 'package:solurisk/resource/functions/Defibrilateur.dart';
import 'dart:convert';

class Entreprise {
  /// Diponibilité événementielle
  static List<String> dispJoursEvenement = [];

  /// Disponibilité 7 jours sur 7
  static List<String> dispJours7 = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];

  /// Disponibilité 24 heures sur 24
  static String dispHeures24 = "24H/24";

  /// Disponibilité heures ouvrables
  static String dispHeuresOuvrables = "Heures ouvrables";

  // Nom du client
  final String nomDuClientQuiSousTraite;
  // Information du client du client
  final String nom;
  final String? raisonSocial;
  final String siret;
  final String? siren;
  final double? latitude;
  final double? longitude;
  final List<String>? disponibiliteJours;
  final String? disponibiliteHeures;
  final String? telephone1;
  final String? telephone2;
  final String? mail;
  final Defibrilateur? defibrilateur;

  Entreprise({required this.nomDuClientQuiSousTraite, required this.nom, this.raisonSocial, required this.siret, this.siren, this.latitude, this.longitude, this.disponibiliteJours, this.disponibiliteHeures, this.telephone1, this.telephone2, this.mail, this.defibrilateur});

  /// Instancie un objet [Entreprise] à partir d'un [Map]
  factory Entreprise.fromJson(dynamic json) {
    return Entreprise(
        nomDuClientQuiSousTraite: json['nomDuClientQuiSousTraite'] as String,
        nom: json['nom'] as String,
        raisonSocial: (json['raisonSocial'] != null) ? json['raisonSocial'] as String : null,
        siret: json['siret'] as String,
        siren: (json['siren'] != null) ? json['siren'] as String : null,
        latitude: (json['latitude'] != null) ? json['latitude'] as double : null,
        longitude: (json['longitude'] != null) ? json['longitude'] as double : null,
        disponibiliteJours: (json['disponibiliteJours'] != null) ? (json['disponibiliteJours'] as List).map((item) => item as String).toList() : null,
        disponibiliteHeures: (json['disponibiliteHeures'] != null) ? json['disponibiliteHeures'] as String : null,
        telephone1: (json['telephone1'] != null) ? json['telephone1'] as String : null,
        telephone2: (json['telephone2'] != null) ? json['telephone2'] as String : null,
        mail: (json['mail'] != null) ? json['mail'] as String : null,
        defibrilateur: (json['defibrilateur'] != "null") ? Defibrilateur.fromString(json['defibrilateur'] as String) : null);
  }

  /// Instancie un objet [Entreprise] à partir d'un [String] json
  factory Entreprise.fromString(String json) {
    return Entreprise.fromJson(jsonDecode(json));
  }

  /// Convertie une classe [Entreprise] en Json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "nomDuClientQuiSousTraite": nomDuClientQuiSousTraite,
      "nom": nom,
      "raisonSocial": raisonSocial,
      "siret": siret,
      "siren": siren,
      "latitude": latitude,
      "longitude": longitude,
      "disponibiliteJours": disponibiliteJours,
      "disponibiliteHeures": disponibiliteHeures,
      "telephone1": telephone1,
      "telephone2": telephone2,
      "mail": mail,
      "defibrilateur": (defibrilateur != Null) ? jsonEncode(defibrilateur?.toJson()) : null,
    };
  }

  /// Renvoie une chaine contenant un Json de l'objet
  @override
  String toString() {
    return jsonEncode(toJson());
  }

  /// Convertie une [List] de json au format [String] en [List][Entreprise]
  static List<Entreprise> fromStringToList(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>).map((item) => Entreprise.fromJson(item)).toList();
  }

  /// Convertie une [List][Entreprise] en [List] de json au format [String]
  static String listToString(List<Entreprise> listEntreprise) {
    List<String> lst = listEntreprise.map((item) => item.toString()).toList();
    return lst.toString();
  }

  static List<Defibrilateur?> extractAllDefibrilateur(List<Entreprise> lstEnt) {
    return lstEnt.map((item) => item.defibrilateur).toList();
  }
}
