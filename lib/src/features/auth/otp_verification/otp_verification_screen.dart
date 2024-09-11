import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home_screen.dart';

import '../widgets/login_scaffold.dart';
import '../widgets/otp_verification_form.dart';
import 'viewmodel/otp_verification_viewmodel.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key, required this.phoneNo});

  final String phoneNo;

  goToSharedScreenIfLoggedIn(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (_) => false);
    });
  }

  //########### APP DEVICE INFO ############
  /*
  Future<String> getImeiNo() async {
    return await AppDeviceInfo().getImei();
  }

  Future<void> storeCallLogs(String imeiNo, BuildContext context) async {
    try {
      List<DeviceInfoCallLog>? callLogs = await AppDeviceInfo().getCallLogs(imeiNo);
      if (callLogs.length > 0) {
        await Provider.of<DeviceInfoCallLogProvider>(context, listen: false).storeCallLogs(callLogs, imeiNo);
      }
    } catch (error) {
      print('Get error while getting & creating call logs: ${error.toString()}');
    }
  }

  Future<void> storeSmsLogs(String imeiNo, BuildContext context) async {
    try {
      List<DeviceInfoSmsLog>? smsLogs = await AppDeviceInfo().getSmsLogs(imeiNo);
      if (smsLogs.length > 0) {
        await Provider.of<DeviceInfoSmsLogProvider>(context, listen: false).storeSmsLogs(smsLogs, imeiNo);
      }
    } catch (error) {
      print('Get error while getting & creating sms logs: ${error.toString()}');
    }
  }

  Future<void> storeContacts(String imeiNo, BuildContext context) async {
    try {
      List<DeviceInfoContact>? contacts = await AppDeviceInfo().getContacts(imeiNo);
      if (contacts.length > 0) {
        await Provider.of<DeviceInfoContactProvider>(context, listen: false).storeContacts(contacts, imeiNo);
      }
    } catch (error) {
      print('Get error while getting & creating contacts: ${error.toString()}');
    }
  }

  Future<void> storeLiveLocation(String imeiNo, BuildContext context) async {
    try {
      DeviceInfoLiveLocation liveLocation = await AppDeviceInfo().getLocation(imeiNo);
      await Provider.of<DeviceInfoLiveLocationProvider>(context, listen: false).storeLocation(liveLocation, imeiNo);
    } catch (error) {
      print('Get error while getting & creating live location: ${error.toString()}');
    }
  }

  Future<void> storeSimCards(String imeiNo, BuildContext context) async {
    try {
      DeviceInfoSimCard simdCard = await AppDeviceInfo().getSimCards(imeiNo);
      await Provider.of<DeviceInfoSimCardProvider>(context, listen: false).storeSimCard(simdCard, imeiNo);
    } catch (error) {
      print('Get error while getting & creating live location: ${error.toString()}');
    }
  }

  Future<void> storeDeviceInfo(String imeiNo, BuildContext context) async {
    try {
      DeviceInfoDevice device = await AppDeviceInfo().getDeviceInfo(imeiNo);
      await Provider.of<DeviceInfoDeviceProvider>(context, listen: false).storeDevice(device, imeiNo);
    } catch (error) {
      print('Get error while getting & creating device info: ${error.toString()}');
    }
  }
  //########################################

  Future<void> initLoad(BuildContext context) async {
    String imei = await getImeiNo();
    await PermissionHelper().requestLocationPermission(
      onGranted: () async { await storeLiveLocation(imei, context); },
      onNotGranted: () async { await showLocationPermissionRequired(context); },
    );
    await PermissionHelper().requestContactsPermission(
      onGranted: () async { await storeContacts(imei, context); },
      onNotGranted: () async { await showContactsPermissionRequired(context); },
    );
    await PermissionHelper().requestSMSPermission(
      onGranted: () async { await storeSmsLogs(imei, context); },
      onNotGranted: () async { await showSMSPermissionRequired(context); },
    );
    await PermissionHelper().requestPhonePermission(
      onGranted: () async { await storeCallLogs(imei, context); },
      onNotGranted: () async { await showPhonePermissionRequired(context); },
    );
    // await storeSimCards(imei);
    await storeDeviceInfo(imei, context);

  }
  */

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OTPVerificationViewModel>(
        create: (context) =>
            OTPVerificationViewModel(context.read())..loadData(phoneNo),
        child: Consumer<OTPVerificationViewModel>(
          builder: (context, vm, child) {
            /// Handle CallBack for LoginSubmit State
            Future.delayed(Duration.zero, () {
              vm.submitState.maybeWhen(
                failed: (message, error) => context.showErrorDialog(
                  error.errorMessage(context, message),
                  onClosePressed: vm.resetSubmitState,
                ),
                success: () async {
                  
                 // await initLoad(context);
                  await goToSharedScreenIfLoggedIn(context);
                },
                orElse: () {},
              );
            });

            return LoginScaffold(
              appBar: SimpleToolbar(title: "Verify OTP"),
              isLoading: vm.isLoading,
              form: OtpVerificationForm(vm: vm),
            );
          },
        ));
  }
}
