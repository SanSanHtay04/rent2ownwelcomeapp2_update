import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:rent2ownwelcomeapp/network/network.dart';
import 'package:rent2ownwelcomeapp/ui/screens/auth/auth_screen.dart';
import 'package:rent2ownwelcomeapp/ui/screens/home/home_with_tab_screen.dart';
import 'package:rent2ownwelcomeapp/ui/screens/test/app_settings.dart';
import 'package:rent2ownwelcomeapp/ui/screens/test/testing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';

import 'core/themes/themes.dart';

mixin AppLocale {
  static const String contract_has_been_created_successfully =
      'The Contract Has Been Created Successfully.';
  static const String contract_number = "Contract Number";
  static const String term_n_cond = "Terms and conditions";
  static const String payment_schedule = "Payment Schedule";
  static const String contract_detail_link = "Contract Details Link";
  static const String payment_channels = "Payment Channels";
  static const String payment_can_b_done_the_following_channel =
      "The payment can be done with the following channels";
  static const String hotline_customer_service = "Hot Line & Customer Service";
  static const String any_questions =
      "If you have any questions, please contact :";

  static const Map<String, dynamic> EN = {
    contract_has_been_created_successfully:
        'The Contract Has Been Created Successfully.',
    contract_number: 'Contract Number',
    term_n_cond: "Terms and conditions",
    payment_schedule: "Payment Schedule",
    contract_detail_link: "Contract Details Link",
    payment_channels: "Payment Channels",
    payment_can_b_done_the_following_channel:
        "The payment can be done with the following channels",
    hotline_customer_service: 'Hot Line & Customer Service',
    any_questions: 'If you have any questions, please contact :'
  };
  static const Map<String, dynamic> MM = {
    contract_has_been_created_successfully:
        'စာချုပ်အောင်မြင်စွာ ချုပ်ဆိုပြီး ဖြစ်ပါသည်။',
    contract_number: 'စာချုပ််နံပါတ်',
    term_n_cond: 'စည်းကမ်းသတ်မှတ်ချက်များ',
    payment_schedule: 'လစဥ်ကြေးပေးသွင်းရမည့် နေ့ရက်များ',
    contract_detail_link: 'စာချုပ် အသေးစိတ် ကြည့်ရှု့ရန်',
    payment_channels: 'လစဥ်ကြေးပေးသွင်းနိုင်သည့် နေရာများ',
    payment_can_b_done_the_following_channel:
        'လစဥ်ကြေးအား အောက်ဖော်ပြပါ ငွေလွှဲဝန်ဆောင်မှုများဖြင့် ပေးသွင်းနိုင်ပါသည်။',
    hotline_customer_service: 'Hot Line & Customer Service',
    any_questions:
        'အသေးစိတ် သိလိုသည်များရှိပါက အောက်ဖော်ပြပါ ဖုန်းနံပါတ်များကို ခေါ်ဆိုနိုင်ပါသည်။'
  };
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TikTokSDK.instance.setup(clientKey: 'awoxo8pz3rhs65vf');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  bool _isAldLogin = false;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
        ),
        const MapLocale(
          'my',
          AppLocale.MM,
        ),
      ],
      initLanguageCode: 'my',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;

    _checkIsAldLogin();
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  Future<void> _checkIsAldLogin() async {
    SharedPreferences spfs = await SharedPreferences.getInstance();
    setState(() {
      _isAldLogin = spfs.getBool(IS_ALD_LOGIN) ?? false;
    });

    // print("ISLOGIN => $_isAldLogin");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: _localization.supportedLocales,
        localizationsDelegates: _localization.localizationsDelegates,
        title: 'Rent2Own Welcome App',
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        home: _isAldLogin
            ? HomeWithTabScreen(
                isAldLogin: _isAldLogin,
              )
            : const AuthScreen());
  }
}
