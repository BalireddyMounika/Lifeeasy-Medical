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
import 'package:lifeeazy_medical/view/authentication/widgets/enter_phone_number_widget.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignInWithOtpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInWithOtpView();
}

class _SignInWithOtpView extends State<SignInWithOtpView> {
  late RegistrationViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      builder:
          (BuildContext context, RegistrationViewModel model, Widget? child) {
        _viewModel = model;
        return _viewModel.state == ViewState.Loading
            ? Loader(
                loadingMessage: "Loading..",
                isScaffold: true,
              )
            : Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: appBarColor,
                appBar: CommonAppBar(
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                  onClearPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.loginView, (route) => false);
                  },
                ),
                body: SafeArea(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          margin: authMargin,
                          child: _currentWidget(),
                        ),
                        // _currentWidget(),
                        Visibility(
                          visible: _viewModel.currentScreen == 2 ? false : true,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            // child: Padding(
                            //   padding: const EdgeInsets.only(bottom: buttonBottomPadding),
                            child: ButtonContainer(
                              buttonText: _currentButtonText(),
                              onPressed: () {
                                _onPressedFun();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
      viewModelBuilder: () => RegistrationViewModel.signInWithOtp(true),
    );
  }

  Widget _currentWidget() {
    int position = _viewModel.currentScreen;
    switch (position) {
      case (1):
        return EnterPhoneNumberWidget();

      case (2):
        return EnterOtpWidget();

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

      default:
        return next;
    }
  }

  void _onPressedFun() {
    _viewModel.isPhoneNumberRegistered();
  }
}
