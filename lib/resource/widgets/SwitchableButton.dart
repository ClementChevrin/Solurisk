import 'package:flutter/material.dart';

@immutable
class SwitchableButton extends StatefulWidget {
  final List<Color> backgroundColor;
  final List<IconData> icon;
  final List<String> value;
  final Color foregroundColor;
  final TextEditingController id;
  final double? size;
  final EdgeInsets padding;
  final int spaceBetween;

  const SwitchableButton({super.key, required this.backgroundColor, required this.icon, required this.value, this.foregroundColor = Colors.black, required this.id, this.size, this.padding = const EdgeInsets.all(17), this.spaceBetween = 8})
      : assert((backgroundColor.length == value.length) && (value.length == icon.length));

  @override
  State<SwitchableButton> createState() => _SwitchableButton();
}

class _SwitchableButton extends State<SwitchableButton> {
  int _state = 0;
  Color? _colorYesNoButton;
  IconData? _iconYesNoButton;

  @override
  void initState() {
    super.initState();
    widget.id.text = widget.value[_state];
    _colorYesNoButton = widget.backgroundColor[_state];
    _iconYesNoButton = widget.icon[_state];
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(
          () {
            if (_state == widget.backgroundColor.length - 1) {
              _state = 0;
            } else {
              _state++;
            }
            widget.id.text = widget.value[_state];
            _colorYesNoButton = widget.backgroundColor[_state];
            _iconYesNoButton = widget.icon[_state];
          },
        );
      },
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(widget.foregroundColor),
          backgroundColor: MaterialStateProperty.all(_colorYesNoButton),
          padding: MaterialStateProperty.all(widget.padding),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Padding(padding: EdgeInsets.fromLTRB(0, 0, widget.spaceBetween / 2, 0), child: Icon(_iconYesNoButton, size: 20)), Padding(padding: EdgeInsets.fromLTRB(widget.spaceBetween / 2, 0, 0, 0), child: Text(widget.id.text))],
      ),
    );
  }
}
