import 'package:flutter/widgets.dart';
import 'package:rent2ownwelcomeapp/src/features/features.dart';
import 'package:rent2ownwelcomeapp/src/features/home/home_with_tab_screen.dart';

class MainMenuTab {
  MainMenuTab._();
  static String root = "/home";
  static String submit = '/submit';
  static String review = '/review';
  static String status = '/status';

  static final Map<String, WidgetBuilder> routes = {
    root: (context) => const HomeScreen(),
    // contractSearch: (ctx) => SearchContractSreen(),
    // qrCodeScan: (ctx) => ScanQRCodeScreen(),
    // ownerBookJournal: (_) => ObJournalScreen.create(),
    // ownerBookConfimation: (_) => ObConfirmationScreen.create(),
  };
}


Map<String, WidgetBuilder> APP_ROUTER = {
  "/issue-otp": (_) => const LoginScreen(),
  "/verify-otp": (_) => const OTPVerificationScreen(phoneNo: '',),
}
  ..addAll(MainMenuTab.routes);
