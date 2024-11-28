import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomResponseDialog extends StatefulWidget {
  final BuildContext context;
  final String message;
  final String btnText;
  final String type;
  final Function onPressedFunction;
  CustomResponseDialog(
      {required this.context,
      required this.message,
      this.btnText = "",
      required this.type,
      required this.onPressedFunction});

  @override
  _CustomResponseDialogState createState() => _CustomResponseDialogState();
}

class _CustomResponseDialogState extends State<CustomResponseDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
        data: CupertinoThemeData(brightness: Brightness.light),
        child: CupertinoAlertDialog(
          content: Container(
              padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.message,
                    style: const TextStyle(fontSize: 16, height: 1.2),
                  ),
                ],
              )),
          actions: <Widget>[
            widget.type == "fail"
                ? ElevatedButton(
                    child: Text(widget.btnText,
                        style: const TextStyle(fontSize: 16)),
                    onPressed: () {
                      widget.onPressedFunction();
                    },
                  )
                : Container(),
          ],
        ));
  }
}
