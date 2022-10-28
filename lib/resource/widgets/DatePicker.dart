import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class DatePicker extends StatefulWidget {
  final Color foreground;
  final Color background;
  TextEditingController id;
  TextEditingController? day;
  TextEditingController? month;
  TextEditingController? year;

  DatePicker({super.key, this.foreground = Colors.black, this.background = Colors.white, required this.id});

  @override
  State<DatePicker> createState() => _DatePicker();
}

class _DatePicker extends State<DatePicker> {
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    widget.id.text = now.day.toString() + '/' + now.day.toString() + '/' + now.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(
          () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("Date"),
                content: Container(
                  color: Color.fromARGB(255, 212, 212, 212),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                maximumSize: MaterialStateProperty.all(const Size(40, 40)),
                                minimumSize: MaterialStateProperty.all(const Size(40, 40)),
                                foregroundColor: MaterialStateProperty.all(widget.foreground),
                                backgroundColor: MaterialStateProperty.all(widget.background),
                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Color.fromARGB(255, 128, 128, 128), width: 1),
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.navigate_before_outlined,
                                color: widget.foreground,
                                size: 20,
                              ),
                              onPressed: null),
                          Text(
                            (date.month == 10) ? "Octobre" : "" + " " + date.year.toString(),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(const Size(40, 40)),
                              minimumSize: MaterialStateProperty.all(const Size(40, 40)),
                              foregroundColor: MaterialStateProperty.all(widget.foreground),
                              backgroundColor: MaterialStateProperty.all(widget.background),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Color.fromARGB(255, 128, 128, 128), width: 1),
                                ),
                              ),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            child: Icon(
                              Icons.navigate_next_outlined,
                              color: widget.foreground,
                            ),
                            onPressed: null,
                          ),
                        ],
                      ),
                      /*SizedBox(
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 7,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 212, 212, 212)), borderRadius: BorderRadius.circular(5)),
                                  child: Text("Lun"),
                                ),
                              ),
                            ],
                          ),
                        )*/
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, 'sans'),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(widget.background),
                            backgroundColor: MaterialStateProperty.all(widget.foreground),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold))),
                        child: Text(
                          "Sans jour",
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, 'avec'),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(widget.background),
                            backgroundColor: MaterialStateProperty.all(widget.foreground),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold))),
                        child: Text(
                          "Avec jour",
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.black, width: 1))),
          textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold))),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), child: Text(widget.id.text)),
    );
  }
}
