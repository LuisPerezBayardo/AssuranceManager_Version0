import 'package:assurance/constants/strings.dart';
import 'package:assurance/models/aseguradora_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ModalAseguradorasPolizas extends StatelessWidget {
  final List<Aseguradora> aseguradoras;

  const ModalAseguradorasPolizas({
    Key key,
    @required this.aseguradoras,
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
                title: Text(Strings.sSelectAseguradora),
                trailing: IconButton(
                    onPressed: () => Get.back(), icon: Icon(Icons.close)),
              ),
              Divider(),
              Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: aseguradoras.length,
                    itemBuilder: (builder, index) {
                      return ListTile(
                          title: Text(aseguradoras[index].nombre),
                          onTap: () =>
                              _.selectAseguradora(aseguradoras[index], index));
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
