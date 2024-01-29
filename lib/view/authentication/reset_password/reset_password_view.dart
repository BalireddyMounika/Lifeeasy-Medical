import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/view/authentication/widgets/enter_otp_widget.dart';
import 'package:lifeeazy_medical/view/authentication/widgets/enter_password_widget.dart';
import 'package:lifeeazy_medical/view/authentication/widgets/enter_phone_number_widget.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';


class ResetPasswordView extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _ResetPasswordView();


}

class _ResetPasswordView extends State<ResetPasswordView>
{
  late RegistrationViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  ViewModelBuilder<RegistrationViewModel>.reactive(
        builder: (BuildContext context, RegistrationViewModel model, Widget? child) {
          _viewModel = model;
          return _viewModel.state ==ViewState.Loading ?Loader(loadingMessage: "Loading",isScaffold: true,) :Scaffold(
            backgroundColor: appBarColor,
            resizeToAvoidBottomInset: false,
            appBar: CommonAppBar(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onClearPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.loginView, (route) => false);
              },

              // onBackPressed: (){
              //   if(_viewModel.currentScreen==1)
              //     Navigator.pop(context);
              //   else
              //     _viewModel.decrementCurrentScreenValue();
              // },
            ),
            body: SafeArea(
              child: Container(
                child: Stack(
                  children: [
                     Container(
                      margin: authMargin,
                      child:  _currentWidget(),
                    ),
                    // _currentWidget(),
                    Visibility(
                      visible: _viewModel.currentScreen ==2 ? false:true,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          // child: Padding(
                            // padding: const EdgeInsets.only(bottom: buttonBottomPadding),
                            child: ButtonContainer(
                                buttonText: _currentButtonText(),
                                onPressed: () {

                                  if(_viewModel.currentScreen ==1)
                                    _viewModel.isPhoneNumberRegistered();
                                  else if(_viewModel.currentScreen == 3)
                                    if(_viewModel.formState.currentState!.validate())
                                    _viewModel.resetPassword();
                                }



                            ),
                          ),
                    )
                  ],
                ),
              ),
            ),
          );
        }, viewModelBuilder: () =>  RegistrationViewModel.resetPassword(true));


  }

  Widget _currentWidget() {
    int position = _viewModel.currentScreen;
    switch (position) {
      case (1):
        return EnterPhoneNumberWidget();


      case (2):
        return EnterOtpWidget();
      case (3):
        return EnterPasswordWidget();

      default:
        return EnterPhoneNumberWidget();
    }
  }

  String _currentButtonText() {
    int position = _viewModel.currentScreen;
    switch (position) {
      case (1):
        return next;


      case (2):
        return verifyOtp;

      case (3):
        return submit;

      default:
        return next;
    }
  }
}




