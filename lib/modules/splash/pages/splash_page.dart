import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Scaffold(
              backgroundColor: ThemeColor.colorPrimary,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(
                    Constants.icLogo,
                  ),
                ),
              ));
        });
  }
}
