import 'package:flutter/material.dart';

class WidgetMargin extends StatelessWidget {
  final double margin;

  const WidgetMargin({Key key, @required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: margin, height: margin);
  }
}
