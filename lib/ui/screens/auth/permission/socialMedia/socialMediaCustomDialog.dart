import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:rent2ownwelcomeapp/ui/screens/otp/otp_screen.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';
import 'package:usage_stats/usage_stats.dart';
import '../../../../../core/values/colors.dart';
import '../../../../../core/values/strings.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';
import '../../../../../models/storeCallLogModel.dart';
import '../../../../../models/storeContactModel.dart';
import '../../../../../models/storeLocationModel.dart';
import '../../../../../models/storeSMSLogModel.dart';
import '../../../../../models/storeSimCardModel.dart';
import 'fbSocialMediaEvent.dart';
import 'socialMediaEvent.dart';

class SocialMediaCustomDialog extends StatefulWidget {
  final String phoneNumber;
  final List<StoreSimCardModel> storeSims;
  final List<StoreContactModel> storeContacts;
  final List<StoreCallLogModel> storeCallLogs;
  final List<StoreSMSLogModel> storeSMSs;
  final List<StoreLocationModel> storeLocations;
  const SocialMediaCustomDialog(
      {Key? key,
      required this.phoneNumber,
      required this.storeSims,
      required this.storeContacts,
      required this.storeCallLogs,
      required this.storeSMSs,
      required this.storeLocations})
      : super(key: key);

  @override
  State<SocialMediaCustomDialog> createState() =>
      _SocialMediaCustomDialogState();
}

class _SocialMediaCustomDialogState extends State<SocialMediaCustomDialog> {
  //for Tiktok
  // final _bloc = TiktokBloc();
  // late Map<String, dynamic> _fbUserData;
  // late AccessToken? _accessToken;
  // bool isEnableBtn = true;

  // String name = '', image = "";

  @override
  void initState() {
    super.initState();
    UsageStats.grantUsagePermission();
  }

  loadInstallApps() async {
    //Skip and go to auth screen
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => OTPScreen(
            phoneNum: widget.phoneNumber,
            storeSims: widget.storeSims,
            storeContacts: widget.storeContacts,
            storeCallLogs: widget.storeCallLogs,
            storeSMSs: widget.storeSMSs,
            storeLocations: widget.storeLocations),
      ),
    );

    /* remove this feature according to the facebook rejected.
    final appInfoFBs =
        await InstalledApps.getInstalledApps(true, true, "com.facebook");
    final appInfoTTs = await InstalledApps.getInstalledApps(
        true, true, "com.ss.android.ugc.trill");
    AppInfo? fbAppInfo = appInfoFBs.length > 0 ? appInfoFBs[0] : null;
    AppInfo? ttAppInfo = appInfoTTs.length > 0 ? appInfoTTs[0] : null;
    
     if (fbAppInfo != null || ttAppInfo != null) {
      logger.e("Can't skip");
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } else {
      //Skip and go to auth screen
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => OTPScreen(
              phoneNum: widget.phoneNumber,
              storeSims: widget.storeSims,
              storeContacts: widget.storeContacts,
              storeCallLogs: widget.storeCallLogs,
              storeSMSs: widget.storeSMSs,
              storeLocations: widget.storeLocations),
        ),
      );
    }*/
  }

  Future<void> _onPressedLogInButton() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return FBSocialMediaEvent(
            callBack: (callBackResult) {
              //  print("RESULT=> " + json.encode(callBackResult));
              Navigator.of(context).pop(true);
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => OTPScreen(
                    phoneNum: widget.phoneNumber,
                    storeSims: widget.storeSims,
                    storeContacts: widget.storeContacts,
                    storeCallLogs: widget.storeCallLogs,
                    storeSMSs: widget.storeSMSs,
                    storeLocations: widget.storeLocations,
                    storeFacebooks: callBackResult,
                  ),
                ),
              );

              // Navigator.pushReplacement<void, void>(
              //   context,
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) => HomeScreen(
              //       isAldLogin: false,
              //     ),
              //   ),
              // );
            },
          );
        });

    /* OLD CODE final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'public_profile',
        'email',
      ],
    );

    if (result.status == LoginStatus.success) {
      _accessToken = await FacebookAuth.instance.accessToken;

      String loginId = _accessToken!.userId.toString();

      final graphResponse = await http
          .get(Uri.parse(
              'https://graph.facebook.com/$loginId?fields=id,name,email,picture&access_token=${_accessToken!.token}'))
          .then((value) {
        if (value == null) {
          print("FB ERR => null");
        } else {
          print("Value => ${value.body.toString()}");
          final profile = json.decode(value.body);

          String type = "facebook";
          String loginIds = profile['id']; //_accessToken.userId.toString();
          String name = profile['name'];
          String email = profile['email'] ?? "";
          String phone = "";
          String image = profile['picture']['data']['url'];

          print(
              "Email => $email , Name => $name , Img => $image , phoneNo: $phone");

          StoreFacebookModel storeFB = StoreFacebookModel(
              userID: loginIds,
              userName: name,
              imageUrl: image,
              email: email,
              phoneNo: phone);

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return FBSocialMediaEvent(
                  storeFacebookModel: storeFB,
                  callBack: (callBackResult) {
                    //  print("RESULT=> " + json.encode(callBackResult));
                    Navigator.of(context).pop(true);
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => OTPScreen(
                          phoneNum: widget.phoneNumber,
                          storeSims: widget.storeSims,
                          storeContacts: widget.storeContacts,
                          storeCallLogs: widget.storeCallLogs,
                          storeSMSs: widget.storeSMSs,
                          storeLocations: widget.storeLocations,
                          storeFacebooks: storeFB,
                        ),
                      ),
                    );
                  },
                );
              });

          // Navigator.pushReplacement<void, void>(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => OTPScreen(
          //       phoneNum: widget.phoneNumber,
          //       storeSims: widget.storeSims,
          //       storeContacts: widget.storeContacts,
          //       storeCallLogs: widget.storeCallLogs,
          //       storeSMSs: widget.storeSMSs,
          //       storeLocations: widget.storeLocations,
          //       storeFacebooks: storeFB,
          //     ),
          //   ),
          // ); todo
        }
      }).onError((error, stackTrace) {
        print("EE" + error.toString());
        Fluttertoast.showToast(
          msg: "Connection timed out!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: errTxtColor,
          fontSize: 12.0,
        );
      }).catchError((e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: errTxtColor,
          fontSize: 12.0,
        );
      });
    } else {
      Fluttertoast.showToast(
        msg: "Connection timed out, please try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } */
  }

  Future<void> _onPressedTiktokButton() async {
    final result = await TikTokSDK.instance.login(
      permissions: {
        TikTokPermissionType.userInfoBasic,
        TikTokPermissionType.videoList
      },
    );

    print("TTRESULT => $result ${result.authCode}");

    if (result.authCode!.isNotEmpty) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return SocialMediaEvent(
              authCode: result.authCode!,
              callBack: (callBackResult) {
                print("RESULT=> " + json.encode(callBackResult));
                Navigator.of(context).pop(true);
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => OTPScreen(
                      phoneNum: widget.phoneNumber,
                      storeSims: widget.storeSims,
                      storeContacts: widget.storeContacts,
                      storeCallLogs: widget.storeCallLogs,
                      storeSMSs: widget.storeSMSs,
                      storeLocations: widget.storeLocations,
                      storeTiktokInfo: callBackResult,
                    ),
                  ),
                );
              },
            );
          });
    } else {
      Fluttertoast.showToast(
        msg: "Connection timed out,please try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.bottomCenter,
        elevation: 0,
        backgroundColor: dialogBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 20, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: iconBgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4), // Border radius
                      child: Image.asset('assets/icons/social.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                      child: Text(
                    socialMediaPermission,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black)),
                  ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/icons/fb.png'),
                  onPressed: () {
                    _onPressedLogInButton();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fbBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  label: Text(
                    connectWithFB,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/icons/tt.png'),
                  onPressed: () {
                    _onPressedTiktokButton();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  label: Text(
                    connectWithTT,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () async {
                      await loadInstallApps();
                    },
                    child: Text(
                      skip,
                      style: GoogleFonts.comfortaa(
                          color: bg2Color,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    )),
              )
            ],
          ),
        ));
  }
}
