import 'package:assurance/modules/inicio_polizas/controllers/polizas_controller.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemArchivoUpload extends StatelessWidget {
  final String type;
  final String path;

  const ItemArchivoUpload({Key key, @required this.type, @required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolizasController>(builder: (_) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Image.asset(
              path,
              width: 40,
              height: 40,
            ),
            /*WidgetMargin(margin: 8),
            Text(
              type,
              style: Theme.of(context).textTheme.caption,
            )*/
          ],
        ),
      );
    });
  }
}
