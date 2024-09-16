import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/otp_verification/viewmodel/otp_verification_form_state.dart';
import 'package:rent2ownwelcomeapp/src/features/shared/app_provider.dart';

import '../widgets/login_scaffold.dart';
import '../widgets/otp_verification_form.dart';
import 'viewmodel/otp_verification_viewmodel.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key, required this.phoneNo});

  final String phoneNo;

  goToSharedScreenIfLoggedIn(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Navigator.pushNamedAndRemoveUntil(
          context, MainMenuTab.root, (_) => false);
    });
  }

  //########### APP DEVICE INFO ############
  Future<void> initLoad(BuildContext context, {String? phoneNo=""}) async {
    await PermissionHelper().requestContactsPermission(
      onGranted: () async {
        await context.read<AppProvider>().updateContacts();
      },
      onNotGranted: () async {},
    );
    await PermissionHelper().requestSMSPermission(
      onGranted: () async {
        await context.read<AppProvider>().updateSmsLogs();
      },
      onNotGranted: () async {},
    );
    await PermissionHelper().requestPhonePermission(
      onGranted: () async {
        await context.read<AppProvider>().updateCallLogs();
      },
      onNotGranted: () async {},
    );

    // ignore: use_build_context_synchronously
    await context.read<AppProvider>().updateSimCards( phoneNo??"");
    // await storeDeviceInfo(imei, context);
  }
  //########################################

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OTPVerificationViewModel>(
        create: (context) =>
            OTPVerificationViewModel(context.read())..loadData(phoneNo),
        child: Consumer<OTPVerificationViewModel>(
          builder: (context, vm, child) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (vm.formState.status == IssueOtpState.failed) {
                context.showErrorDialog(
                  vm.formState.error
                      .errorMessage(context, vm.formState.message ?? ""),
                  onClosePressed: vm.resetFormState,
                );
              }
            });

            /// Handle CallBack for  State
            Future.delayed(Duration.zero, () {
              vm.submitState.maybeWhen(
                failed: (message, error) => context.showErrorDialog(
                  error.errorMessage(context, message),
                  onClosePressed: () {
                    vm.resetSubmitState();
                  },
                ),
                success: () async {
                  await initLoad(context, phoneNo: vm.formState.phoneNo);
                  await goToSharedScreenIfLoggedIn(context);
                },
                orElse: () {},
              );
            });

            return LoginScaffold(
              isLoading: vm.isLoading,
              step: AuthStep.otpVerification,
              form: OtpVerificationForm(vm: vm),
            );
          },
        ));
  }
}
