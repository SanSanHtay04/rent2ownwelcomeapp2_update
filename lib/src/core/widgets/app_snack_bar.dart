import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';


class AppSnackBar {
  static final scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();

  static showErrorSnackBar(String message) {
    if (scaffoldMessageKey.currentContext == null) return;
    message.showErrorSnackBar(scaffoldMessageKey.currentContext!);
  }

  static showWarningSnackBar(String message) {
    if (scaffoldMessageKey.currentContext == null) return;
    message.showErrorSnackBar(scaffoldMessageKey.currentContext!);
  }

  static showInfoSnackBar(String message) {
    if (scaffoldMessageKey.currentState == null) return;
    message.showInfoSnackBar(scaffoldMessageKey.currentContext!);
  }
}

extension SnackBarX on String {
  showErrorSnackBar(BuildContext context) {
    _showSnackBar(context, this, LogType.error);
  }

  showWarningSnackBar(BuildContext context) {
    _showSnackBar(context, this, LogType.warning);
  }

  showInfoSnackBar(BuildContext context) {
    _showSnackBar(context, this, LogType.info);
  }

  showDebugSnackBar(BuildContext context) {
    if (!kDebugMode) return;
    _showSnackBar(context, this, LogType.debug);
  }
}

_showSnackBar(BuildContext context, String message, LogType type) {
  ScaffoldMessenger.of(context)
      .showSnackBar(_createAppSnackBar(message, type: type));
}

SnackBar _createAppSnackBar(
  String message, {
  LogType type = LogType.info,
}) {
  return SnackBar(
    content: Row(
      children: [
        Icon(type.icon, color: type.foreground),
        const SizedBox(width: 16),
        Expanded(
          child: Text(message, style: TextStyle(color: type.foreground)),
        ),
      ],
    ),
    duration: _snackBarDisplayDuration,
    backgroundColor: type.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    behavior: SnackBarBehavior.floating,
  );
}

extension DialogContextX on BuildContext {
  showDevelopmentSnackBar() => _showSnackBar(
        this,
        'In development',
        LogType.debug,
      );



  Future<bool> showConfirmDialog({
    required String message,
    String? title,
    LogType type = LogType.confirm,
    Color? primary,
    Widget? icon,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirmPressed,
    VoidCallback? onCancelPressed,
    bool isDismissible = true,
  }) async {
    if (type == LogType.debug && !kDebugMode) return false;
    final bool confirm = await showModalBottomSheet(
      context: this,
      builder: (_) => ConfirmDialog(
        message: message,
        title: title,
        type: type,
        primary: primary,
        icon: icon,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: isDismissible,
    ) ??
        false;
    final callback = confirm ? onConfirmPressed : onCancelPressed;
    callback?.call();
    return confirm;
  }


  // Future<bool> showPermissionDialog({
  //   required String message,
  //   String? title,
  //   LogType type = LogType.confirm,
  //   Color? primary,
  //   required String imagePath,
  //   String? confirmText,
  //   String? cancelText,
  //   VoidCallback? onConfirmPressed,
  //   VoidCallback? onCancelPressed,
  //   bool isDismissible = true,
  // }) async {
  //   if (type == LogType.debug && !kDebugMode) return false;
  //   final bool confirm = await showModalBottomSheet(
  //         context: this,
  //         builder: (_) => PermissionDialog(
  //           message: message,
  //           title: title,         
  //           primary: primary,
  //           imagePath: imagePath,
  //           confirmText: confirmText,
  //           cancelText: cancelText,
  //         ),
  //         backgroundColor: Colors.transparent,
  //         enableDrag: false,
  //         isDismissible: isDismissible,
  //       ) ??
  //       false;
  //   final callback = confirm ? onConfirmPressed : onCancelPressed;
  //   callback?.call();
  //   return confirm;
  // }

  Future<void> showMessageDialog({
    required String message,
    String? title,
    LogType type = LogType.info,
    Widget? icon,
    String? closeText,
    VoidCallback? onClosePressed,
    bool isDismissible = true,
  }) async {
    if (type == LogType.debug && !kDebugMode) return;
    await showModalBottomSheet(
      context: this,
      builder: (_) => MessageDialog(
        message: message,
        title: title,
        type: type,
        icon: icon,
        closeText: closeText,
      ),
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: isDismissible,
    );
    onClosePressed?.call();
  }

  showErrorDialog(String message,
      {String? title, VoidCallback? onClosePressed}) {
    Future.delayed(Duration.zero, () {
      showMessageDialog(
        title: title ?? 'ERROR',
        message: message,
        type: LogType.error,
        onClosePressed: onClosePressed,
      );
    });
  }

  showTodoDialog(String message) {
    showMessageDialog(
      title: 'TODO',
      message: message,
      type: LogType.debug,
    );
  }
}

// This is custom log type for application usage
const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

enum LogType {
  debug(Icons.bug_report_rounded, Colors.blue, Colors.white),
  info(Icons.info_rounded, Colors.green, Colors.white),
  warning(Icons.warning_rounded, Colors.amber, Colors.white),
  error(Icons.cancel_rounded, Colors.red, Colors.white),
  confirm(Icons.question_mark_rounded, Colors.green, Colors.white);

  final IconData icon;
  final Color background;
  final Color foreground;

  const LogType(this.icon, this.background, this.foreground);
}
