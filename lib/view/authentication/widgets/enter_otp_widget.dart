import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/timer.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class EnterOtpWidget extends ViewModelWidget<RegistrationViewModel> {
  late RegistrationViewModel _viewModel;
  @override
  Widget build(BuildContext context,RegistrationViewModel model ) {
    _viewModel = model;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: displayHeight(context) * 0.5,
        ),
        Text(
          enterOtpCode,
          style: authHeaderTextStyle,
        ),
        RichText(
            text: TextSpan(
              text: "We'll send OTP to  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: _viewModel.internationalPhoneNumber.phoneNumber,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " number",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            )),

        SizedBox(
          height: displayHeight(context) * .2,
        ),
        PinCodeTextField(
          length: 6,
          obscureText: false,
          appContext: context,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            activeColor: Colors.white,
            borderWidth: 0,
            inactiveColor: Colors.grey[200],
            selectedColor: Colors.grey[200],
            selectedFillColor: Colors.grey[200],
            inactiveFillColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 48,
            fieldWidth: 48,
            activeFillColor:baseColor,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          // errorAnimationController: errorController,
          // controller: textEditingController,
          onCompleted: (v) {
          _viewModel.signInWithOTP(v);
          },
          onChanged: (value) {
            print(value);

          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: _viewModel.isTimerStopped? Text("OTP not received ? ",style:mediumTextStyle,) : CountDownTimer(
                secondsRemaining: 45,
                whenTimeExpires: () {
                  _viewModel.timerStopped();
                  },
                countDownTimerStyle:
                TextStyle(color: baseColor, fontSize: 17.0, height: 1.2),
              ),
            ),
            Visibility(
              visible:_viewModel.isTimerStopped,
              child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){

                      _viewModel.resendSms(_viewModel.phoneNumberController.text);

                    },
                    child: Container(
                      child: Text(
                        resend,
                        style: mediumTextStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
