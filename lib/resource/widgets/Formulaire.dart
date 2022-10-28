import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../functions/ItemFormulaire.dart';
import 'SwitchableButton.dart';
import 'Dropdown.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

@immutable
class Formulaire extends StatefulWidget {
  final List<ItemFormulaire> value;

  Formulaire({required this.value}) : assert(true);

  @override
  State<Formulaire> createState() => _Formulaire();
}

class _Formulaire extends State<Formulaire> {
  late List<Card> cardListe;
  @override
  void initState() {
    super.initState();
    cardListe = widget.value.map((item) => toCard(item)).toList();
  }

  Card toCard(ItemFormulaire itemFormulaire) {
    TextEditingController tec = TextEditingController();
    File? file;
    if (itemFormulaire.type == ItemFormulaire.title) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
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
                itemFormulaire.titlecard.toString(),
                style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );
    }
    if (itemFormulaire.type == ItemFormulaire.yesno) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Question :",
                  style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      itemFormulaire.titlecard.toString(),
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SwitchableButton(backgroundColor: [
                    Color.fromARGB(255, 102, 192, 107),
                    Color.fromARGB(255, 211, 47, 47),
                  ], icon: const [
                    Icons.done,
                    Icons.close,
                  ], value: const [
                    "Oui",
                    "Non",
                  ], id: TextEditingController())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 255, 115, 0),
                maxLines: 2,
                controller: TextEditingController(),
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
      );
    }
    if (itemFormulaire.type == ItemFormulaire.yesnonull) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Question :",
                  style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      itemFormulaire.titlecard.toString(),
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SwitchableButton(backgroundColor: [
                    Color.fromARGB(255, 102, 192, 107),
                    Color.fromARGB(255, 211, 47, 47),
                    Color.fromARGB(255, 238, 216, 20),
                  ], icon: const [
                    Icons.done,
                    Icons.close,
                    Icons.block_outlined
                  ], value: const [
                    "Oui",
                    "Non",
                    "Nul"
                  ], id: TextEditingController())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 255, 115, 0),
                maxLines: 2,
                controller: TextEditingController(),
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
      );
    }
    if (itemFormulaire.type == ItemFormulaire.peremption) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Peremption :",
                  style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      itemFormulaire.titlecard.toString(),
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 255, 115, 0),
                      maxLines: 1,
                      controller: TextEditingController(),
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
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 255, 115, 0),
                maxLines: 2,
                controller: TextEditingController(),
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
      );
    }
    if (itemFormulaire.type == ItemFormulaire.dropdown) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Information :",
                  style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      itemFormulaire.titlecard.toString(),
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Dropdown(value: itemFormulaire.itemListe!.map((e) => e).toSet().toList(), id: TextEditingController()),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    if (itemFormulaire.type == ItemFormulaire.picture) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Question :",
                  style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      itemFormulaire.titlecard.toString() + ' :',
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
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
                        backgroundColor: const Color(0XffF85D19),
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
      );
    } else {
      return Card(
        child: Container(
          color: Colors.red,
          height: 100,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cardListe.length,
      itemBuilder: (BuildContext context, int i) {
        return cardListe[i];
      },
    );
  }
}
