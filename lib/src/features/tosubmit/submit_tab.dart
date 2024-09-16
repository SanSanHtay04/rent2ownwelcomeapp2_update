import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:rent2ownwelcomeapp/src/core/core.dart';

class SubmitTab extends StatelessWidget {
  const SubmitTab({super.key,  this.data});
  final AppStatusResponse? data;

  @override
  Widget build(BuildContext context) {

    switch(data?.appStatus){
      case AppStatusType.submit: return _toSubmitTabView();
      default : return defaultTabView();

    }
  }

  Widget defaultTabView(){
   return  Center(
        child: Container(
      width: 230,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: const Color.fromRGBO(218, 218, 218, 0.15)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/image1.png",
              width: 50,
              height: 50,
            ),
            kSpaceVertical20,
            Padding(
              padding: kPaddingHorizontal8,
              child: Text(
                data?.appMessage?? data?.statusMessage??"",
                style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ]),
    ));
  }
  Widget _toSubmitTabView(){
    return Padding(
      padding: kPadding20,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GifView.asset(
                'assets/images/sendingfile.gif',
                fit: BoxFit.contain,
              ),
              kSpaceVertical20,
              Text(
                data?.appMessage ?? "",
                style: const TextStyle(
                  color: Color(0xFF039370),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )
            ]),
      ),
    );
  }
}
