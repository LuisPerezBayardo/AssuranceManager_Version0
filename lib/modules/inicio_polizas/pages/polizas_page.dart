import 'package:assurance/constants/strings.dart';
import 'package:assurance/models/poliza_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/item_poliza.dart';
import 'package:assurance/widgets/widget_input_search_main.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:assurance/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolizasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return _.cargando
              ? WidgetLoading()
              : _.listPoliza.isEmpty
                  ? WidgetNoData()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: WidgetInputSearchMain(
                              onChanged: _.onInputTextChange,
                              onClear: _.cleanBuscador,
                              tec: _.tecBuscador,
                              hintText: Strings.sBuscar,
                              autofocus: false),
                        ),
                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              physics: BouncingScrollPhysics(),
                              itemCount: _.listPolizaBuscador.length,
                              itemBuilder: (builder, index) {
                                final Poliza poliza =
                                    _.listPolizaBuscador[index];
                                return ItemPoliza(index: index, poliza: poliza);
                              }),
                        ),
                      ],
                    );
        });
  }
}
