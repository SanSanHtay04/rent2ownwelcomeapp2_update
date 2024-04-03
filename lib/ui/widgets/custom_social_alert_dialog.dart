import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent2ownwelcomeapp/core/values/strings.dart';

import '../../core/values/colors.dart';

class MCustomSocialAlertDialog extends StatefulWidget {
  MCustomSocialAlertDialog({Key? key}) : super(key: key);

  @override
  State<MCustomSocialAlertDialog> createState() =>
      _MCustomSocialAlertDialogState();
}

class _MCustomSocialAlertDialogState extends State<MCustomSocialAlertDialog> {
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
                      child: Image.asset('assets/icons/social.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                      child: Text(
                    socialMediaPermission,
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
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/icons/fb.png'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fbBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  label: Text(
                    connectWithFB,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/icons/tt.png'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  label: Text(
                    connectWithTT,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
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
