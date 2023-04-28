import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/route_manager.dart';

class ModalDatePolizas extends StatelessWidget {
  final String type;
  const ModalDatePolizas({Key key, @required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return Card(
            margin: const EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Container(
              height: 250,
              child: Column(
                children: [
                  Flexible(
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          _.setDateBirth(val.toString(), type);
                        }),
                  ),
                  WidgetButtonSecondary(
                      text: Strings.sAceptar, fun: () => Get.back())
                ],
              ),
            ),
          );
        });
  }
}
