import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/otp_verification/viewmodel/otp_verification_viewmodel.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key, required this.vm, required this.smsListener});

  final OTPVerificationViewModel vm;
  final Function smsListener;

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final int TIMER_DURATION = 30;
  final StreamController _timerStream = StreamController<int>();
  late int timerCounter;
  late Timer _resendCodeTimer;

  @override
  void initState() {
    super.initState();
    activeCounter();
  }

  @override
  void dispose() {
    super.dispose();
    _timerStream.close();
    _resendCodeTimer.cancel();
  }

  activeCounter() {
    _resendCodeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (TIMER_DURATION - timer.tick > 0) {
        _timerStream.sink.add(TIMER_DURATION - timer.tick);
      } else {
        _timerStream.sink.add(0);
        _resendCodeTimer.cancel();
      }
    });
  }

  Future<void> _onClickRetry() async {
    // textEditingController.clear();
   widget.vm.generateOtp();
    widget.smsListener();
    activeCounter();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _timerStream.stream,
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        return Center(
            child: snapshot.data == 0
                ? TextButton(
                    onPressed: widget.vm.isLoading ? null : _onClickRetry,
                    child: Text('Try Again'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Please wait -  ${snapshot.hasData ? snapshot.data.toString() : 30} seconds to Try Again',
                      ),
                    ],
                  ));
      },
    );
  }
}
