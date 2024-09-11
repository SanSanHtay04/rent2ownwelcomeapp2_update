import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class LoginScaffold<VM extends ChangeNotifier> extends StatelessWidget {
  const LoginScaffold({
    super.key,
    this.appBar,
    this.form,
    this.isLoading = false,
  });

  final AppBar? appBar;
  final Widget? form;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return WorkLayout(
      isBusy: isLoading,
      child: Column(
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
      ),
    );
  }

  Widget _loginHeader() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
          child: Image(
            image: AssetImage('assets/images/r2o_logo.png'),
            fit: BoxFit.fill,
          ),
        ),
        Text(
          'SA APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromRGBO(0, 100, 160, 1),
          ),
        ),
      ],
    );
  }
}
/*
   return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        width: context.getScreenSize().width,
        height: context.getScreenSize().height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            Positioned(
              bottom: -160,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.84,
                decoration: const BoxDecoration(
                  color: Color(0xFF039370),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(500),
                      topRight: Radius.circular(500)),
                ),
                
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 320,
                    decoration: const BoxDecoration(
                      color: Color(0xFF91D234),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(320),
                          topRight: Radius.circular(320)),
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "WELCOME\n$_versionNumber",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      kSpaceVertical24,
                      PhoneTextFormField(
                        labelText: "Phone Number",
                        initialValue: _initPhoneNumber,
                        required: true,
                        onChanged: updatePhoneNumber,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              final isValidate =
                                  _formKey.currentState?.validate() ?? false;
                              if (!isValidate) {
                                "Notice: Please enter phone number starting with 09.[Example : 09xxxxxxxxx]"
                                    .showWarningSnackBar(context);
                              } else {
                                // _showAppSettingsDialog();

                                if (storeSims.isEmpty) {
                                  storeSims.add(
                                    StoreSimCardModel(
                                        simCardNo1: _initPhoneNumber),
                                  );
                                }
                                setState(() {
                                  isEnable = false;
                                });
                                showDialog(
                                  barrierDismissible: false,
                                  barrierColor: Colors.black26,
                                  context: context,
                                  builder: (context) =>
                                      ContactCallNSMSLogsCustomDialog(
                                    phoneNumber: _initPhoneNumber,
                                    storeSims: storeSims,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.getColorScheme().secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),


            Positioned(
              left: 0,
              top: 180,
              right: 0,
              child: Image.asset("assets/images/home.png", height: 165),
            ),

            
          ],
        ),
      ),
    );
*/
