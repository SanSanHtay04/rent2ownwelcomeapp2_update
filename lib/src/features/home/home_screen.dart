import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/contract_info_notifier.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/home_view_model.dart';
import 'package:rent2ownwelcomeapp/src/features/home/widgets/home_content_view.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _onBack(BuildContext context) async {
    await context.showConfirmDialog(
      icon: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: kPadding4,
          child: Image.asset('assets/images/home.png'),
        ),
      ),
      title: context.tr.applicationBackTitle,
      message: context.tr.applicationBackMessage,
      confirmText: context.tr.actionOkay,
      onConfirmPressed: () => exit(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _onBack(context),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeViewModel>(
              create: (_) => HomeViewModel(context.read())..checkAppStatus()),
          ChangeNotifierProvider<ContractInfoNotifier>(
              create: (_) => ContractInfoNotifier(context.read())),
        ],
        child: const HomeContentView(),
           
      ),
    );
  }
}
