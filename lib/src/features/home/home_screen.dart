import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final _key = GlobalKey<RefreshIndicatorState>();

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _onBack(context),
      child: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(context.read())..loadData(),
        child:
            Consumer<HomeViewModel>(builder: (context, vm, unsubscribedChild) {
          Future.delayed(Duration.zero, () {
            vm.dataState.maybeWhen(
              failed: (message, error) => context.showErrorDialog(
                error.errorMessage(context, message),
                onClosePressed: () {},
              ),
              orElse: () {},
            );
          });

          return WorkLayout(
            isBusy: vm.isLoading,
            child: RefreshIndicator(
              key: _key,
              displacement: kToolbarHeight * 3,
              // notificationPredicate: (notification) {
              //   if (notification is OverscrollNotification || Platform.isIOS) {
              //     return notification.depth == 2;
              //   }
              //   return notification.depth == 0;
              // },
              onRefresh: refreshData,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      flexibleSpace: Padding(
                        padding: kPadding20,
                        child: Image.asset(
                          "assets/images/home.png",
                          width: 180,
                        ),
                      ),
                      bottom: TabBar(
                          onTap: (index) {
                            final isEnabled = vm.dataState.maybeWhen(success: orElse)
                            AppLogger.i("TAB INDEX : $index");
                          },
                          controller: _tabController,
                          labelColor: context.getColorScheme().primary,
                          tabs: _tabs(context)),
                      actions: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.language),
                            label: const Text('en'))
                      ],
                    ),
                  ];
                },
                body: Padding(
                  padding: kPadding8,
                  child: Column(children: [
                    Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _tabViewChildren()),

                    ),
                    kSpaceVertical8,
                    const CopyrightNotice(),
                  ]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  _tabs(BuildContext context) {
    return ApplicationFormStatus.values.map((status) {
      return Tab(
        text: status.getName(context),
      );
    }).toList();
  }

  _tabViewChildren() => const [
        Center(
          child: Text("First"),
        ),
        Center(
          child: Text("Second"),
        ),
        Center(
          child: Text("Third"),
        )
      ];

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
}
