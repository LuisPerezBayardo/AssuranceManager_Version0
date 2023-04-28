import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/login/controllers/login_controller.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_text_main.dart';
import 'package:assurance/widgets/widget_text_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return Scaffold(
              body: Column(
            children: [
              Flexible(
                  child: Center(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    WidgetTextMain(
                        text: Strings.sLoginTitle,
                        paddingHorizontal: 0,
                        paddingVertical: 0),
                    const WidgetMargin(margin: 8),
                    WidgetTextSecondary(
                        text: Strings.sWelcome,
                        paddingHorizontal: 0,
                        paddingVertical: 0),
                    const WidgetMargin(margin: 24),
                    WidgetInputMain(
                        enabled: true,
                        textCapitalization: TextCapitalization.none,
                        obscureText: false,
                        tit: TextInputType.emailAddress,
                        tec: _.tecEmail,
                        hintText: Strings.sEmail),
                    WidgetInputMain(
                        enabled: true,
                        textCapitalization: TextCapitalization.none,
                        obscureText: true,
                        tit: TextInputType.text,
                        tec: _.tecPassword,
                        hintText: Strings.sPassword),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WidgetButtonSecondary(
                            text: Strings.sForgotPassword,
                            fun: _.toResetPassword),
                      ],
                    ),
                    const WidgetMargin(margin: 32),
                    WidgetButtonMain(
                        text: Strings.sIniciarSesion,
                        paddingHorizontal: 0,
                        paddingVertical: 0,
                        fun: _.login),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetTextSecondary(
                            text: Strings.sNoTienesCuenta,
                            paddingHorizontal: 0.0,
                            paddingVertical: 0.0),
                        WidgetButtonSecondary(
                            text: Strings.sRegistrate, fun: _.toRegister),
                      ],
                    ),
                  ],
                ),
              )),
              Container(
                color: ThemeColor.colorPrimary,
                child: Center(
                  child: Image.asset(
                    Constants.icLogoLarge,
                    height: 100,
                  ),
                ),
              )
            ],
          ));
        });
  }
}
