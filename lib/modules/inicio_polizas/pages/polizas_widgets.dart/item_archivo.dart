import 'package:assurance/constants/constants.dart';
import 'package:assurance/models/archivo_poliza_model.dart';
import 'package:assurance/modules/inicio_polizas/controllers/archivos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemArchivo extends StatelessWidget {
  final int index;
  final ArchivoPoliza archivoPoliza;

  const ItemArchivo(
      {Key key, @required this.index, @required this.archivoPoliza})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchivosController>(builder: (_) {
      return Card(
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 16),
          onTap: () => _.toArchivoDetail(archivoPoliza),
          leading: Image.asset(
            archivoPoliza.tipo == 'imagen'
                ? Constants.icGallery
                : archivoPoliza.tipo == 'pdf'
                    ? Constants.icPdf
                    : archivoPoliza.tipo == 'word'
                        ? Constants.icWord
                        : archivoPoliza.tipo == 'excel'
                            ? Constants.icExcel
                            : Constants.icDocumento,
            width: 40,
            height: 40,
          ),
          trailing: IconButton(
            visualDensity: VisualDensity(vertical: -4, horizontal: -4),
            onPressed: () {
              _.eliminarArchivo(index, archivoPoliza);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade900,
            ),
          ),
          title: Text(
            archivoPoliza.nombre,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    });
  }
}
