import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/core/helpers/permission_helper.dart';

class DevicePermissionDialog extends StatelessWidget {
  const DevicePermissionDialog({
    super.key,
    required this.imagePath,
    required this.message,
    this.title,
    this.primary,
    this.confirmText,
    this.cancelText,
    this.onConfirmPressed,
    this.onCancelPressed, 
    required this.nextPermissionView,
  }) : assert(message.length > 0);

  final String? title;
  final String message;
  final Color? primary;
  final String imagePath;
  final String? confirmText;
  final String? cancelText;
  final Function(bool)? onConfirmPressed;
  final VoidCallback? onCancelPressed;
  final Widget nextPermissionView;

  Future<void> onConfirmClicked(BuildContext context) async {
    bool status = await PermissionHelper().requestDevicePermission();
    AppLogger.i("DEVICE PERMISSION: $status");
    onConfirmPressed?.call(status);
    if(status) {
      // ignore: use_build_context_synchronously
      _gotoLocationPermissionDialog(context);
    }

   
  }
 void  _gotoLocationPermissionDialog(BuildContext context){
        Navigator.of(context).pop(true);

         showModalBottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          isDismissible: false,
          context: context,
          builder: (_) => nextPermissionView,
        );
  }

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
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirmClicked(context);
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
                      onPressed: () {
                        onCancelPressed?.call();
                      //  Navigator.pop(context, false);
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
    );
  }
}
