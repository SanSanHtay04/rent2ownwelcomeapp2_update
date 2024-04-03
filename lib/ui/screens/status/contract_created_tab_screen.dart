import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rent2ownwelcomeapp/core/values/colors.dart';
import 'package:rent2ownwelcomeapp/models/api_response.dart';
import 'package:rent2ownwelcomeapp/models/contractInfoResponse.dart';
import 'package:rent2ownwelcomeapp/ui/screens/status/contract_created_bloc.dart';
import 'package:rent2ownwelcomeapp/ui/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../main.dart';

class ContractCreatedTabView extends StatefulWidget {
  const ContractCreatedTabView({Key? key}) : super(key: key);

  @override
  State<ContractCreatedTabView> createState() => _ContractCreatedTabViewState();
}

class _ContractCreatedTabViewState extends State<ContractCreatedTabView> {
  final _bloc = ContractCreatedBloc();

  @override
  void initState() {
    _bloc.getContractInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.getContractInfoStream(),
        initialData: ApiResponse(
            msgState: MsgState.loading, errorState: ErrorState.noErr),
        builder: (context, snapshot) {
          ApiResponse resOb = snapshot.data!;

          if (resOb.msgState == MsgState.loading) {
            return const Loading();
          } else if (resOb.msgState == MsgState.data) {
            ContractInfoResponse contractInfo = resOb.data;
            return _buildMain(context, contractInfo);
          } else {
            return const Text("ERROR!");
          }
        });
  }

  Widget _buildMain(BuildContext context, ContractInfoResponse contractInfo) {
    var _space = const SizedBox(
      height: 10,
    );
    return SingleChildScrollView(
      child: Container(
          color: const Color.fromRGBO(218, 218, 218, 0.1),
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _space,
                Center(
                  child: Text(
                    AppLocale.contract_has_been_created_successfully
                        .getString(context),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                _space,
                _contractNumberWidget(contractInfo.contractNo),
                _space,
                _termNConditionsWidget(contractInfo.termsAndConditions),
                _space,
                const Divider(),
                _space,
                _paymentScheduleWidget(contractInfo.paymentSchedule),
                _space,
                _space,
                _contractDetailLinkWidget(contractInfo.contractDetailLink),
                _space,
                const Divider(),
                _space,
                _paymentChannels(),
                _space,
                const Divider(),
                _space,
                _hotLinesNCusServiceWidget(contractInfo.hotLineNo)
              ])),
    );
  }

  Widget _paymentScheduleWidget(String html) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocale.payment_schedule.getString(context),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: HtmlWidget(
            html,
          ),
        ))
      ],
    );
  }

  Widget _paymentChannels() {
    List<String> images = [
      "assets/icons/kbz_pay.png",
      "assets/icons/wave_pay.jpeg",
      "assets/icons/ongo_logo.png",
      "assets/icons/citizen_pay.png",
      "assets/icons/ok_pay.png",
      "assets/icons/true_money.png",
      "assets/icons/near_me.png"
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocale.payment_channels.getString(context),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(AppLocale.payment_can_b_done_the_following_channel
              .getString(context)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, crossAxisSpacing: 12.0, mainAxisSpacing: 12.0),
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
        )
      ],
    );
  }

  Widget _hotLinesNCusServiceWidget(List<String> numbers) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocale.hotline_customer_service.getString(context),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(AppLocale.any_questions.getString(context)),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  Uri phoneno = Uri.parse('tel:${numbers[index]}');
                  if (await launchUrl(phoneno)) {
                    //dialer opened
                  } else {
                    //dailer is not opened
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Text(
                    numbers[index],
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(0, 142, 251, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget _contractDetailLinkWidget(String url) {
    return GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Text(
          AppLocale.contract_detail_link.getString(context),
          style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Color.fromRGBO(0, 142, 251, 1),
              fontWeight: FontWeight.w700,
              fontSize: 15),
        ));
  }

  Widget _termNConditionsWidget(List<String> datas) {
    return Card(
      shadowColor: const Color.fromRGBO(217, 217, 217, 0.62),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(218, 218, 218, 1)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocale.term_n_cond.getString(context),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "   . ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Text(
                        datas[index],
                        //textAlign: TextAlign.justify,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ))
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget _contractNumberWidget(String contractNo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocale.contract_number.getString(context),
          style: TextStyle(
              color: bg1Color, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromRGBO(218, 218, 218, 1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  contractNo,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
