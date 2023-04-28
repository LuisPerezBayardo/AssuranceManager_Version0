import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/modules/inicio_polizas/pages/aseguradoras_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/polizas_options.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolizasMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sMisPolizas,
                isBack: true,
                back: () => Get.back()),
            body: Column(
              children: [
                PolizasOptions(),
                Flexible(
                  child: _.segmentedControlValue == 0
                      ? PolizasPage()
                      : AseguradorasPage(),
                )
              ],
            ),
            floatingActionButton: _.segmentedControlValue == 0
                ? FloatingActionButton(
                    backgroundColor: ThemeColor.colorPrimary,
                    child: Icon(Icons.add),
                    onPressed: _.toAddPoliza)
                : Container(),
          );
        });
  }
}
