import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent2ownwelcomeapp/core/values/strings.dart';
import 'package:rent2ownwelcomeapp/models/api_response.dart';
import 'package:rent2ownwelcomeapp/models/verifyOtpReponse.dart';
import 'package:rent2ownwelcomeapp/network/network.dart';
import 'package:rent2ownwelcomeapp/ui/screens/otp/otpBloc.dart';
import 'package:rent2ownwelcomeapp/ui/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/values/colors.dart';

class OTPEvent extends StatefulWidget {
  final String phoneNum;
  final String otpCode;
  final Function callBack;
  const OTPEvent(
      {Key? key,
      required this.phoneNum,
      required this.otpCode,
      required this.callBack})
      : super(key: key);

  @override
  State<OTPEvent> createState() => _OTPEventState();
}

class _OTPEventState extends State<OTPEvent> {
  final _bloc = OTPBloc();

  @override
  void initState() {
    _bloc.verifyOTPCode(widget.phoneNum, widget.otpCode);
    super.initState();
  }

  Future<void> setAccessTokenDataToSharedPreference(String accessToken) async {
    SharedPreferences spfs = await SharedPreferences.getInstance();
    spfs.setString(ACCESS_TOKEN, accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.verifyOTPStream(),
      initialData:
          ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr),
      builder: (context, snapshot) {
        ApiResponse resOb = snapshot.data!;

        if (resOb.msgState == MsgState.loading) {
          return Loading();
        } else if (resOb.msgState == MsgState.data) {
          VerifyOtpReponse verifyOTPRes = resOb.data;
          String accessToken = verifyOTPRes.accessToken;

          setAccessTokenDataToSharedPreference(accessToken);

          Future.delayed(const Duration(milliseconds: 300), () {
            widget.callBack();
          });

          return Container();
        } else {
          if (resOb.errorState == ErrorState.serverErr) {
          } else if (resOb.errorState == ErrorState.notFoundErr) {
          } else if (resOb.errorState == ErrorState.badRequest) {
          } else {}

          Fluttertoast.showToast(
            msg: invalidOTPerrorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: errTxtColor,
            fontSize: 12.0,
          );

          Navigator.of(context).pop();

          return Container();
        }
      },
    );
  }
}
