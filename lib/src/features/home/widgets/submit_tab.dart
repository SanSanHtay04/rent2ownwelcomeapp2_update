import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/core/values/colors.dart';

class SubmitTab extends StatelessWidget {
  final AppStatusResponse data;
  const SubmitTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding20,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GifView.asset(
                'assets/images/sendingfile.gif',
                fit: BoxFit.contain,
              ),
              kSpaceVertical20,
          
              Text(
                data.appMessage,
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
