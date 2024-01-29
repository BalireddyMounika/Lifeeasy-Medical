import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';


class AllowLocationWidget extends ViewModelWidget<RegistrationViewModel>
{
  @override
  Widget build(BuildContext context,RegistrationViewModel model) {
    var paddingTotal = (displayWidth(context) * 1.4) + buttonBottomPadding;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image.asset("images/allow_location.png",height: 400,),
        SizedBox(height: 10,),
        Text("Allow LifeEazy to access your location for better service",style: mediumTextStyle.copyWith(color: Colors.grey),textAlign: TextAlign.center,),

        Spacer(),
        Padding(
          padding:  EdgeInsets.only(bottom:paddingTotal +20),
          child: ButtonContainerWithBorder(
            buttonText: notNow,
            onPressed: () {

              model.incrementCurrentScreenValue();

            },
          ),
        )
      ],
    );
  }

}