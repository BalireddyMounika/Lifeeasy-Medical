import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
//ignore: must_be_immutable
class Loader extends StatelessWidget {
  String? loadingMessage;
  bool? isScaffold = true;
  Color? loadingMsgColor = Color(0xff000000);

  Loader({this.loadingMessage, this.isScaffold, this.loadingMsgColor});

  @override
  Widget build(BuildContext context) {
    return this.isScaffold == true
        ? Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            loadingMessage ?? "",
            style: mediumTextStyle.copyWith(color: loadingMsgColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    )
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          loadingMessage ?? "",
          style: mediumTextStyle.copyWith(color: loadingMsgColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
