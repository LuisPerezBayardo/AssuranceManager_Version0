import 'package:flutter/material.dart';

class WidgetTextSecondary extends StatelessWidget {
  final String text;
  final double paddingHorizontal;
  final double paddingVertical;

  WidgetTextSecondary(
      {@required this.text,
      @required this.paddingHorizontal,
      @required this.paddingVertical});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
