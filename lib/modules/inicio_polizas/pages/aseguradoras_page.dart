import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/models/aseguradora_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/widgets/widget_input_search_main.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:assurance/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AseguradorasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(
        init: PolizasController(),
        builder: (_) {
          return _.cargando
              ? WidgetLoading()
              : _.listAseguradoraBuscador.isEmpty
                  ? WidgetNoData()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: WidgetInputSearchMain(
                              onChanged: _.onInputTextChangeAseguradoras,
                              onClear: _.cleanBuscadorAseguradora,
                              tec: _.tecBuscadorA,
                              hintText: Strings.sBuscar,
                              autofocus: false),
                        ),
                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              physics: BouncingScrollPhysics(),
                              itemCount: _.listAseguradoraBuscador.length,
                              itemBuilder: (builder, index) {
                                final Aseguradora aseguradora =
                                    _.listAseguradoraBuscador[index];
                                return ListTile(
                                  leading: Icon(
                                    Icons.home_work_rounded,
                                    color: ThemeColor.colorPrimary,
                                  ),
                                  title: Text(aseguradora.nombre),
                                );
                              }),
                        ),
                      ],
                    );
        });
  }
}
