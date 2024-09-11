import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rent2ownwelcomeapp/src/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/models/applicationStatusResponse.dart';

class ToReviewTabView extends StatefulWidget {
  final ApplicationStatusResponse? appStatusRes;
  const ToReviewTabView({Key? key, this.appStatusRes}) : super(key: key);

  @override
  State<ToReviewTabView> createState() => _ToReviewTabViewState();
}

class _ToReviewTabViewState extends State<ToReviewTabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: bg1Color),
            child: Image.asset(
              "assets/images/image3.png",
              // scale: 1,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.appStatusRes!.message,
            style: const TextStyle(
              color: bg1Color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          // Text(
          //   widget.appStatusRes!.contactMsg,
          //   style: TextStyle(
          //       color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          //   textAlign: TextAlign.center,
          // ),
          HtmlWidget(
            widget.appStatusRes!.contactMsg,
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          ),
          const SizedBox(
            height: 16,
          ),
          widget.appStatusRes!.contactNo.isNotEmpty
              ? RichText(
                  text: TextSpan(
                    text: '( ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Uri phoneno = Uri.parse(
                            //     'tel:${widget.appStatusRes!.contactNo}');
                            // if (await launchUrl(phoneno)) {
                            //   //dialer opened
                            // } else {
                            //   //dailer is not opened
                            // }
                          },
                        text: widget.appStatusRes!.contactNo,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: bg1Color),
                      ),
                      const TextSpan(text: ' )'),
                    ],
                  ),
                )
              : Container()
        ],
      )),
    );
  }
}
