import 'package:assurance/modules/inicio/controllers/inicio_controller.dart';
import 'package:assurance/modules/inicio/pages/widgets/inicio_title_image.dart';
import 'package:assurance/modules/inicio/pages/widgets/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        init: InicioController(),
        builder: (_) {
          return Scaffold(
              body: ListView(
            physics: BouncingScrollPhysics(),
            children: [InicioTitleImage(), MainMenu()],
          ) /*RefreshIndicator(
                onRefresh: _.homeController.obtenerUsuarioFirebase,
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [InicioTitleImage(), MainMenu()],
                )),*/
              );
        });
  }
}
