import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'menuOptions',
        init: HomeController(),
        builder: (_) {
          return BottomNavigationBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ThemeColor.colorIconEnable,
              unselectedItemColor: ThemeColor.colorIconDisable,
              currentIndex: _.currentIndex,
              onTap: (index) {
                _.setIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: Strings.sInicioTitle),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: Strings.sPerfilTitle),
                BottomNavigationBarItem(
                    icon: Icon(Icons.logout), label: Strings.sSalirTitle),
              ]);
        });
  }
}
