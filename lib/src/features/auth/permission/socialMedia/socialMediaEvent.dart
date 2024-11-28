import 'package:flutter/material.dart';
import 'package:rent2ownwelcomeapp/src/features/auth/permission/socialMedia/tiktok_bloc.dart';
import 'package:rent2ownwelcomeapp/src/core/widgets/loading.dart';
import '../../../../../models/api_response.dart';
import '../../../../core/widgets/custom_response_dialog.dart';

class SocialMediaEvent extends StatefulWidget {
  final String authCode;
  final Function callBack;
  SocialMediaEvent({Key? key, required this.authCode, required this.callBack})
      : super(key: key);

  @override
  State<SocialMediaEvent> createState() => _SocialMediaEventState();
}

class _SocialMediaEventState extends State<SocialMediaEvent> {
  final _bloc = TiktokBloc();

  @override
  void initState() {
    _bloc.getToken(authCode: widget.authCode);

    // _bloc.getUserInfo(
    //     accessToken:
    //         "act.89f7f4067906368fd36ab1d1168a2039lf0J7CGPnggQqFjRufTOCT17DSzj!5630");

    // _bloc.getVideoList(
    //     accessToken:
    //         "act.89f7f4067906368fd36ab1d1168a2039lf0J7CGPnggQqFjRufTOCT17DSzj!5630");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse>(
      stream: _bloc.getStoreTikTokInfoStream(),
      initialData:
          ApiResponse(msgState: MsgState.loading, errorState: ErrorState.noErr),
      builder: (context, snapshot) {
        ApiResponse resOb = snapshot.data!;

        if (resOb.msgState == MsgState.loading) {
          return Loading();
        } else if (resOb.msgState == MsgState.data) {
          Future.delayed(const Duration(milliseconds: 300), () {
            widget.callBack(resOb.data);
          });

          return Container();
        } else {
          String errMsg = "";

          if (resOb.errorState == ErrorState.serverErr) {
            errMsg = "500 Internal Server.";
          } else if (resOb.errorState == ErrorState.notFoundErr) {
            errMsg = "404 Not Found Error.";
          } else if (resOb.errorState == ErrorState.badRequest) {
            errMsg = "Bad Request Error.";
          } else {
            errMsg = "Ooooops \n Something went wrong.";
          }

          return WillPopScope(
              onWillPop: () async => false,
              child: CustomResponseDialog(
                context: context,
                message: "$errMsg\n Please try again!",
                btnText: "OK",
                type: "fail",
                onPressedFunction: () {
                  Navigator.of(context).pop();
                },
              ));
        }
      },
    );
  }
}
