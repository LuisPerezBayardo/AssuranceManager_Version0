import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/models/poliza_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPoliza extends StatelessWidget {
  final int index;
  final Poliza poliza;

  const ItemPoliza({Key key, @required this.index, @required this.poliza})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(builder: (_) {
      return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          shadowColor: Colors.black45,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            onTap: () {
              _.toEditPoliza(index, poliza);
            },
            leading: Icon(Icons.assignment, color: ThemeColor.colorPrimary),
            trailing: Icon(Icons.chevron_right, color: ThemeColor.colorPrimary),
            title: Text(
              poliza.numero,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              poliza.clienteNombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ));
    });
  }
}
