import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class PolizasOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoSegmentedControl(
                      padding: EdgeInsets.all(0.0),
                      selectedColor: ThemeColor.colorSecondary,
                      borderColor: ThemeColor.colorSecondary,
                      groupValue: _.segmentedControlValue,
                      children: <int, Widget>{
                        0: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(Strings.sMisPolizas)),
                        1: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(Strings.sAseguradoras)),
                      },
                      onValueChanged: (value) {
                        print(value);
                        _.selectType(value);
                      }),
                ),
              ],
            ),
          );
        });
  }
}
