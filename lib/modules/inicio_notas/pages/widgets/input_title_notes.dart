import 'package:assurance/constants/theme_color.dart';
import 'package:flutter/material.dart';

class InputTitleNotes extends StatelessWidget {
  final bool enabled;
  final TextEditingController tec;
  final String hintText;
  final TextStyle textStyle;

  InputTitleNotes(
      {@required this.enabled,
      @required this.tec,
      @required this.hintText,
      @required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        obscureText: false,
        keyboardType: TextInputType.multiline,
        controller: tec,
        enabled: enabled,
        maxLines: null,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            hintText: hintText),
        style: textStyle

        /*decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
      ),*/
        );
  }
}
