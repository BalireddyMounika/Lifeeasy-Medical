import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';

import 'button_container.dart';

enum DialogType {
  ErrorDialog,
  WarningDialog,
  SuccessDialog,
}

//ignore: must_be_immutable
class PopUpDialog extends StatelessWidget {
  DialogType dialogType = DialogType.ErrorDialog;

  String? routes = "";
  final String? buttonText;
  //final String? button;
  final String? title;
  final String? message;
  final _navigationService = locator<NavigationService>();
  bool isStackCleared = false;
  bool isCancelButtonVisible = false;

  PopUpDialog({
    this.routes,
    this.buttonText,
    //this.button,
    this.title,
    this.message,
    this.isStackCleared = false,
    this.isCancelButtonVisible = false,
    required this.dialogType,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        // height: displayHeight(context) * 4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            topIcon(),
            verticalSpaceMedium,
            Flexible(
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: largeTextStyle.copyWith(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              message ?? "",
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
            verticalSpaceMedium,
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Visibility(
                      visible: isCancelButtonVisible,
                      child: _container(context)),
                  ButtonContainer(
                    buttonText: this.buttonText,
                    height: 35,
                    width: 80,
                    //button:this.button,
                    // height: kToolbarHeight - 15,
                    onPressed: () {
                      if (routes!.isEmpty)
                        Navigator.pop(context);
                      else if (this.isStackCleared == true) {
                        Navigator.pop(context);
                        _navigationService.navigateToAndRemoveUntil(routes!);
                      } else {
                        Navigator.pop(context);
                        _navigationService.navigateTo(routes!);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  Widget headerContainer(Color colors, Widget icon) {
    return Container(
      height: 80,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: colors),
        shape: BoxShape.circle,
      ),
      child: Center(child: icon),
    );
  }

  Widget _container(context) {
    return Center(
      child: Container(
        height: 35,
        width: 80,
        margin: EdgeInsets.only(right: 40, left: 40),
        child: TextButton(
          child: Text(
            'No',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget topIcon() {
    switch (dialogType) {
      case DialogType.ErrorDialog:
        return headerContainer(
            Colors.red,
            Icon(
              Icons.clear,
              size: 48,
              color: Colors.red,
            ));

      case DialogType.WarningDialog:
        // TODO: Handle this case.
        return headerContainer(
            baseColor,
            Icon(
              Icons.info,
              size: 48,
              color: redColor,
            ));

      case DialogType.SuccessDialog:
        // TODO: Handle this case.
        return headerContainer(
            Colors.green,
            Icon(
              Icons.done,
              size: 48,
              color: Colors.green,
            ));
    }
  }
}
