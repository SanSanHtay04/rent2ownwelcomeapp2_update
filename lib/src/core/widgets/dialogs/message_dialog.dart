import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent2ownwelcomeapp/src/core/themes/dimensions.dart';
import 'package:rent2ownwelcomeapp/src/core/widgets/app_snack_bar.dart';
import 'package:rent2ownwelcomeapp/src/core/utils/utils.dart';


class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    required this.message,
    this.title,
    this.type = LogType.info,
    this.icon,
    this.closeText,
  }) : assert(message.length > 0);

  final String? title;
  final String message;
  final LogType type;

  final Widget? icon;
  final String? closeText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return IconTheme(
      data: IconThemeData(color: type.background, size: 60),
      child: SafeArea(
        child: Card(
          shape: kRoundedRectangleBorder28,
          margin: kPaddingHorizontal16 + kPaddingVertical8,
          child: Padding(
           padding: kPadding16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? 'ALERT',
                  style: GoogleFonts.codaTextTheme(textTheme).titleMedium,
                ),
                const SizedBox(height: 8),
                Divider(color: type.background),
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: message.contains('<html')
                        ? Html(data: message)
                        : Text(
                      message,
                      style: textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: type.background,
                    foregroundColor: type.foreground,
                    minimumSize: const Size(128, 38),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(closeText ?? 'Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
