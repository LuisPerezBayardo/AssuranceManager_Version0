import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UtilsDialog {
  static Future<void> alertDialogError(
      BuildContext context, String textError) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: ThemeColor.colorPrimary,
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(24),
              color: ThemeColor.colorPrimary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.sError,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  Text(
                    textError,
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  WidgetButtonSecondary(
                      text: Strings.sAceptar, fun: () => Navigator.pop(context))
                ],
              ),
            ),
          );
        });
  }

  static Future<void> alertDialogOneAction(BuildContext context, String title,
      String content, String textButton, Function fun) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: ThemeColor.colorPrimary,
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(24),
              color: ThemeColor.colorPrimary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  Text(
                    content,
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  WidgetButtonSecondary(text: textButton, fun: fun)
                ],
              ),
            ),
          );
        });
  }

  static Future<void> alertDialogTwoActions(
      BuildContext context,
      String title,
      String content,
      String textButton1,
      String textButton2,
      Function fun1,
      Function fun2) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: ThemeColor.colorPrimary,
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(24),
              color: ThemeColor.colorPrimary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  Text(
                    content,
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  const WidgetMargin(margin: 16),
                  WidgetButtonSecondary(text: textButton1, fun: fun1),
                  WidgetButtonSecondary(text: textButton2, fun: fun2),
                ],
              ),
            ),
          );
        });
  }

  static ProgressDialog showProgresDialog(
      BuildContext context, bool isDismissible) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: isDismissible,
      showLogs: false,
    );
    pr.style(
      message: Strings.sCargando,
      messageTextStyle: const TextStyle(color: Colors.white54),
      backgroundColor: ThemeColor.colorPrimary,
      borderRadius: 16.0,
      padding: const EdgeInsets.symmetric(vertical: 8),
    );
    return pr;
  }
}
