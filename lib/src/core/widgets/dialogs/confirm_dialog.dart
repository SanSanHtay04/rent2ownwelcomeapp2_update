import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.message,
    this.title,
    this.type = LogType.confirm,
    this.primary,
    this.icon,
    this.confirmText,
    this.cancelText,
  }) : assert(message.length > 0);

  final String? title;
  final String message;
  final LogType type;

  final Color? primary;
  final Widget? icon;
  final String? confirmText;
  final String? cancelText;

  @override
  Widget build(BuildContext context) {
    final color = primary ?? type.background;
    final textTheme = context.getTextTheme();
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
                icon ?? Icon(type.icon),
                kSpaceVertical16,
                if (title?.isNotEmpty ?? false) ...[
                  kSpaceVertical8,
                  Text(
                    title ?? '',
                    style: GoogleFonts.codaTextTheme(textTheme).headlineSmall,
                  ),
                ],
                kSpaceVertical8,
                Text(
                  message,
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                kSpaceVertical16,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: color,
                          side: BorderSide(color: color),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(cancelText ?? context.tr.actionCancel),
                      ),
                    ),
                    kSpaceHorizontal16,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: type.foreground,
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(confirmText ?? context.tr.actionConfirm),
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
