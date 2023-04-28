import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetImageOfline extends StatelessWidget {
  final double height;
  final double width;
  final BoxFit boxFit;
  final String url;

  const WidgetImageOfline(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.boxFit,
      @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      height: height,
      width: width,
      fit: boxFit,
    );

    /*OptimizedCacheImage(
      height: height,
      width: width,
      fit: boxFit,
      filterQuality: FilterQuality.high,
      imageUrl: url,
      fadeInDuration: Duration(milliseconds: 0),
      fadeOutDuration: Duration(milliseconds: 0),
      placeholderFadeInDuration: Duration(milliseconds: 0),
      placeholder: (context, url) => CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );*/
  }
}
