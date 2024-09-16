import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';
import 'package:rent2ownwelcomeapp/src/features/home/viewmodel/contract_info_notifier.dart';
import 'package:url_launcher/url_launcher.dart';


class PerformingTab extends StatelessWidget {
  const PerformingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractInfoNotifier>(builder: (context, vm, unsubscribedChild) {

       Future.delayed(Duration.zero, () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          vm.dataState.maybeWhen(
            failed: (message, error) => context.showErrorDialog(
              error.errorMessage(context, message),
              onClosePressed: () {},
            ),
            success: (response) {
             
            },
            orElse: () {},
          );
        });
      });


      return _buildMain(context, vm.data?.response,);
    });
  }

  Widget _buildMain(BuildContext context, ContractInfoResponse? data) {
   
    return SingleChildScrollView(
      child: Container(
          color: const Color.fromRGBO(218, 218, 218, 0.1),
          padding: kPaddingHorizontal8 + kPaddingVertical16,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                Center(
                  child: Text(
                    context.tr.contract_has_been_created_successfully
                        ,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
             
             kSpaceVertical10,
                _contractNumberWidget(context, data?.contractNo??""),
                 kSpaceVertical10,
                _termNConditionsWidget(context, data?.termsAndConditions??[]),
                  kSpaceVertical10,
                const Divider(),
                kSpaceVertical10,
                _paymentScheduleWidget( context, data?.paymentSchedule??""),
                 kSpaceVertical10,
                _contractDetailLinkWidget(context, data?.contractDetailLink??""),
                  kSpaceVertical10,
                const Divider(),
                  kSpaceVertical10,
                _paymentChannels( context ),
                  kSpaceVertical10,
                const Divider(),
                  kSpaceVertical10,
                _hotLinesNCusServiceWidget(context,data?.hotLineNo??[])
              ])),
    );
  }

  Widget _paymentScheduleWidget (BuildContext context, String html) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.payment_schedule,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
        ),
          kSpaceVertical8,
       
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

  Widget _paymentChannels(BuildContext context) {
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
         context.tr.payment_channels,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
        ),
         kSpaceVertical8,
        Padding(
          padding: kPadding8,
          child: Text(context.tr.payment_can_b_done_the_following_channel),
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

  Widget _hotLinesNCusServiceWidget(BuildContext context, List<String> numbers) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.tr.hotline_customer_service,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        kSpaceVertical8,
        Padding(
          padding: kPadding8,
          child: Text(context.tr.any_questions),
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

  Widget _contractDetailLinkWidget(BuildContext context, String url) {
    return GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Text(
          context.tr.contract_detail_link,
          style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Color.fromRGBO(0, 142, 251, 1),
              fontWeight: FontWeight.w700,
              fontSize: 15),
        ));
  }

  Widget _termNConditionsWidget( BuildContext context, List<String> datas) {
    return Card(
      shadowColor: const Color.fromRGBO(217, 217, 217, 0.62),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(218, 218, 218, 1)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding:kPadding12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.term_n_cond,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  fontSize: 14),
            ),
           kSpaceVertical10,
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

  Widget _contractNumberWidget(BuildContext context,  String contractNo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          context.tr.contract_number,
          style: const TextStyle(
              color: bg1Color, fontWeight: FontWeight.w700, fontSize: 15),
        ),
            kSpaceVertical4,
       
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
                  style: const TextStyle(
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
