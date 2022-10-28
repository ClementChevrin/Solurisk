import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solurisk/resource/functions/ItemFormulaire.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../resource/functions/Defibrilateur.dart';
import '../../../resource/functions/Entreprise.dart';
import '../../../resource/functions/ItemFormulaire.dart';
import '../../../resource/sources/string.dart';
import '../../../resource/themes/theme.dart';
import '../../../resource/widgets/DatePicker.dart';
import '../../../resource/widgets/Dropdown.dart';
import '../../../resource/widgets/SwitchableButton.dart';
import '../../../resource/widgets/Formulaire.dart';
import 'package:flutter/services.dart';

class TroisFrag extends StatefulWidget {
  const TroisFrag({Key? key}) : super(key: key);
  @override
  TroisFragPage createState() => TroisFragPage();
}

class TroisFragPage extends State<TroisFrag> {
  final String editorName = "Aurélien BERNA";
  late final List<Entreprise> listEntreprise;
  late final List<ItemFormulaire> listItemFormulaire;
  final String soussigne = "";

  /// Liste des images du formulaire
  List<File?> image = [];

  /// Signature du formulaire
  ///final signatureGlobalKey = GlobalKey<SfSignaturePadState>();

  /// Liste des identifiants de chaque zone de texte
  List<TextEditingController> idTextFields = [];

  /// Liste des identifiants de chaque bouton toggle
  List<TextEditingController> idButton = [];

  /// Liste des identifiants de chaque bouton dropdown
  List<TextEditingController> idDropdown = [];

  /// Liste des Cards utilisées pour le formulaire
  List<Card> formulaireItem = [];

  @override
  void initState() {
    super.initState();
    listEntreprise = [
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Monceau Sur Oise",
        nom: "Monceau Sur Oise Salle Des Fetes",
        raisonSocial: "Commune De Monceau Sur Oise",
        siret: "21020471500010",
        siren: "210204715",
        latitude: 49.90211443663989,
        longitude: 3.6962831210394045,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33605348136",
        telephone2: "+33323627989",
        mail: "monceausuroise@wanadoo.fr",
        defibrilateur: Defibrilateur(nom: "DAE MONCEAU SUR OISE SALLE DES FETES", numero: "AE9-9B000575", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/08/27"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Sms",
        nom: "Volvo Truck Gauchy",
        raisonSocial: "Volvo Trucks France",
        siret: "37913416600840",
        siren: "379134166",
        latitude: 49.81541066243224,
        longitude: 3.3025910855551976,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi "],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323627989",
        telephone2: "+33323580732",
        mail: "contact@volvo.com",
        defibrilateur: Defibrilateur(nom: "DAE VOLVO TRUCK GAUCHY", numero: "AE9-9B000567", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/09/06"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Htd",
        nom: "Brasserie De L'astree Le Nouvion En Thierache",
        raisonSocial: "H.T.D",
        siret: "83767416700015",
        siren: "837674167",
        latitude: 50.00886845210755,
        longitude: 3.781641771273663,
        disponibiliteJours: ["Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323580732",
        telephone2: "+33323611313",
        mail: "hennechart.thomas@gmail.com",
        defibrilateur: Defibrilateur(nom: "DAE BRASSERIE DE L'ASTREE LE NOUVION EN THIERACHE", numero: "AE9-9B000558", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/09/14"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Flavigny Le G Et B",
        nom: "Flavigny Le Grand Et Beaurain Ecole Mairie",
        raisonSocial: "Commune De Flavigny Le Grand Et Beaurain",
        siret: "21020295800018",
        siren: "210202958",
        latitude: 49.89404433792138,
        longitude: 3.666188257776152,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323611313",
        telephone2: "+33323611313",
        mail: "flavigny.beaurain@orange.fr",
        defibrilateur: Defibrilateur(nom: "DAE FLAVIGNY LE GRAND ET BEAURAIN ECOLE MAIRIE", numero: "AE9-9B000571", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/06"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Flavigny Le G Et B",
        nom: "Flavigny Le Grand Et Beaurain Ecole Beaurain",
        raisonSocial: "Commune De Flavigny Le Grand Et Beaurain",
        siret: "21020295800018",
        siren: "210202958",
        latitude: 49.88289259553534,
        longitude: 3.6740969923716245,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323611313",
        telephone2: "+33323618080",
        mail: "flavigny.beaurain@orange.fr",
        defibrilateur: Defibrilateur(nom: "DAE FLAVIGNY LE GRAND ET BEAURAIN ECOLE BEAURAIN", numero: "AE9-9B000572", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/06"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Eglise Saint Pierre",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.89879643608707,
        longitude: 3.624500371547677,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323610614",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE EGLISE SAINT PIERRE", numero: "AE9-9B000566", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Cinema Vvox",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.89888496894366,
        longitude: 3.6276844406236153,
        disponibiliteJours: Entreprise.dispJoursEvenement,
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323610614",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE CINEMA Vvox", numero: "AE9-9B000559", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Salle Beauval",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.89988982719647,
        longitude: 3.6312999703389535,
        disponibiliteJours: Entreprise.dispJoursEvenement,
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE SALLE BEAUVAL", numero: "AE9-9B000604", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Ecole Du Centre Primaire Du Centre",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.89814734802202,
        longitude: 3.6285273027576466,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE ECOLE DU CENTRE PRIMAIRE DU CENTRE", numero: "AE9-9B000673", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Ecole Du Centre Maternelle Du Centre",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.89840556429348,
        longitude: 3.629650583205779,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE ECOLE DU CENTRE MATERNELLE DU CENTRE", numero: "AE9-9B000677", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Ecole Du Centre Primaire Schweitzer",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.893656924282524,
        longitude: 3.6356500230592554,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE ECOLE DU CENTRE PRIMAIRE SCHWEITZER", numero: "AE9-9B000646", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Ecole Du Centre Primaire Godin",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.903610187354595,
        longitude: 3.6252093243962986,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE ECOLE DU CENTRE PRIMAIRE GODIN", numero: "AE9-9B000647", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Guise Salle Des Fetes",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.89852309976407,
        longitude: 3.627793468363625,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323618080",
        telephone2: "+33323610703",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE GUISE SALLE DES FETES", numero: "AE9-9B000606", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/10/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Vadencourt",
        nom: "Salle Des Fetes Vadencourt",
        raisonSocial: "Commune De Vadencourt",
        siret: "21020730400010",
        siren: "210207304",
        latitude: 49.92826962643997,
        longitude: 3.577797904206126,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323610703",
        telephone2: "+33323602162",
        mail: "mairie.vadencourt@orange.fr",
        defibrilateur: Defibrilateur(nom: "DAE SALLE DES FETES VADENCOURT", numero: "AE9-9B000763", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/11/16"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Chigny",
        nom: "Salle Des Fetes De Chigny",
        raisonSocial: "Commune De Chigny",
        siret: "21020175200016",
        siren: "210201752",
        latitude: 49.91777296313083,
        longitude: 3.7697217855231417,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323602162",
        telephone2: "+33323610002",
        mail: "mairie.chigny@wanadoo.fr",
        defibrilateur: Defibrilateur(nom: "DAE SALLE DES FETES DE CHIGNY", numero: "AE9-9B000525", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/11/25"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Ogec Ecole Jeanne D'arc Guise",
        nom: "Ecole Jeanne D'arc Guise",
        raisonSocial: "Ogec Ecole Jeanne D Arc",
        siret: "78018782900012",
        siren: "780187829",
        latitude: 49.90274602948959,
        longitude: 3.6257206482863564,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323610002",
        telephone2: "+33323613536",
        mail: "jeanne.arc.secretariat@wanadoo.fr",
        defibrilateur: Defibrilateur(nom: "DAE ECOLE JEANNE D'ARC GUISE", numero: "AE9-9B000441", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/12/15"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Syndicat Mixte Du Familistere Godin",
        nom: "Theatre Godin Guise",
        raisonSocial: "Syndicat Mixte Du Familistere Godin",
        siret: "25020872500011",
        siren: "250208725",
        latitude: 49.90368313724407,
        longitude: 3.62550638877782,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323613536",
        telephone2: "+33323610660",
        mail: "marieblot@familistere.com",
        defibrilateur: Defibrilateur(nom: "DAE THEATRE GODIN GUISE", numero: "AE9-9B000620", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2021/12/15"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Proix",
        nom: "Salle Des Fetes Proix",
        raisonSocial: "Commune De Proix",
        siret: "21020600900016",
        siren: "210206009",
        latitude: 49.9015867426334,
        longitude: 3.5670082513917767,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323610660",
        telephone2: "+33323515555",
        mail: "proix@orange.fr",
        defibrilateur: Defibrilateur(nom: "DAE SALLE DES FETES PROIX", numero: "AE9-9B000706", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/12/15"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Centre Hospitalier De Guise",
        nom: "Centre Hospitalier De Guise",
        raisonSocial: "Centre Hospitalier De Guise",
        siret: "26020865700015",
        siren: "260208657",
        latitude: 49.90269048288433,
        longitude: 3.6400219529737194,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323515555",
        telephone2: "+33323515555",
        mail: "accueil.urgences@ch-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE CH GUISE", numero: "AE9-9B000577", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2021/12/17"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Sery Les Mezieres",
        nom: "Sery Les Mezieres Mairie",
        raisonSocial: "Commune De Sery Les Mezieres",
        siret: "21020690000016",
        siren: "210206900",
        latitude: 49.773836,
        longitude: 3.418819,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33323515555",
        telephone2: "+33323667102",
        mail: "mairie.serylesmezieres@wanadoo.fr",
        defibrilateur: Defibrilateur(nom: "DAE SERY LES MEZIERES MAIRIE", numero: "AE9-18001223", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2022/04/04"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Sms",
        nom: "Ecole Notre Dame Saint Quentin",
        raisonSocial: "Ogec Externat Notre Dame",
        siret: "78022117200015",
        siren: "780221172",
        latitude: 49.84431464372994,
        longitude: 3.288704396803203,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323667102",
        telephone2: "+33971227917",
        mail: "contact@externatnotredame02.fr",
        defibrilateur: Defibrilateur(nom: "DAE ECOLE NOTRE DAME SAINT QUENTIN", numero: "AE9-22002288", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2022/05/11"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Malzy",
        nom: "Malzy Salle Des Fetes",
        raisonSocial: "Commune De Malzy",
        siret: "21020432700014",
        siren: "210204327",
        latitude: 49.90658545313425,
        longitude: 3.7285483635504866,
        disponibiliteJours: Entreprise.dispJours7,
        disponibiliteHeures: Entreprise.dispHeures24,
        telephone1: "+33971227917",
        telephone2: "+33323602595",
        mail: "malzy@orange.fr",
        defibrilateur: Defibrilateur(nom: "DAE MALZY SALLE DES FETES", numero: "AE922002249", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.exterieur, status: Defibrilateur.enFonctionnement, datePose: "2022/07/29"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Eurl Hmc",
        nom: "Eurl Macarez Salle Jonnecourt ",
        raisonSocial: "Eurl Hmc",
        siret: "45185226300016",
        siren: "451852263",
        latitude: 49.968339113719146,
        longitude: 3.4134419895623673,
        disponibiliteJours: Entreprise.dispJoursEvenement,
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323602595",
        telephone2: "+33683844639",
        mail: "receptionjonnecourt@orange.fr",
        defibrilateur: Defibrilateur(nom: "DAE EURL MACAREZ SALLE JONNECOURT ", numero: "AE9-18001172", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2022/04/13"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Mairie Guise",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.897982143347456,
        longitude: 3.6250740694243717,
        disponibiliteJours: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33683844639",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE MAIRIE GUISE", numero: "AE9-18001225", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2022/04/04"),
      ),
      Entreprise(
        nomDuClientQuiSousTraite: "Commune De Guise",
        nom: "Eglise Saint Medard Guise",
        raisonSocial: "Commune De Guise",
        siret: "21020342800011",
        siren: "210203428",
        latitude: 49.898561,
        longitude: 3.633369,
        disponibiliteJours: Entreprise.dispJoursEvenement,
        disponibiliteHeures: Entreprise.dispHeuresOuvrables,
        telephone1: "+33323618080",
        telephone2: "+33323618080",
        mail: "accueil-mairie@ville-guise.fr",
        defibrilateur: Defibrilateur(nom: "DAE EGLISE SAINT MEDARD GUISE", numero: "AE9-18001148", modele: "Mindray", type: "Beneheart C2 Full Automatique", accessibilite: Defibrilateur.interieur, status: Defibrilateur.enFonctionnement, datePose: "2022/04/04"),
      ),
    ];
    listItemFormulaire = [
      ItemFormulaire(
        type: ItemFormulaire.title,
        titlecard: "Fiche d'intervention - Maintenance annuelle DAE",
      ),
      ItemFormulaire(
        type: ItemFormulaire.dropdown,
        titlecard: "Client",
        itemListe: listEntreprise.map((item) => item.nomDuClientQuiSousTraite).toList(),
      ),
      ItemFormulaire(
        type: ItemFormulaire.dropdown,
        titlecard: "Etablissement",
        itemListe: listEntreprise.map((item) => item.nom).toList(),
      ),
      ItemFormulaire(
        type: ItemFormulaire.dropdown,
        titlecard: "Numéro de série",
        itemListe: listEntreprise.map((item) => item.defibrilateur!.numero.toString()).toList(),
      ),
      ItemFormulaire(
        type: ItemFormulaire.picture,
        titlecard: "Photo à l'arrivée",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "Le boitier DAE est-il en bon état ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesnonull,
        titlecard: "Le câblage est-il en bon état visuellement ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "Le DAE est-il visuellement en bon état (propre,sanscoup,etc...)",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "Le dernier autotest du DAE est-il correct ? Clignote en vert",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "La procédure test utilisateur a-t-elle été concluante ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.peremption,
        titlecard: "Péremption de la batterie ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "L'état des électodes est-il normal ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.peremption,
        titlecard: "Péremption des électrodes ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "La trousse de secours est-elle présente ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.yesno,
        titlecard: "La trousse de secours est-elle complète ?",
      ),
      ItemFormulaire(
        type: ItemFormulaire.picture,
        titlecard: "Photo au départ",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeApp.lightTheme,
      debugShowCheckedModeBanner: false,
      title: StringValue.nameApp.elementAt(StringValue.currentLanguage),
      home: Container(
        color: const Color.fromARGB(255, 241, 241, 241),
        padding: const EdgeInsets.all(20),
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Formulaire(value: listItemFormulaire),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).themeExtension().colorSecondary),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(17)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold))),
                    onPressed: () async {
                      String message = "";
                      int sizeofButton = idButton.length;
                      int sizeofTextFields = idTextFields.length;
                      int sizeofDropdown = idDropdown.length;
                      print(message);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: const Duration(seconds: 5),
                        ),
                      );

                      /*await FlutterEmailSender.send(
                                Email(
                                  body: "",
                                  subject: 'Email subject',
                                  recipients: ['cookcola41@gmail.com'],
                                  attachmentPaths: ['../../../../assets/logo.png'],
                                  isHTML: false,
                                ),
                              );*/
                      //sendEmail(name: "Aurélien Berna", email: 'clement.chevrin@gmail.com', subject: "Formulaire", message: message);
                      print("oui");
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Padding(padding: const EdgeInsets.fromLTRB(2, 0, 1, 0), child: const Icon(Icons.send_sharp, size: 20)), Padding(padding: const EdgeInsets.fromLTRB(5, 0, 1, 0), child: const Text("Envoyer"))],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*List<TextEditingController> idQuestions = List.generate(10, (i) => TextEditingController());
  List<TextEditingController> detailQuestions = List.generate(10, (i) => TextEditingController());*/

  onCreate(BuildContext context) async {}

  /// Retourne une card avec un dropdown selecteur
  Card _dropDownCard(String title, List<String> liste, TextEditingController id) {
    id.text = liste[0];
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 3,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            Dropdown(value: liste, id: id),
            /*Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<String>(
                focusColor: Colors.transparent,
                items: liste.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.black),
                underline: const SizedBox(),
                value: id.text,
                icon: const Icon(
                  Icons.expand_more_outlined,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      if (newValue != null) {
                        id.text = newValue;
                      }
                    },
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  /*Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => this._imageFile = File(pickedFile.path));
    }
  }*/

  /*Widget _buildRow(String question, TextEditingController button, TextEditingController detail) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).themeExtension().cardBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        question,
                        style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SwitchableButton(
                      backgroundColor: [Theme.of(context).themeExtension().statusTrue, Theme.of(context).themeExtension().statusFalse, Theme.of(context).themeExtension().statusNeutral],
                      icon: const [Icons.done, Icons.close, Icons.block_outlined],
                      value: const ["Oui", "Non", "Nul"],
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      id: button,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
                child: TextField(
                  cursorColor: const Color.fromARGB(255, 255, 115, 0),
                  maxLines: 2,
                  controller: detail,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: "Détails",
                    alignLabelWithHint: true,
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                    floatingLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.black),
                    focusColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
*/
  /*void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }*/

  /*void _handleSaveButtonPressed() async {
    final data = await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    print(signatureGlobalKey.currentState);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }
*/
  Card _peremptionCard(String title, TextEditingController id) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      title,
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  /*DatePicker(
                    id: TextEditingController(),
                    foreground: Colors.black,
                    background: Colors.white,
                  ),*/
                  SizedBox(
                    width: 120,
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 255, 115, 0),
                      maxLines: 1,
                      controller: id,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: "Date",
                        alignLabelWithHint: true,
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                        floatingLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.black),
                        focusColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 255, 115, 0),
                maxLines: 2,
                controller: id,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: "Détails",
                  alignLabelWithHint: true,
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                  floatingLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.black),
                  focusColor: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSnack() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("detail"),
        duration: const Duration(seconds: 5),
      ),
    );
    final Email email = Email(
      body: "",
      subject: 'Email subject',
      recipients: ['cookcola41@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  /// Retourne une card de saisie d'image
  Card _takeAPicture(String title, File? file) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 3,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: (file == null)
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 206, 206, 206),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Icon(
                                Icons.broken_image_outlined,
                                size: 50,
                              ),
                            )
                          : Image.file(file),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        onPressed: () async {
                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() => file = File(pickedFile.path));
                          }
                        },
                        child: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Retourne une card de saisie de signature
  Card _takeASign(String title, GlobalKey<SfSignaturePadState> signature) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 3,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: SfSignaturePad(
                          //key: signature,
                          minimumStrokeWidth: 1,
                          maximumStrokeWidth: 3,
                          strokeColor: Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: const Icon(Icons.close_outlined),
                        onPressed: () => signature.currentState!.clear(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Retourne une card avec le titre du formulaire
  Card _title(String title) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 3,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                'assets/image/logo.png',
                height: 40,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  /// Retourne une card avec une toggle button et un textfield
  Card _toggleDescribeCard(String title, SwitchableButton typeOfButton, TextEditingController detail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      title,
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  typeOfButton,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 255, 115, 0),
                maxLines: 2,
                controller: detail,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: "Détails",
                  alignLabelWithHint: true,
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                  floatingLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.black),
                  focusColor: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_6ylqhnf';
    final templateId = 'template_owbv94w';
    final userId = 'Ms1WrU9egxB8y6iHg';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
          },
        },
      ),
    );
    print(response.body);
  }

  Future sendMail() async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    final email = "cookcola41@gmail.com";
    final token = '';
    final message = Message()
      ..from = Address(email, 'Clément')
      ..recipients = [email]
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..subject = 'Test Dart Mailer library :: 😀 ::';

    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    String password = 'password';
    final smtpServer = gmailSaslXoauth2(email, token);
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    // DONE

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // close the connection
    await connection.close();
  }
*/
}
