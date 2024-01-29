import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/view/authentication/widgets/enter_details_widget.dart';
import 'package:lifeeazy_medical/view/authentication/widgets/enter_otp_widget.dart';
import 'package:lifeeazy_medical/view/authentication/widgets/enter_phone_number_widget.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  late RegistrationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      builder:
          (BuildContext context, RegistrationViewModel model, Widget? child) {
        _viewModel = model;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: appBarColor,
          appBar: CommonAppBar(
            title: "Registration",
            onClearPressed: () {
              locator<NavigationService>()
                  .navigateToAndRemoveUntil(Routes.loginView);
            },
            onBackPressed: () {
              if (_viewModel.currentScreen == 1)
                Navigator.pop(context);
              else
                _viewModel.decrementCurrentScreenValue();
            },
          ),
          body: SafeArea(
            child: _viewModel.state == ViewState.Loading
                ? Loader(
                    loadingMessage: _viewModel.loaderMsg,
                    loadingMsgColor: Colors.black,
                  )
                : Container(
                    child: Container(
                      child: Stack(
                        children: [
                          Form(
                              key: _viewModel.formState,
                              child: Container(
                                margin: authMargin,
                                child: _currentWidget(),
                              )),
                          Visibility(
                              visible:
                                  _viewModel.currentScreen == 2 ? false : true,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  // child: Padding(
                                  //   padding:
                                  //   const EdgeInsets.only(bottom: buttonBottomPadding),
                                  child: ButtonContainer(
                                    buttonText: _currentButtonText(),
                                    onPressed: () {
                                      // if (_viewModel.currentScreen != 4)
                                      //   _viewModel.incrementCurrentScreenValue();
                                      // else
                                      //   Navigator.pushNamedAndRemoveUntil(
                                      //       context,
                                      //       Routes.registrationSuccessView,
                                      //       (route) => false);

                                      _onPressedFun();
                                    },
                                  ),
                                ),
                              ])),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
      viewModelBuilder: () => RegistrationViewModel(),
    );
  }

  Widget _currentWidget() {
    int position = _viewModel.currentScreen;
    switch (position) {
      case (1):
        return EnterPhoneNumberWidget();

      case (2):
        return EnterOtpWidget();

      case (3):
        return EnterDetailsWidget();

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

  void _onPressedFun() async {
    if (_viewModel.currentScreen == 1) if (_viewModel
        .phoneNumberController.text.isNotEmpty)
      _viewModel.isPhoneNumberRegistered();
    else
      locator<SnackBarService>().showSnackBar(
          title: "Phone Number Required", snackbarType: SnackbarType.error);
    // else  if(_viewModel.currentScreen == 3)
    //   {
    //
    //   var pos =  await  _viewModel.determinePosition();
    //
    //    SessionManager.setLocation = new LocationResponseModel(
    //      lat: pos.latitude,
    //      long: pos.longitude,
    //      city: "Visakhapatnam",
    //      country: "India",
    //      pinCode: 530040,
    //      state: "Andhra Pradesh",
    //      address: "M.V.P Colony, Sector No.1, HIG 31, Opposite Pullocks Kinder Garden School Near to Vuda Kalyanamadapam, Tennis Court, Dondaparthy, Gajuwaka, Visakhapatnam, Andhra Pradesh 530017, India"
    //
    //    );
    //    locator<LocalStorageService>().setLocation(SessionManager.getLocation.toJson());
    //   _viewModel.incrementCurrentScreenValue();
    //
    //   }
    else if (_viewModel.currentScreen == 3) {
      _viewModel.formState.currentState!.validate();
      _viewModel.formState.currentState!.save();

      if (_viewModel.formState.currentState!.validate()) if (_viewModel
              .confirmPasswordController.text ==
          _viewModel.newPasswordController.text) {
        _viewModel.registerUser();
      } else {
        Fluttertoast.showToast(msg: 'Password mismatch');
      }
    } else {
      if (_viewModel.currentScreen < 3)
        _viewModel.incrementCurrentScreenValue();
    }
  }
}
