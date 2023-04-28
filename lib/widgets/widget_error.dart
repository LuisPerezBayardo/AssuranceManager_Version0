import 'package:assurance/widgets/widget_margin.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final Function fun;
  final String title, text, textButton;
  WidgetError(
      {@required this.fun,
      @required this.title,
      @required this.text,
      @required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_sharp,
              color: Colors.blueGrey.shade300,
              size: 64.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const WidgetMargin(
              margin: 16,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            const WidgetMargin(
              margin: 16,
            ),
            MaterialButton(
                color: Colors.blueGrey.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                onPressed: fun,
                child: Text(textButton))
          ],
        ),
      ),
    );
  }
}
