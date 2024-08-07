import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rent2ownwelcomeapp/models/storeLocationModel.dart';
import 'package:rent2ownwelcomeapp/utils/logger.dart';
import '../../../../../core/values/colors.dart';
import '../../../../../core/values/strings.dart';
import '../../../../../models/storeCallLogModel.dart';
import '../../../../../models/storeContactModel.dart';
import '../../../../../models/storeSMSLogModel.dart';
import '../../../../../models/store_sim_card_model.dart';
import '../socialMedia/socialMediaCustomDialog.dart';

class LocationCustomDialog extends StatefulWidget {
  final String phoneNumber;
  final List<StoreSimCardModel> storeSims;
  final List<StoreContactModel> storeContacts;
  final List<StoreCallLogModel> storeCallLogs;
  final List<StoreSMSLogModel> storeSMSs;
  LocationCustomDialog(
      {Key? key,
      required this.phoneNumber,
      required this.storeSims,
      required this.storeContacts,
      required this.storeCallLogs,
      required this.storeSMSs})
      : super(key: key);

  @override
  State<LocationCustomDialog> createState() => _LocationCustomDialogState();
}

class _LocationCustomDialogState extends State<LocationCustomDialog> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  List<StoreLocationModel> _storeLocations = [];
  bool isEnableBtn = true;

  Future<PermissionStatus> _getLocationPermission() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      return permissionStatus;
    } else {
      //await openAppSettings();
      return permission;
    }
  }

  void _handleInvalidLocationPermissions(
      PermissionStatus permissionStatus) async {
    if (permissionStatus == PermissionStatus.denied) {
      Fluttertoast.showToast(
        msg: "Access to location data denied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
        msg: "Location data not available on device",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Location Error!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    }
  }

  getCurrentLocation() async {
    PermissionStatus permissionStatus = await _getLocationPermission();
    if (permissionStatus == PermissionStatus.granted) {
      final position = await _geolocatorPlatform.getCurrentPosition();
      logger.i("POSITION => ${position.latitude} , ${position.longitude}");

      StoreLocationModel location = StoreLocationModel(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString());
      _storeLocations.add(location);

      Navigator.of(context).pop(true);
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return SocialMediaCustomDialog(
            phoneNumber: widget.phoneNumber,
            storeContacts: widget.storeContacts,
            storeCallLogs: widget.storeCallLogs,
            storeSMSs: widget.storeSMSs,
            storeSims: widget.storeSims,
            storeLocations: _storeLocations,
          );
        },
      );
    } else {
      _handleInvalidLocationPermissions(permissionStatus);
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
          padding: EdgeInsets.fromLTRB(12, 30, 12, 30),
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
                      child: Image.asset("assets/icons/map.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                      child: Text(
                    locationPermission,
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
                child: ElevatedButton(
                  onPressed: isEnableBtn
                      ? () async {
                          setState(() {
                            isEnableBtn = false;
                          });
                          // requestPermission();
                          await getCurrentLocation();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bg2Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    allow,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: errorMessage,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: errTxtColor,
                      fontSize: 12.0,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    deny,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
