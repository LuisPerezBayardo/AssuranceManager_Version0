import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ModalGenericPolizas extends StatelessWidget {
  final String type;
  final String title;
  final List<String> options;

  const ModalGenericPolizas({
    Key key,
    @required this.type,
    @required this.title,
    @required this.options,
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
                title: Text(title),
                trailing: IconButton(
                    onPressed: () => Get.back(), icon: Icon(Icons.close)),
              ),
              Divider(),
              Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (builder, index) {
                      return ListTile(
                        title: Text(options[index]),
                        onTap: () => _.selectOption(type, index),
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
