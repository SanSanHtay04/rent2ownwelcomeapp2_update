import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gif_view/gif_view.dart';
import 'package:rent2ownwelcomeapp/models/applicationStatusResponse.dart';

import '../../core/values/colors.dart';

class StatusAcceptedTabView extends StatefulWidget {
  final ApplicationStatusResponse appStatusRes;
  const StatusAcceptedTabView({Key? key, required this.appStatusRes})
      : super(key: key);

  @override
  State<StatusAcceptedTabView> createState() => _StatusAcceptedTabViewState();
}

class _StatusAcceptedTabViewState extends State<StatusAcceptedTabView> {
  final ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  @override
  void initState() {
    // _controllerCenter =
    //     ConfettiController(duration: const Duration(seconds: 10));
    play();

    super.initState();
  }

  play() {
    _controllerCenter.play();
  }

  // @override
  // void dispose() {
  //   _controllerCenter.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    _controllerCenter.play();
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            heightFactor: 2,
            alignment: Alignment.center,
            child: SizedBox(
              height: 180,
              width: 180,
              child: GifView.asset(
                'assets/images/congrats.gif',
              ),
              // Image.asset(
              //   "assets/images/image6.png",
              //   scale: 1,
              // ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality:
                  BlastDirectionality.explosive, // radial value - LEFT
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              shouldLoop: true,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    widget.appStatusRes.message,
                    style: const TextStyle(
                      color: bg1Color,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Text(
                  //   widget.appStatusRes.contactMsg,
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 11),
                  //   textAlign: TextAlign.justify,
                  // ),
                  HtmlWidget(
                    widget.appStatusRes.contactMsg,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
  }
}
