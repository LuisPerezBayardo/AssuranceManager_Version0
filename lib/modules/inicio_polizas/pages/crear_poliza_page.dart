import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/models/poliza_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_main.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_input_main.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_selector_main.dart';
import 'package:assurance/widgets/widget_text_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrearPolizaPage extends StatelessWidget {
  final int index;
  final Poliza poliza;

  const CrearPolizaPage({Key key, this.index, this.poliza}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return Scaffold(
              appBar: WidgetAppBarMain(
                  appBar: AppBar(),
                  title: Strings.sCrearPoliza,
                  isBack: true,
                  back: () => Get.back()),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                physics: BouncingScrollPhysics(),
                children: [
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecNumeroPoliza,
                      hintText: Strings.sNumeroPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalGeneric(
                          'ramo', Strings.sErrorPolizaRamo, _.listRamo),
                      label: true,
                      enabled: true,
                      tec: _.tecRamo,
                      hintText: Strings.sRamoPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalAseguradora(_.listAseguradora),
                      label: true,
                      enabled: true,
                      tec: _.tecAseguradora,
                      hintText: Strings.sAseguradoraPoliza),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecCobertura,
                      hintText: Strings.sCoberturaPoliza),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecInciso,
                      hintText: Strings.sIncisoPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalDatePolizas('fechaInicio'),
                      label: true,
                      enabled: true,
                      tec: _.tecFechaInicio,
                      hintText: Strings.sInicioPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalDatePolizas('fechaTerminacion'),
                      label: true,
                      enabled: true,
                      tec: _.tecFechaTerminacion,
                      hintText: Strings.sTerminacionPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalDatePolizas('fechaEmision'),
                      label: true,
                      enabled: true,
                      tec: _.tecFechaEmision,
                      hintText: Strings.sEmisionPoliza),
                  WidgetSelectorMain(
                      fun: () => _.showModalDatePolizas('fechaPago'),
                      label: true,
                      enabled: true,
                      tec: _.tecFechaPago,
                      hintText: Strings.sPagoPoliza),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecFormaPago,
                      hintText: Strings.sFormaPago),
                  WidgetSelectorMain(
                      fun: () => _.showModalGeneric('estatus',
                          Strings.sErrorPolizaEstatus, _.listEstatus),
                      label: true,
                      enabled: true,
                      tec: _.tecEstatus,
                      hintText: Strings.sPolizaEstatus),
                  WidgetInputMain(
                      enabled: true,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      tit: TextInputType.text,
                      tec: _.tecMontoTotal,
                      hintText: Strings.sMontoPago),
                  //Cliente
                  Column(
                    children: [
                      WidgetMargin(margin: 8),
                      WidgetTextMain(
                          text: Strings.sCliente,
                          paddingHorizontal: 24,
                          paddingVertical: 16),
                      WidgetSelectorMain(
                          fun: () => _.showModalClientes(_.listCliente),
                          label: true,
                          enabled: true,
                          tec: _.tecCliente,
                          hintText: Strings.sClienteExistente),
                    ],
                  ),
                  //Automóvil
                  _.tecRamo.text == Constants.ramoAuto
                      ? Column(
                          children: [
                            WidgetMargin(margin: 8),
                            WidgetTextMain(
                                text: Strings.sAutomovil,
                                paddingHorizontal: 24,
                                paddingVertical: 16),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoMarca,
                                hintText: Strings.sAutomovilMarca),
                            WidgetSelectorMain(
                                fun: () => _.showModalGeneric(
                                    'tipoAuto',
                                    Strings.sErrorPolizaTipoAuto,
                                    _.listTipoAuto),
                                label: true,
                                enabled: true,
                                tec: _.tecAutoTipo,
                                hintText: Strings.sAutomovilTipo),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoModelo,
                                hintText: Strings.sAutomovilModelo),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoSerie,
                                hintText: Strings.sAutomovilSerie),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoMotor,
                                hintText: Strings.sAutomovilMotor),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoPlacas,
                                hintText: Strings.sAutomovilPlacas),
                            WidgetSelectorMain(
                                fun: () => _.showModalGeneric(
                                    'residente',
                                    Strings.sErrorPolizaResidenteAuto,
                                    _.listSiNo),
                                label: true,
                                enabled: true,
                                tec: _.tecAutoResidente,
                                hintText: Strings.sAutomovilResidente),
                            WidgetSelectorMain(
                                fun: () => _.showModalGeneric(
                                    'legalizado',
                                    Strings.sErrorPolizaLegalizadoAuto,
                                    _.listSiNo),
                                label: true,
                                enabled: true,
                                tec: _.tecAutoLegalizado,
                                hintText: Strings.sAutomovilLegalizado),
                            WidgetInputMain(
                                enabled: true,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                tit: TextInputType.text,
                                tec: _.tecAutoAdaptaciones,
                                hintText: Strings.sAutomovilAdaptaciones),
                          ],
                        )
                      : Container(),
                  WidgetMargin(margin: 24),
                  WidgetButtonMain(
                      text: Strings.sGuardar,
                      paddingHorizontal: 0,
                      paddingVertical: 0,
                      fun: () => poliza == null
                          ? _.crearPoliza()
                          : _.crearPoliza(poliza: poliza)),
                  poliza != null
                      ? WidgetButtonSecondary(
                          text: Strings.sArchivos,
                          color: ThemeColor.colorSecondary,
                          fun: () => _.toAgregarArchivos(poliza.id))
                      : Container(),
                  poliza != null
                      ? WidgetButtonSecondary(
                          text: Strings.sEliminar,
                          color: Colors.red.shade700,
                          fun: () => _.eliminarPoliza(index, poliza))
                      : Container(),
                  WidgetMargin(margin: 24),
                ],
              ));
        });
  }
}
