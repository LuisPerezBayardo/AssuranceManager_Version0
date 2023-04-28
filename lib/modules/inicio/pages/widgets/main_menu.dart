import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio/controllers/inicio_controller.dart';
import 'package:assurance/modules/inicio/pages/widgets/main_menu_item.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(builder: (_) {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          MainMenuItem(
              title: Strings.sMisPolizas,
              img: Constants.icMisPolizas,
              fun: () => _.toRoutes(Constants.menuMisPolizas)),
          WidgetMargin(margin: 16),
          Row(
            children: [
              Expanded(
                child: MainMenuItem(
                    title: Strings.sMisClientes,
                    img: Constants.icMisClientes,
                    fun: () => _.toRoutes(Constants.menuMisClientes)),
              ),
              WidgetMargin(margin: 16),
              Expanded(
                child: MainMenuItem(
                    title: Strings.sPolizasPendientes,
                    img: Constants.icPolizasPendientes,
                    fun: () => _.toRoutes(Constants.menuPolizasPendientes)),
              ),
            ],
          ),
          WidgetMargin(margin: 16),
          MainMenuItem(
              title: Strings.sGastosIngresos,
              img: Constants.icGastosIngresos,
              fun: () => _.toRoutes(Constants.menuGastosIngresos)),
          WidgetMargin(margin: 16),
          Row(
            children: [
              Expanded(
                child: MainMenuItem(
                    title: Strings.sNotas,
                    img: Constants.icNotas,
                    fun: () => _.toRoutes(Constants.menuNotas)),
              ),
              WidgetMargin(margin: 16),
              Expanded(
                child: MainMenuItem(
                    title: Strings.sMiActividad,
                    img: Constants.icMiActividad,
                    fun: () => _.toRoutes(Constants.menuActividad)),
              ),
            ],
          ),
          WidgetMargin(margin: 16),
          MainMenuItem(
              title: Strings.sAcercaDe,
              img: Constants.icAbout,
              fun: () => _.toRoutes(Constants.menuAbout)),
          WidgetMargin(margin: 24),
        ],
      );
    });
  }
}
