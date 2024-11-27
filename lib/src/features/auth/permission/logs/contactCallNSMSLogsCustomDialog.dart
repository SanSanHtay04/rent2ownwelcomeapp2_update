import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:call_log/call_log.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rent2ownwelcomeapp/models/storeCallLogModel.dart';
import 'package:rent2ownwelcomeapp/models/storeContactModel.dart';
import 'package:rent2ownwelcomeapp/models/storeSMSLogModel.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

import '../../../../../models/store_sim_card_model.dart';
import '../location/locationCustomDialog.dart';

class ContactCallNSMSLogsCustomDialog extends StatefulWidget {
  final String phoneNumber;
  final List<StoreSimCardModel> storeSims;

  const ContactCallNSMSLogsCustomDialog({
    super.key,
    required this.phoneNumber,
    required this.storeSims,
  });

  @override
  State<ContactCallNSMSLogsCustomDialog> createState() =>
      _ContactCallNSMSLogsCustomDialogState();
}

class _ContactCallNSMSLogsCustomDialogState
    extends State<ContactCallNSMSLogsCustomDialog> {
  bool isEnableBtn = true;

  //Contact
  List<Contact> _contacts = const [];
  List<StoreContactModel> _storeContacts = [];
  List<StoreSMSLogModel> _storeSmsLogs = [];

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.contacts,
      Permission.phone,
    ].request();

    for (var element in statuses.values) {
      if (element.isDenied || element.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
  }

  void requestIOSPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.contacts,
    ].request();

    for (var element in statuses.values) {
      if (element.isDenied || element.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
  }

  //get contact list
  Future<void> loadContactList() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      _contacts = [];
      _storeContacts = [];
      _contacts = await FastContacts.getAllContacts();

      if (_contacts.isNotEmpty) {
        for (Contact contact in _contacts) {
          if (contact.phones.isNotEmpty) {
            var phones = contact.phones.map((e) => e.number).join(', ');
            final emails = contact.emails.map((e) => e.address).join(', ');
            final name = contact.structuredName;

            StoreContactModel storeConst = StoreContactModel(
              displayName: contact.displayName,
              firstName: name!.namePrefix,
              lastName: name.nameSuffix,
              phoneNo: phones,
              email: emails,
            );
            _storeContacts.add(storeConst);
          }
        }
      } else {
        _storeContacts = [];
      }

      // print("C => ${_storeContacts.length}");

      setState(() {
        isEnableBtn = false;
      });

      Navigator.of(context).pop(true);
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return LocationCustomDialog(
            phoneNumber: widget.phoneNumber,
            storeSims: widget.storeSims,
            storeContacts: _storeContacts,
            storeSMSs: [],
            storeCallLogs: [],
          );
        },
      );
    } else {
      _handleInvalidPermissions(permissionStatus);
    }

    if (!mounted) return;
    setState(() {});
  }

  // @override
  // void initState() {
  //   requestPermission();
  //   super.initState();
  // }

  Future<PermissionStatus> _getSMSPermission() async {
    PermissionStatus permission = await Permission.sms.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.sms.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidSMSPermissions(PermissionStatus permissionStatus) async {
    if (permissionStatus == PermissionStatus.denied) {
      Fluttertoast.showToast(
        msg: "Access to sms data denied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
        msg: "SMS data not available on device",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) async {
    if (permissionStatus == PermissionStatus.denied) {
      Fluttertoast.showToast(
        msg: "Access to contact data denied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
        msg: "Contact data not available on device",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: errTxtColor,
        fontSize: 12.0,
      );
    }
  }

  //get contact list
  Future<void> loadContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      _contacts = [];
      _storeContacts = [];
      _contacts = await FastContacts.getAllContacts();

      if (_contacts.isNotEmpty) {
        for (Contact contact in _contacts) {
          if (contact.phones.isNotEmpty) {
            var phones = contact.phones.map((e) => e.number).join(', ');
            final emails = contact.emails.map((e) => e.address).join(', ');
            final name = contact.structuredName;

            StoreContactModel storeConst = StoreContactModel(
              displayName: contact.displayName,
              firstName: name!.namePrefix,
              lastName: name.nameSuffix,
              phoneNo: phones,
              email: emails,
            );
            _storeContacts.add(storeConst);
          }
        }
      } else {
        _storeContacts = [];
      }

      // print("C => ${_storeContacts.length}");

      await loadSMSLogs();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> loadSMSLogs() async {
    //SMS logs
    List<SmsMessage> _messages = [];

    PermissionStatus permissionStatus = await _getSMSPermission();
    if (permissionStatus == PermissionStatus.granted) {
      _storeSmsLogs = [];
      _messages = await SmsQuery()
          .querySms(kinds: [SmsQueryKind.inbox, SmsQueryKind.sent]); //count: 1

      if (_messages.isNotEmpty) {
        for (SmsMessage msg in _messages) {
          if (msg.kind == SmsMessageKind.sent) {
            StoreSMSLogModel sms = StoreSMSLogModel(
              status: "SENT",
              sender: "",
              receiver: msg.sender.toString(),
              message: msg.body.toString(),
              date: DateTime.fromMillisecondsSinceEpoch(msg.date as int),
            );
            // print(json.encode(sms));
            _storeSmsLogs.add(sms);
          } else {
            StoreSMSLogModel sms = StoreSMSLogModel(
              status: "RECEIVED",
              sender: msg.sender.toString(),
              receiver: "",
              message: msg.body.toString(),
              date: DateTime.fromMillisecondsSinceEpoch(msg.date as int),
            );
            // print(json.encode(sms));
            _storeSmsLogs.add(sms);
          }
        }
      } else {
        _storeSmsLogs = [];
      }

      await loadCallLogs();
    } else {
      _handleInvalidSMSPermissions(permissionStatus);
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> loadCallLogs() async {
    Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
    final Iterable<CallLogEntry> result = await CallLog.query();
    List<StoreCallLogModel> _storeCallLogs = [];
    _callLogEntries = result;

    if (_callLogEntries.isNotEmpty) {
      for (CallLogEntry entry in _callLogEntries) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);

        StoreCallLogModel callL = StoreCallLogModel(
            phoneNo: entry.number.toString(),
            name: entry.name.toString(),
            callType: entry.callType.toString(),
            date: date.toString(),
            duration: entry.duration.toString(),
            simDisplayName: entry.simDisplayName.toString());

        // print("CALL => ${json.encode(callL)}");

        _storeCallLogs.add(callL);
      }
    } else {
      _storeCallLogs = [];
    }

    setState(() {
      isEnableBtn = false;
    });

    Navigator.of(context).pop(true);
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return LocationCustomDialog(
          phoneNumber: widget.phoneNumber,
          storeSims: widget.storeSims,
          storeContacts: _storeContacts,
          storeSMSs: _storeSmsLogs,
          storeCallLogs: _storeCallLogs,
        );
      },
    );
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
                      child: Image.asset("assets/icons/logs.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Expanded(
                      child: Text(
                    context.tr.contactCallSMSPermission,
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
                          if (Platform.isAndroid) {
                            requestPermission();
                            await loadContacts();
                          } else {
                            requestIOSPermission();
                            await loadContactList();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bg2Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    context.tr.allow,
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
                    AppSettings.openAppSettings(type: AppSettingsType.settings);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    context.tr.deny,
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
