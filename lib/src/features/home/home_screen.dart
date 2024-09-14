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
    with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _onBackPressed(),
      child: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(context.read())..loadData(),
        child: Consumer<HomeViewModel>(
          builder: (context, vm, unsubscribedChild) {
            return Scaffold(
              // appBar: AppBar(
              //   flexibleSpace: Padding(
              //     padding: kPadding24,
              //     child: Image.asset(
              //       "assets/images/home.png",
              //       width: 180,
              //     ),
              //   ),
              //   // bottom: TabBar(
              //   //     onTap: (value) {
              //   //       AppLogger.i("TAB INDEX : $value");
              //   //     },
              //   //     labelColor: context.getColorScheme().primary,
              //   //     controller: _tabController,
              //   //     tabs: _tabs(context)),

              //   actions: [
              //     TextButton.icon(
              //         onPressed: () {},
              //         icon: const Icon(Icons.language),
              //         label: const Text('en'))
              //   ],
              // ),

              body: RefreshIndicator(
                key: _key,
                displacement: kToolbarHeight * 3,
                notificationPredicate: (notification) {
                  if (notification is OverscrollNotification ||
                      Platform.isIOS) {
                    return notification.depth == 2;
                  }
                  return notification.depth == 0;
                },
                onRefresh: () async {
                  final status = context.read<HomeViewModel>().checkAppStatus();
                  await status.stream.firstWhere((e) => !e.isLoading);
                },
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        title: const Text('My Application'),
                        bottom: TabBar(
                          onTap: (value) {},
                          labelColor: context.getColorScheme().primary,
                          controller: _tabController,
                          tabs: _tabs(context),
                        ),
                      ),
                    ];
                  },
                  body:  Padding(
                      padding: kPadding8,
                      child: Column(
                        children: [
                          Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: _tabViewChildren()),
                          ),
                          kSpaceVertical8,
                          const CopyrightNotice(),
                        ],
                      ),
                    ),
                
                ),
              ),
              floatingActionButton: IconButton(
                  onPressed: () {
                    context.read<HomeViewModel>().checkAppStatus();
                  },
                  icon: Icon(Icons.refresh)),
            );
          },
        ),
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

  _onBackPressed() {}
}
