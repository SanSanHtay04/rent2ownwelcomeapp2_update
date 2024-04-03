import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rent2ownwelcomeapp/ui/screens/status/contract_created_tab_screen.dart';
import 'package:rent2ownwelcomeapp/ui/screens/status/status_accepted_tab_screen.dart';

import '../../../core/values/colors.dart';
import '../../../models/applicationStatusResponse.dart';

class StatusTabView extends StatefulWidget {
  final ApplicationStatusResponse appstatus;
  const StatusTabView({Key? key, required this.appstatus}) : super(key: key);

  @override
  State<StatusTabView> createState() => _StatusTabViewState();
}

class _StatusTabViewState extends State<StatusTabView> {
  String _status = "";

  @override
  void initState() {
    _status = widget.appstatus.status;
    //"accepted"; //rejected , counterproposal, accepted

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _status == "rejected"
        ? _rejectedWidget()
        : _status == "counterproposal"
            ? _counterProposalWidget()
            : _status == "accepted"
                ? StatusAcceptedTabView(appStatusRes: widget.appstatus)
                : _status == "performing"
                    ? ContractCreatedTabView()
                    : Container();
  }

  Widget _counterProposalWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: bgCounterProposal),
            child: Image.asset(
              "assets/images/image5.png",
              // scale: 1,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.appstatus.message,
            style: const TextStyle(
              color: bg1Color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   widget.appstatus.contactMsg,
          //   style: TextStyle(
          //       color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          //   textAlign: TextAlign.justify,
          // ),

          HtmlWidget(
            widget.appstatus.contactMsg,
            textStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
          ),
        ],
      )),
    );
  }

  Widget _rejectedWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              "assets/images/image4.png",
              // scale: 1,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.appstatus.message,
            style: const TextStyle(
              color: errTxtColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   widget.appstatus.contactMsg,
          //   style: TextStyle(
          //       color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          //   textAlign: TextAlign.justify,
          // ),

          HtmlWidget(
            widget.appstatus.contactMsg,
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
          ),
        ],
      )),
    );
  }
}
