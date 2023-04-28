import 'package:assurance/constants/strings.dart';
import 'package:assurance/models/nota_model.dart';
import 'package:assurance/modules/inicio_notas/controllers/notas_controller.dart';
import 'package:assurance/modules/inicio_notas/pages/widgets/input_title_notes.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNotaPage extends StatelessWidget {
  final Nota nota;
  final int index;
  const CreateNotaPage({Key key, this.nota, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotasController>(
        init: NotasController(),
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              _.isEditing ? _.editarNotaFirebase(nota) : _.createNotaFirebase();
              return Future.value(false);
            },
            child: Scaffold(
              appBar: WidgetAppBarMain(
                  appBar: AppBar(),
                  title: Strings.sCrearNota,
                  isBack: true,
                  back: () => _.isEditing
                      ? _.editarNotaFirebase(nota)
                      : _.createNotaFirebase()),
              body: ListView(
                children: [
                  InputTitleNotes(
                      enabled: true,
                      tec: _.tecTitle,
                      hintText: Strings.sTituloNota,
                      textStyle: Theme.of(context).textTheme.headline6),
                  InputTitleNotes(
                      enabled: true,
                      tec: _.tecContent,
                      hintText: Strings.sContenidoNota,
                      textStyle: Theme.of(context).textTheme.bodyText2),
                ],
              ),
              floatingActionButton: _.isEditing
                  ? FloatingActionButton(
                      child: Icon(Icons.delete),
                      onPressed: () => _.deleteNota(nota, index),
                      backgroundColor: Colors.red.shade700)
                  : Container(),
            ),
          );
        });
  }
}
