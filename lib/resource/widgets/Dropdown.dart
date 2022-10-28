import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Dropdown extends StatefulWidget {
  final Color focusColor;
  final List<String> value;
  final TextEditingController id;

  const Dropdown({super.key, required this.value, this.focusColor = Colors.black, required this.id}) : assert((value.length > 0));

  @override
  State<Dropdown> createState() => _Dropdown();
}

class _Dropdown extends State<Dropdown> {
  @override
  void initState() {
    super.initState();
    widget.id.text = widget.value[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<String>(
        focusColor: Colors.transparent,
        items: widget.value.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
        style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: Colors.black),
        underline: const SizedBox(),
        value: widget.id.text,
        isExpanded: true,
        icon: const Icon(
          Icons.expand_more_outlined,
          color: Colors.black,
        ),
        onChanged: (String? newValue) {
          setState(
            () {
              if (newValue != null) {
                widget.id.text = newValue;
              }
            },
          );
        },
      ),
    );
  }
}
