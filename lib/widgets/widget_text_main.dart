import 'package:flutter/material.dart';

class WidgetTextMain extends StatelessWidget {
  final String text;
  final double paddingHorizontal;
  final double paddingVertical;

  WidgetTextMain(
      {@required this.text,
      @required this.paddingHorizontal,
      @required this.paddingVertical});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.justify,
          )),
    );
  }
}
