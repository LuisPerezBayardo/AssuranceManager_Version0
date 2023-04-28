import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/inicio/controllers/inicio_controller.dart';
import 'package:assurance/widgets/widget_image.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class InicioTitleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(builder: (_) {
      return InkWell(
        onTap: _.toPerfil,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Card(
                elevation: 12.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                clipBehavior: Clip.antiAlias,
                child: WidgetImage(
                    height: 64,
                    width: 64,
                    boxFit: BoxFit.cover,
                    url: _.globalControllerUsuario.usuario.avatar),
              ),
              const WidgetMargin(margin: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.appTitle,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  WidgetMargin(margin: 2),
                  Text(
                    _.globalControllerUsuario.usuario.nombre,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .apply(color: Colors.black45),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
