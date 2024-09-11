import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent2ownwelcomeapp/src/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/src/core/values/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MCustomAlertDialog extends StatefulWidget {
  final String icon;
  final String title;
  final Function onClickBtn1;
  final Function onClickBtn2;
  const MCustomAlertDialog(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onClickBtn1,
      required this.onClickBtn2})
      : super(key: key);

  @override
  State<MCustomAlertDialog> createState() => _MCustomAlertDialogState();
}

class _MCustomAlertDialogState extends State<MCustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.bottomCenter,
        elevation: 0,
        backgroundColor: dialogBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 30, 12, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: iconBgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4), // Border radius
                      child: Image.asset(widget.icon),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                      child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black)),
                  ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onClickBtn1();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bg2Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    allow,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: errorMessage,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: errTxtColor,
                      fontSize: 12.0,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    deny,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
