import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/models/archivo_poliza_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/archivos_controller.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/item_archivo.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/item_archivo_upload.dart';
import 'package:assurance/widgets/widget_appbar_main.dart';
import 'package:assurance/widgets/widget_button_secondary.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:assurance/widgets/widget_no_data.dart';
import 'package:assurance/widgets/widget_text_secondary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgregarDocumentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchivosController>(
        init: ArchivosController(),
        builder: (_) {
          return Scaffold(
            appBar: WidgetAppBarMain(
                appBar: AppBar(),
                title: Strings.sAgregregarArchivos,
                isBack: true,
                back: () => Get.back()),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetTextSecondary(
                    text: Strings.sSeleccionaArchivo,
                    paddingHorizontal: 24,
                    paddingVertical: 0),
                WidgetMargin(margin: 24),
                Card(
                  shadowColor: Colors.black45,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ItemArchivoUpload(
                              type: Strings.sGaleria,
                              path: Constants.icGallery,
                            ),
                            ItemArchivoUpload(
                                type: Strings.sPDF, path: Constants.icPdf),
                            ItemArchivoUpload(
                                type: Strings.sWord, path: Constants.icWord),
                            ItemArchivoUpload(
                                type: Strings.sExcel, path: Constants.icExcel),
                          ],
                        ),
                        WidgetButtonSecondary(
                            text: Strings.sSeleccionarArchivo,
                            fun: () {
                              _.selectFile();
                            })
                      ],
                    ),
                  ),
                ),
                WidgetMargin(margin: 8),
                Flexible(
                  child: _.cargando
                      ? WidgetLoading()
                      : _.listArchivoPoliza.isEmpty
                          ? WidgetNoData()
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              physics: BouncingScrollPhysics(),
                              itemCount: _.listArchivoPoliza.length,
                              itemBuilder: (builder, index) {
                                final ArchivoPoliza archivoPoliza =
                                    _.listArchivoPoliza[index];
                                return ItemArchivo(
                                    index: index, archivoPoliza: archivoPoliza);
                              }),
                )
              ],
            ),
          );
        });
  }
}
