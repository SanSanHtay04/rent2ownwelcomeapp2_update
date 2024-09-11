import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:rent2ownwelcomeapp/src/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/models/applicationStatusResponse.dart';

class SubmittedSuccessfullyTabView extends StatefulWidget {
  final ApplicationStatusResponse appStatusRes;
  const SubmittedSuccessfullyTabView({Key? key, required this.appStatusRes})
      : super(key: key);

  @override
  State<SubmittedSuccessfullyTabView> createState() =>
      _SubmittedSuccessfullyTabViewState();
}

class _SubmittedSuccessfullyTabViewState
    extends State<SubmittedSuccessfullyTabView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GifView.asset(
                'assets/images/sendingfile.gif',
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.appStatusRes.message,
                style: const TextStyle(
                  color: bg1Color,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )
            ]),
      ),
    );
  }
}
