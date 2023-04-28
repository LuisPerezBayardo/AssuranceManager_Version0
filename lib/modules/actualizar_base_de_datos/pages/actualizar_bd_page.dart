import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/modules/actualizar_base_de_datos/controllers/actualizar_bd_controller.dart';
import 'package:assurance/widgets/widget_appbar_return.dart';
import 'package:assurance/widgets/widget_button_3.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_file_listview.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_text_main.dart';
import 'package:assurance/widgets/widget_text_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ActualizarBdPage extends StatelessWidget {
  const ActualizarBdPage({Key key}) : super(key: key);
  static const double margin = 8.0;
  static List selectedFiles;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActualizarBdController>(
        init: ActualizarBdController(),
        builder: (_) {
          return Scaffold(
              appBar: WidgetAppBarReturn.widget_appbar_return(context, "", true,
                () {Navigator.pop(context);}
              ),
              body: Column(
            children: [
              Flexible(
                  child: Center(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const WidgetMargin(margin: margin),
                    WidgetTextMain(
                        text: Strings.sActualizarBaseDeDatosTitle,
                        paddingHorizontal: 0,
                        paddingVertical: 0),
                    const WidgetMargin(margin: margin),
                    WidgetButtonMain(
                        text: Strings.sImportarExcel,
                        paddingHorizontal: 0,
                        paddingVertical: 0,
                        fun: _.uploadFile),
                    const WidgetMargin(margin: margin),
                    WidgetFileListView.widget_file_listview(
                        context,
                        _.files,   // View for excel importation
                        (int i){
                          _.openFile;
                        },
                        (int i){
                          _.longPressFile;
                        }),
                    const WidgetMargin(margin: margin),
                    Divider(),
                    const WidgetMargin(margin: margin),
                    Expanded( child: Row(
                      children: [
                          WidgetButton3.button(
                            context,
                            Strings.sCancelar,
                            _.cancelar,
                            Colors.white,
                            Colors.black),
                          const WidgetMargin(margin: margin),
                          WidgetButton3.button(
                            context,
                            Strings.sActualizar,
                            _.actualizar,
                            Colors.green,
                            Colors.white),
                          const WidgetMargin(margin: margin),
                      ]),
                    ),
                    const WidgetMargin(margin: margin)
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
