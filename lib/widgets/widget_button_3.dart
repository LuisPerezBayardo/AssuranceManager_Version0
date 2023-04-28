import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:flutter/material.dart';

class WidgetButton3 {

  WidgetButton3(){}


  static Widget button(BuildContext context, String text, Function fun, Color color, 
          Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: MaterialButton(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  disabledTextColor: Colors.white70,
                  textColor:textColor,
                  //color: ThemeColor.colorPrimary,
                  color: color,
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
        ],
      ),
    );
  }

}
