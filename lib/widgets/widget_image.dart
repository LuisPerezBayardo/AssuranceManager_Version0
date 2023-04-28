import 'package:assurance/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  final double height;
  final double width;
  final BoxFit boxFit;
  final String url;

  const WidgetImage(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.boxFit,
      @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        height: height,
        width: width,
        fit: boxFit,
        placeholder: AssetImage(Constants.icLogo),
        image: NetworkImage(url));
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
