import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/login/viewmodel/login_view_model.dart';

class OtpLoginForm extends StatelessWidget {
  const OtpLoginForm({super.key, required this.vm});

  final LoginViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhoneTextFormField(
            labelText: 'Phone Number',
            initialValue: vm.formState.phoneNumber,
            required: true,
            onChanged: vm.updatePhoneNumber,
          ),
          kSpaceVertical20,
          Row(children: [
            Expanded(
                child: ElevatedButton(
              onPressed: vm.enableButton ? () => vm.generateOtp() : null,
              child: const Text('Login'),
            )),
          ]),
        ],
      ),
    );
  }
}
