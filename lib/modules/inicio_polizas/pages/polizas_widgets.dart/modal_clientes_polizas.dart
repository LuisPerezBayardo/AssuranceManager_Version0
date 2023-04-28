import 'package:assurance/constants/strings.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ModalClientesPolizas extends StatelessWidget {
  final List<Cliente> clientes;

  const ModalClientesPolizas({
    Key key,
    @required this.clientes,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(builder: (_) {
      return Card(
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Container(
          child: Column(
            children: [
              ListTile(
                title: Text(Strings.sSelectCliente),
                trailing: IconButton(
                    onPressed: () => Get.back(), icon: Icon(Icons.close)),
              ),
              Divider(),
              ListTile(
                  onTap: _.toAddCliente,
                  title: Text(Strings.sClienteNuevo),
                  leading: Icon(Icons.add_circle)),
              Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: clientes.length,
                    itemBuilder: (builder, index) {
                      return ListTile(
                        title: Text(clientes[index].nombre),
                        onTap: () => _.selectCliente(clientes[index], index),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
