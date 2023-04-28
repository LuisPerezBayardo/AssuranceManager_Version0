import 'package:flutter/material.dart';

class WidgetInputSearchMain extends StatelessWidget {
  final Function onChanged;
  final Function onClear;
  final TextEditingController tec;
  final String hintText;
  final bool autofocus;

  const WidgetInputSearchMain(
      {Key key,
      @required this.onChanged,
      @required this.onClear,
      @required this.tec,
      @required this.hintText,
      @required this.autofocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: tec,
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        autofocus: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          suffix: tec.text.isNotEmpty
              ? IconButton(
                  onPressed: onClear,
                  icon: Icon(Icons.close),
                  padding: EdgeInsets.all(0),
                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                )
              : IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  padding: EdgeInsets.all(0),
                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
          ),
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: Colors.black),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
        ));
  }
}
