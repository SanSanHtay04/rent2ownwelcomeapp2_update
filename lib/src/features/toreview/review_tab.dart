import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class ReviewTab extends StatelessWidget {
  final AppStatusResponse? data;
  const ReviewTab({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding16,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFF039370),
            ),
            child: Image.asset(
              "assets/images/image3.png",
              width: 50,
              height: 50,
            ),
          ),
          kSpaceVertical32,

          Text(
            data?.appMessage ?? "",
            style: const TextStyle(
              color: Color(0xFF039370),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          kSpaceVertical16,
          const SizedBox(
            height: 16,
          ),
          // Text(
          //   widget.data!.contactMsg,
          //   style: TextStyle(
          //       color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          //   textAlign: TextAlign.center,
          // ),
          HtmlWidget(
            data?.contactMsg ?? "",
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          ),
          const SizedBox(
            height: 16,
          ),
          data?.contactNo.isNullOrEmpty ?? true
              ? Container()
              : RichText(
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
                        text: data?.contactNo ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: context.getColorScheme().primary,
                        ),
                      ),
                      const TextSpan(text: ' )'),
                    ],
                  ),
                )
        ],
      )),
    );
  }
}
