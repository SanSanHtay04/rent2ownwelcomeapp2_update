import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/core/core.dart';

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
  final GlobalKey<NavigatorState> _key = GlobalKey();
  late final Future<List<SingleChildWidget>> providers = globalProviders();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SingleChildWidget>>(
      future: providers,
      builder: (_, snapShot) {
        if (!snapShot.hasData) {
          return const FullscreenProgressIndicator();
        } else {
          return MultiProvider(
            providers: snapShot.data!,
            child: Consumer<LocalAuthProvider>(
              builder: (context, provider, widget) {
                // if (!_firstOpen && !provider.isLoggedIn) {
                //   _firstOpen = false;
                //   SchedulerBinding.instance.addPostFrameCallback((_) {
                //     _key.currentState?.pushNamedAndRemoveUntil(
                //       "/login",
                //       (_) => false,
                //     );
                //   });
                // }

                return GlobalLoaderOverlay(
                  useDefaultLoading: false,
                  overlayWidgetBuilder: (_) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  },
                  child: MaterialApp(
                    title: 'WELCOME APP',
                    debugShowCheckedModeBanner: false,
                    navigatorKey: _key,
                    theme: Themes.lightTheme,
                    darkTheme: Themes.darkTheme,
                    routes: APP_ROUTER,
                    builder: EasyLoading.init(),
                    initialRoute: !kDebugMode ? "/issue-otp" : "/issue-otp",
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
