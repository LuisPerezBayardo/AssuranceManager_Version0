import 'package:assurance/constants/theme_color.dart';
import 'package:flutter/material.dart';

class WidgetSelectorMain extends StatelessWidget {
  final bool enabled;
  final TextEditingController tec;
  final String hintText;
  final Function fun;
  final bool label;

  WidgetSelectorMain(
      {@required this.enabled,
      @required this.tec,
      @required this.hintText,
      this.fun,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(hintText, style: TextStyle(color: Colors.black54)),
              )
            : Container(),
        TextFormField(
          autofocus: false,
          controller: tec,
          enabled: enabled,
          readOnly: true,
          onTap: fun,
          decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            hintStyle: const TextStyle(color: Colors.black54),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            //filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  BorderSide(color: ThemeColor.colorPrimary, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26, width: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
