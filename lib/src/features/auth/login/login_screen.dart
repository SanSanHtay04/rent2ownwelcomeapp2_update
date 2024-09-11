import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/features.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/login/viewmodel/login_view_model.dart';
import 'package:rent2ownwelcomeapp/src/features/home_screen.dart';


import '../widgets/login_scaffold.dart';
import '../widgets/otp_login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

   goToSharedScreenIfLoggedIn(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (_) => false);
    });
  }


  goToOtpVerification(BuildContext context, String data) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
       final formState = context.read<LoginViewModel>().formState;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OTPVerificationScreen(phoneNo: formState.phoneNumber)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(context.read()),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, unsubscribedChild) {


          /// Handle CallBack for LoginSubmit State
          Future.delayed(Duration.zero, () {

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              // TODO: rather than checking the current user is already authenticated in UI, better to handle it before routing
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
            form: OtpLoginForm(vm: vm),
          );
        },
      ),
    );
  }
}
