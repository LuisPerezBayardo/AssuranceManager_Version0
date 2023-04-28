import 'package:assurance/constants/theme_color.dart';
import 'package:flutter/material.dart';

class WidgetButtonMain extends StatelessWidget {
  final String text;
  final Function fun;
  final double paddingHorizontal;
  final double paddingVertical;
  final Color color;

  WidgetButtonMain(
      {@required this.text,
      @required this.paddingHorizontal,
      @required this.paddingVertical,
      @required this.fun,
      this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            disabledTextColor: Colors.white70,
            textColor: Colors.white,
            color: color == null ? ThemeColor.colorPrimary : color,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                  )),
            ),
            onPressed: fun),
      ),
    );
  }
}
