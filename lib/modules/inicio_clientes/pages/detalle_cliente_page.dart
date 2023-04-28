import 'package:assurance/constants/strings.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_clientes/controllers/clientes_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_selector_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetalleClientePage extends StatelessWidget {
  final int index;
  final Cliente cliente;

  const DetalleClientePage(
      {Key key, @required this.index, @required this.cliente})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientesController>(
        init: ClientesController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sDetalleCliente,
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
                    tec: _.tecNombreE,
                    hintText: Strings.sNombreCliente),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    tit: TextInputType.emailAddress,
                    tec: _.tecEmailE,
                    hintText: Strings.sCorreoCliente),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    tit: TextInputType.number,
                    tec: _.tecTelefonoE,
                    hintText: Strings.sTelefonoCliente),
                WidgetSelectorMain(
                  enabled: true,
                  tec: _.tecFechaNacimientoE,
                  hintText: Strings.sFechaNacimiento,
                  label: true,
                  fun: () => _.showModalBirthDate('edit'),
                ),
                WidgetInputMain(
                    enabled: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: false,
                    tit: TextInputType.text,
                    tec: _.tecRFCE,
                    hintText: Strings.sRFC),
                WidgetMargin(margin: 24),
                WidgetButtonMain(
                    text: Strings.sGuardar,
                    paddingHorizontal: 0,
                    paddingVertical: 0,
                    fun: () => _.editarCliente(cliente)),
                WidgetButtonSecondary(
                    text: Strings.sEliminar,
                    color: Colors.red.shade700,
                    fun: () => _.eliminarCliente(index, cliente)),
                WidgetMargin(margin: 24),
              ],
            ),
          );
        });
  }
}
