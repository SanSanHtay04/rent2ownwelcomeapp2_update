import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class SocialPermissionDialog extends StatelessWidget {
  const SocialPermissionDialog({
    super.key,
    required this.imagePath,
    required this.message,
    this.title,
    this.primary,
    this.confirmText,
    this.cancelText,
    this.onPrimaryPressed,
    this.onSecondaaryPressed,
    this.onSkipPrepressed,
  }) : assert(message.length > 0);

  final String? title;
  final String message;
  final Color? primary;
  final String imagePath;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaaryPressed;
  final VoidCallback? onSkipPrepressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Card(
        shape: kRoundedRectangleBorder28,
        margin: kPaddingHorizontal16 + kPaddingVertical8,
        child: Padding(
          padding: kPadding16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Padding(
                      padding: kPadding4,
                      child: Image.asset(imagePath),
                    ),
                  ),
                  kSpaceHorizontal8,
                  Expanded(
                      child: Text(
                    textAlign: TextAlign.center,
                    message,
                    style: textTheme.bodyMedium,
                  )),
                ],
              ),
              kSpaceVertical16,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Image.asset('assets/icons/fb.png'),
                      onPressed: () {
                        //_onPressedLogInButton();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B5998),
                      ),
                      label: const Text("Connect with Facebook"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Image.asset('assets/icons/tt.png'),
                      onPressed: () {
                        // _onPressedTiktokButton();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      label: const Text("Connect with Tik Tok"),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      onSkipPrepressed?.call();
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: context.getColorScheme().secondary,
                        fontSize: 18,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
