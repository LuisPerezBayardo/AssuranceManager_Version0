import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/register/controllers/register_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sRegister,
                isBack: true,
                back: () => Get.back()),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              physics: const BouncingScrollPhysics(),
              children: [
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    tit: TextInputType.name,
                    tec: _.tecNombre,
                    hintText: Strings.sNombreCompleto),
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
                    obscureText: false,
                    tit: TextInputType.phone,
                    tec: _.tecTelefono,
                    hintText: Strings.sTelefono),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: true,
                    tit: TextInputType.text,
                    tec: _.tecPassword,
                    hintText: Strings.sPassword),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: true,
                    tit: TextInputType.text,
                    tec: _.tecPasswordConfirm,
                    hintText: Strings.sPasswordConfirm),
                const WidgetMargin(margin: 40),
                WidgetButtonMain(
                    text: Strings.sRegistrarme,
                    paddingHorizontal: 0,
                    paddingVertical: 0,
                    fun: _.registrarUsuario),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.sAceptoTerminosYCondiciones,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Checkbox(
                        activeColor: ThemeColor.colorPrimary,
                        value: _.termsAndConditions,
                        onChanged: (value) => _.setTermsAndConditions(value))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
