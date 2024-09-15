import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gif_view/gif_view.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';


class StatusAcceptedTab extends StatefulWidget {
  final AppStatusResponse? data;
  const StatusAcceptedTab({super.key,  this.data});

  @override
  State<StatusAcceptedTab> createState() => _StatusAcceptedTabState();
}

class _StatusAcceptedTabState extends State<StatusAcceptedTab> {

  late  ConfettiController _controllerCenter ;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    play();

    super.initState();
  }

  play() {
    _controllerCenter.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerCenter.play();
    return 
    SafeArea(
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
              padding: kPadding12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kSpaceVertical64,

                 
                  Text(
                    widget.data?.appMessage??"",
                    style:  TextStyle(
                      color: context.getColorScheme().primary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                 
                  kSpaceVertical20,
                  
                  HtmlWidget(
                    widget.data?.contactMsg??"",
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
}
