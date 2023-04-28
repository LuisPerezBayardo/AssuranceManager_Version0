import 'package:flutter/material.dart';

class WidgetAppBarReturn {

  static Widget widget_appbar_return(BuildContext context, String title, bool isBack, Function b) {
    return AppBar(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: isBack
          ? IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: b)
          : null,
    );
  }

}
