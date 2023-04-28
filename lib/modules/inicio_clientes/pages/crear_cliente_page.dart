import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio_clientes/controllers/clientes_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_selector_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrearClientePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientesController>(
        init: ClientesController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sCrearClient,
                isBack: true,
                back: () => Get.back()),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              physics: BouncingScrollPhysics(),
              children: [
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    tit: TextInputType.text,
                    tec: _.tecNombre,
                    hintText: Strings.sNombreCliente),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    tit: TextInputType.emailAddress,
                    tec: _.tecEmail,
                    hintText: Strings.sCorreoCliente),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    tit: TextInputType.number,
                    tec: _.tecTelefono,
                    hintText: Strings.sTelefonoCliente),
                WidgetSelectorMain(
                  enabled: true,
                  tec: _.tecFechaNacimiento,
                  hintText: Strings.sFechaNacimiento,
                  label: true,
                  fun: () => _.showModalBirthDate('create'),
                ),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    tit: TextInputType.text,
                    tec: _.tecRFC,
                    hintText: Strings.sRFC),
                WidgetButtonMain(
                    text: Strings.sGuardar,
                    paddingHorizontal: 0,
                    paddingVertical: 24,
                    fun: _.crearCliente)
              ],
            ),
          );
        });
  }
}
