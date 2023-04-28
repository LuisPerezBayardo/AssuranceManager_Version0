import 'package:assurance/models/nota_model.dart';
import 'package:assurance/modules/inicio_notas/controllers/notas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemNota extends StatelessWidget {
  final int index;
  final Nota nota;

  const ItemNota({Key key, @required this.index, @required this.nota})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotasController>(builder: (_) {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        shadowColor: Colors.black45,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          onTap: () => _.toCreateNota(nota: nota, index: index),
          title: Text(nota.titulo),
          subtitle: Text(
            nota.contenido,
            maxLines: 4,
          ),
        ),
      );
    });
  }
}
