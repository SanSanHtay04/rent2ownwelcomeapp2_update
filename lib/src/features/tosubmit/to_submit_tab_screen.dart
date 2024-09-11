import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/models/applicationStatusResponse.dart';

class ToSubmitTabView extends StatefulWidget {
  final ApplicationStatusResponse? appStatusRes;
  const ToSubmitTabView({Key? key, this.appStatusRes}) : super(key: key);

  @override
  State<ToSubmitTabView> createState() => _ToSubmitTabViewState();
}

class _ToSubmitTabViewState extends State<ToSubmitTabView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 230,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: const Color.fromRGBO(218, 218, 218, 0.15)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/image1.png",
              // scale: 1,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              child: Text(
                widget.appStatusRes!.statusMessage,
                style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ]),
    ));
  }
}
