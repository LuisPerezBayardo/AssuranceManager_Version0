import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_clientes/controllers/clientes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCliente extends StatelessWidget {
  final int index;
  final Cliente cliente;

  const ItemCliente({Key key, @required this.index, @required this.cliente})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientesController>(builder: (_) {
      return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          shadowColor: Colors.black45,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            onTap: () {
              _.toClienteDetail(index, cliente);
            },
            leading: Icon(Icons.person, color: ThemeColor.colorPrimary),
            trailing: Icon(Icons.chevron_right, color: ThemeColor.colorPrimary),
            title: Text(
              cliente.nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              cliente.correo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ));
    });
  }
}
