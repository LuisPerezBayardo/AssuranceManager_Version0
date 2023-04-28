import 'package:assurance/modules/inicio/controllers/inicio_controller.dart';
import 'package:assurance/widgets/widget_image_ofline.dart';
import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenuItem extends StatelessWidget {
  final String title;
  final String img;
  final Function fun;

  const MainMenuItem(
      {Key key, @required this.title, @required this.img, @required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(builder: (_) {
      return Card(
        margin: EdgeInsets.all(0),
        elevation: 8,
        shadowColor: Colors.black45,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: fun,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                WidgetImageOfline(
                    height: 60, width: 60, boxFit: BoxFit.contain, url: img),
                WidgetMargin(margin: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
