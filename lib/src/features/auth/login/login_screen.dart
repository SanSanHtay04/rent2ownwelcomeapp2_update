import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/features.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/login/viewmodel/login_view_model.dart';

import '../widgets/login_scaffold.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  goToSharedScreenIfLoggedIn(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainMenuTab.root, (_) => false);
    });
  }

  goToOtpVerification(BuildContext context, String data) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final formState = context.read<LoginViewModel>().formState;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                OTPVerificationScreen(phoneNo: formState.phoneNumber)),
      );
      context.read<LoginViewModel>().resetSubmitState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(context.read(), context.read()),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, unsubscribedChild) {
          /// Handle CallBack for State
          Future.delayed(Duration.zero, () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              bool isLoggedIn = context.read<LocalAuthProvider>().isLoggedIn;
              if (isLoggedIn) goToSharedScreenIfLoggedIn(context);
            });

            vm.submitState.maybeWhen(
              failed: (message, error) => context.showErrorDialog(
                error.errorMessage(context, message),
                onClosePressed: vm.resetSubmitState,
              ),
              success: (data) => goToOtpVerification(context, data),
              orElse: () {},
            );
          });

          return LoginScaffold(
            isLoading: vm.isLoading,
            form: LoginForm(vm: vm),
          );
        },
      ),
    );
  }
}
