import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home/widgets/performing_tab.dart';
import 'package:rent2ownwelcomeapp/src/features/home/widgets/status_accepted_tab.dart';
import 'package:rent2ownwelcomeapp/src/features/status/contract_created_tab_screen.dart';

class AppStatusTab extends StatefulWidget {
  final AppStatusResponse? data;
  const AppStatusTab({super.key,  this.data});

  @override
  State<AppStatusTab> createState() => _AppStatusTabState();
}

class _AppStatusTabState extends State<AppStatusTab> {
  @override
  Widget build(BuildContext context) {
    switch (widget.data?.appStatus) {
      case AppStatusType.rejected:
        return _appStatusWidget(
          context,
          imgPath: 'assets/images/image4.png',
          despColor: context.getColorScheme().error
        );
      case AppStatusType.counterProposed:
        return _appStatusWidget(context,
            imgPath: 'assets/images/image5.png',
            iconBgColor: Colors.yellow,
            despColor: context.getColorScheme().primary
            );
      case AppStatusType.accepted:
        return StatusAcceptedTab(data: widget.data);
      case AppStatusType.performing:
        return const PerformingTab();

      default:
        return Container();
    }
  }


  Widget _appStatusWidget(
    BuildContext context, {
    required String imgPath,
    Color? iconBgColor,
    Color? despColor,
  }) {
    return Container(
      padding: kPadding20,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          iconBgColor== null?  SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              "assets/images/image4.png",
              width: 50,
              height: 50,
            ),
          ):
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: kBorderRadius100, color: iconBgColor),
            child: Image.asset(
              imgPath,
              width: 50,
              height: 50,
            ),
          ),
          kSpaceVertical32,
          Text(
            widget.data?.appMessage??"",
            style: TextStyle(
              color: despColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          kSpaceVertical20,
          HtmlWidget(
            widget.data?.contactMsg??"",
            textStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
          ),
        ],
      )),
    );
  }
}
