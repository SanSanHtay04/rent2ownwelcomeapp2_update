import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/themes/dimensions.dart';
import 'package:rent2ownwelcomeapp/src/core/utils/utils.dart';

import '../app_snack_bar.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({
    super.key,
    required this.imagePath,
    required this.message,
    this.title,
    this.type = LogType.confirm,
    this.primary,
    this.confirmText,
    this.cancelText,
  }) : assert(message.length > 0);

  final String? title;
  final String message;
  final LogType type;

  final Color? primary;
  final String imagePath;
  final String? confirmText;
  final String? cancelText;

  @override
  Widget build(BuildContext context) {
    final color = primary ?? type.background;
    final textTheme = Theme.of(context).textTheme;
    return IconTheme(
      data: IconThemeData(color: color, size: 60),
      child: SafeArea(
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
                        padding: const EdgeInsets.all(4), // Border radius
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: type.foreground,
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(confirmText ?? 'Allow'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                         
                          side: BorderSide(color: color),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(cancelText ?? 'Deny'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
