import 'package:assurance/constants/theme_color.dart';
import 'package:flutter/material.dart';

class WidgetInputMain extends StatelessWidget {
  final bool enabled;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final TextInputType tit;
  final TextEditingController tec;
  final String hintText;

  WidgetInputMain(
      {@required this.enabled,
      @required this.textCapitalization,
      @required this.obscureText,
      @required this.tit,
      @required this.tec,
      @required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(hintText, style: TextStyle(color: Colors.black54)),
        ),
        TextFormField(
          textCapitalization: textCapitalization,
          autofocus: false,
          obscureText: obscureText,
          keyboardType: tit,
          controller: tec,
          enabled: enabled,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: ThemeColor.colorPrimary, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26, width: 0.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
