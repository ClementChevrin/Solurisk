import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resource/functions/Defibrilateur.dart';
import '../../../resource/functions/Entreprise.dart';

class QuatreFrag extends StatefulWidget {
  const QuatreFrag({Key? key}) : super(key: key);
  @override
  QuatreFragPage createState() => QuatreFragPage();
}

class QuatreFragPage extends State<QuatreFrag> {
  late List<Entreprise> listEntreprise;
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => onCreate(context));
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
  }

  onCreate(BuildContext context) async {}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: listEntreprise.length,
        itemBuilder: (context, index) {
          return buildRow(index);
        },
      ),
    );
  }

  Widget buildRow(int idx) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Client : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].nomDuClientQuiSousTraite,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Entreprise : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].nom,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Raison Social : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].raisonSocial.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Siret : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].siret,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Siren : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].siren.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Latitude : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].latitude.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Longitude : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].longitude.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Jours : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].disponibiliteJours.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Heures : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].disponibiliteHeures.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Tel 1 : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].telephone1.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Tel 2: ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].telephone2.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Mail : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].mail.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Nom : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].defibrilateur!.nom.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Numéro : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].defibrilateur!.numero.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Modèle : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].defibrilateur!.modele.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Type : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].defibrilateur!.type.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Accessibilité : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  (listEntreprise[idx].defibrilateur!.accessibilite == 1) ? "Interieur" : "Exterieur",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Status ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  (listEntreprise[idx].defibrilateur!.status == 1) ? "En fonctionnement" : "A l'arret",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Date pose : ",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  listEntreprise[idx].defibrilateur!.datePose.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
