import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_about/controllers/about_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutController>(
        init: AboutController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sAcercaDe,
                isBack: true,
                back: () => Get.back()),
          );
        });
  }
}
