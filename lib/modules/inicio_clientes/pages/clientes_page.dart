import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_clientes/controllers/clientes_controller.dart';
import 'package:assurance/modules/inicio_clientes/pages/widgets/item_cliente.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_input_search_main.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:assurance/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientesController>(
        init: ClientesController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sMisClientes,
                isBack: true,
                back: () => Get.back()),
            body: _.cargando
                ? WidgetLoading()
                : _.listCliente.isEmpty
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
                                itemCount: _.listClienteBuscador.length,
                                itemBuilder: (builder, index) {
                                  final Cliente cliente =
                                      _.listClienteBuscador[index];
                                  return ItemCliente(
                                      index: index, cliente: cliente);
                                }),
                          ),
                        ],
                      ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _.toCreateCliente(),
                backgroundColor: ThemeColor.colorPrimary),
          );
        });
  }
}
