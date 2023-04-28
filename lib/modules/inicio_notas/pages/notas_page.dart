import 'package:assurance/constants/strings.dart';
import 'package:assurance/constants/theme_color.dart';
import 'package:assurance/models/nota_model.dart';
import 'package:assurance/modules/inicio_notas/controllers/notas_controller.dart';
import 'package:assurance/modules/inicio_notas/pages/widgets/item_nota.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:assurance/widgets/widget_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotasController>(
        init: NotasController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sNotas,
                isBack: true,
                back: () => Get.back()),
            body: _.cargando
                ? WidgetLoading()
                : _.listNotas.isEmpty
                    ? WidgetNoData()
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        physics: BouncingScrollPhysics(),
                        itemCount: _.listNotas.length,
                        itemBuilder: (builder, index) {
                          final Nota nota = _.listNotas[index];
                          return ItemNota(index: index, nota: nota);
                        }),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _.toCreateNota(),
                backgroundColor: ThemeColor.colorPrimary),
          );
        });
  }
}
