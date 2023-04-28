import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_actividad/controllers/actividad_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActividadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActividadController>(
        init: ActividadController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sMiActividad,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
