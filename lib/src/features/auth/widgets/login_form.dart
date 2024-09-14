import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/login/viewmodel/login_view_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.vm});

  final LoginViewModel vm;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String mobileNumber = (await MobileNumber.mobileNumber)!;
      widget.vm.updatePhoneNumber(mobileNumber);
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhoneTextFormField(
            labelText: 'Phone Number',
            initialValue: widget.vm.formState.phoneNumber,
            required: true,
            onChanged: widget.vm.updatePhoneNumber,
          ),
          kSpaceVertical20,
          LoginButton(vm: widget.vm, widget: widget, formKey: _formKey),
        ],
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
    required this.vm,
    required this.widget,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final LoginViewModel vm;
  final LoginForm widget;
  final GlobalKey<FormState> _formKey;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late Widget permissionDialog;

  @override
  void initState() {
    permissionDialog = DevicePermissionDialog(
      message:
          "Allow Contacts,Call Log and SMS log access to R2O for better customer Service",
      imagePath: 'assets/icons/logs.png',
      onConfirmPressed: (result) {},
      onCancelPressed: () =>
          AppSettings.openAppSettings(type: AppSettingsType.settings),
      nextPermissionView: LocationPermissionDialog(
        message:
            "Allow Live Location access to R2O for better customer Service",
        imagePath: 'assets/icons/map.png',
        onConfirmPressed: (_) {},
        onCancelPressed: () {},
        nextPermissionView: SocialPermissionDialog(
          message:
              "Connect your social media for better customer understanding",
          imagePath: 'assets/icons/social.png',
          onSkipPrepressed: () {
            widget.vm.generateOtp();
          },
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ElevatedButton(
        onPressed: widget.widget.vm.enableButton
            ? () {
                FocusScope.of(context).unfocus();

                final isValidate =
                    widget._formKey.currentState?.validate() ?? false;
                if (!isValidate) {
                  "Notice: Please enter phone number starting with 09.[Example : 09xxxxxxxxx]"
                      .showWarningSnackBar(context);
                } else {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    isDismissible: false,
                    context: context,
                    builder: (_) => permissionDialog,
                  );
                }
              }
            : null,
        child: const Text('Login'),
      )),
    ]);
  }
}
