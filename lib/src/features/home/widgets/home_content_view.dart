import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/contract_info_notifier.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/home_view_model.dart';
import 'package:rent2ownwelcomeapp/src/features/home/widgets/app_status_tab.dart';
import 'package:rent2ownwelcomeapp/src/features/home/widgets/review_tab.dart';

import 'default_app_tab.dart';

class HomeContentView extends StatefulWidget {
  const HomeContentView({super.key});

  @override
  State<HomeContentView> createState() => _HomeContentViewState();
}

class _HomeContentViewState extends State<HomeContentView>
    with TickerProviderStateMixin {
  late final _key = GlobalKey<RefreshIndicatorState>();
  late TabController _tabController;

  TabController getTabController({int index = 0}) {
    return TabController(length: 3, vsync: this, initialIndex: index);
  }

  @override
  void initState() {
    _tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Tab> _tabs(BuildContext context) =>
      ApplicationFormStatus.values.map((status) {
        return Tab(text: status.getName(context));
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, vm, unsubscribedChild) {
      Future.delayed(Duration.zero, () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          vm.dataState.maybeWhen(
            failed: (message, error) => context.showErrorDialog(
              error.errorMessage(context, message),
              onClosePressed: () {},
            ),
            success: (response) async {
              final initialIndex = response.appStatus.getIndexPosition();

              _tabController.index = initialIndex;

              if (initialIndex == 2 &&
                  response.appStatus == AppStatusType.performing) {
                await context.read<ContractInfoNotifier>().getAppContractInfo();
              }
            },
            orElse: () {},
          );
        });
      });

      return WorkLayout(
          isBusy: vm.isLoading,
          child: RefreshIndicator(
            key: _key,
            displacement: kToolbarHeight * 3,
            onRefresh: () => vm.checkAppStatus(),
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) =>
                      _homeAppBarBuilder(context, vm),
              body: Padding(
                padding: kPadding8,
                child: Column(children: [
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DefaultAppTab(data: vm.data?.response),
                          ReviewTab(data: vm.data?.response),
                          AppStatusTab(data: vm.data?.response)
                        ]),
                  ),
                  kSpaceVertical8,
                  const CopyrightNotice(),
                ]),
              ),
            ),
          ));
    });
  }

  List<Widget> _homeAppBarBuilder(BuildContext context, HomeViewModel vm) {
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
              final initialIndex =
                  vm.data!.response.appStatus.getIndexPosition();
              AppLogger.i("INITIAL INDEX : Click $index/ $initialIndex");
              _tabController.index = initialIndex;
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
  }
}
