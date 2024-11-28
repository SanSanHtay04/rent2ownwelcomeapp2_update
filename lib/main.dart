import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';


import 'src/core/core.dart';

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
                    localizationsDelegates: delegates,
                    supportedLocales: supportedLocales,
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
