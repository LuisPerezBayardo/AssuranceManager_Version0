import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/login/controllers/login_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_text_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
        appBar: WidgetAppBarMain(
            appBar: AppBar(),
            title: Strings.sResetPassword,
            isBack: true,
            back: () => Get.back()),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            WidgetTextSecondary(
                text: Strings.sResetPasswordDescription,
                paddingHorizontal: 0,
                paddingVertical: 0),
            const WidgetMargin(margin: 16),
            WidgetInputMain(
                enabled: true,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                tit: TextInputType.emailAddress,
                tec: _.tecEmailReset,
                hintText: Strings.sEmail),
            WidgetButtonMain(
                text: Strings.sResetPassword,
                paddingHorizontal: 0,
                paddingVertical: 24,
                fun: _.resetPassword),
          ],
        ),
      );
    });
  }
}
