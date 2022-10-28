import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget deuxFrag(BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(40),
      height: (MediaQuery.of(context).size.height),
      width: (MediaQuery.of(context).size.width),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ARRIVE BIENTÔT", style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 25, color: Color.fromARGB(255, 104, 104, 104))),
          Text("Emplacement pour des futurs pages", style: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 15, color: Color.fromARGB(255, 104, 104, 104))),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Icon(
              Icons.flight_takeoff_outlined,
              size: 40,
            ),
          )
        ],
      ));
}
