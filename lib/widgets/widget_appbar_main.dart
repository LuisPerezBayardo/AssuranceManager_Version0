import 'package:flutter/material.dart';

class WidgetAppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;
  final bool isBack;
  final Function back;

  const WidgetAppBarMain(
      {Key key,
      @required this.appBar,
      @required this.title,
      @required this.isBack,
      @required this.back})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: back)
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height + 10);
}
