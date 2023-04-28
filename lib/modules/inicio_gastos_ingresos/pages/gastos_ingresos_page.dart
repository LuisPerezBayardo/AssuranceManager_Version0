import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_gastos_ingresos/controllers/gastos_ingresos_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GastosIngresosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GastosIngresosController>(
        init: GastosIngresosController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sGastosIngresos,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
