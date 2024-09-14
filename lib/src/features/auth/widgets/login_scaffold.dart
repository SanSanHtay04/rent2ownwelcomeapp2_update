import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

enum AuthStep { login, otpVerification}
class LoginScaffold<VM extends ChangeNotifier> extends StatelessWidget {
  const LoginScaffold({
    super.key,
    this.appBar,
    this.form,
    this .step = AuthStep.login,
    this.isLoading = false,
  });

  final AppBar? appBar;
  final Widget? form;
  final AuthStep step;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    
    return WorkLayout(
      isBusy: isLoading,
      child: step == AuthStep.login? Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _loginContent(),
      ) : _loginContent(),
    );
  }
  Widget _loginContent(){
    return Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: kPaddingHorizontal16,
                  child: Column(
                    children: [
                      _loginHeader(),
                      kSpaceVertical20,
                      form!,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }

  Widget _loginHeader() {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: kPaddingHorizontal28 + kPaddingVertical16,
                child: const Image(
                  image: AssetImage('assets/images/home.png'),
                  fit: BoxFit.fill,
                ),
              ),
               Text( step == AuthStep.login? "WELCOME APP": 
                'Please enter the OTP sent to your phone',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
              Text('${snapshot.data?.version}',
              style: const TextStyle(color: Colors.black),),
            ],
          );
        });
  }
}