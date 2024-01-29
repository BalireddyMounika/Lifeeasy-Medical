import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/authentication/login_response_model.dart';
import 'package:lifeeazy_medical/models/authentication/register_request_model.dart';
import 'package:lifeeazy_medical/models/authentication/reset_password_request_model.dart';
import 'package:lifeeazy_medical/models/otp/generate_otp_request.dart';
import 'package:lifeeazy_medical/models/otp/validate_otp_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/authentication/auth_servcices.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class RegistrationViewModel extends CustomBaseViewModel {
  final GlobalKey<FormState> formState = GlobalKey();

  int _currentScreen = 1;
  var _authService = locator<AuthService>();
  var _dialogService = locator<DialogService>();
  var _navigatorService = locator<NavigationService>();
  var _snackBarService = locator<SnackBarService>();
  var _commonApisService = locator<CommonApiService>();
  var _prefs = locator<LocalStorageService>();
  RegisterRequestModel registerRequestModel = new RegisterRequestModel();

  // ResetPasswordRequestModel resetPasswordRequestModel = new ResetPasswordRequestModel();
  get currentScreen => _currentScreen;
  String? verificationId;
  int? forceResendToken;
  bool codeSent = false;
  bool isPasswordVisible = false;
  int otpId = 0;
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController resetPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  PhoneNumber internationalPhoneNumber = PhoneNumber(isoCode: 'IN');
  bool isLoginWithOtp = false;
  bool isResetPass = false;

  RegistrationViewModel();

  RegistrationViewModel.signInWithOtp(this.isLoginWithOtp);

  RegistrationViewModel.resetPassword(this.isResetPass);

  bool isTimerStopped = false;
  String loaderMsg = "";

  void incrementCurrentScreenValue() {
    if (_currentScreen != 3) {
      _currentScreen = _currentScreen + 1;
    }
    notifyListeners();
  }

  void decrementCurrentScreenValue() {
    if (_currentScreen != 1) _currentScreen = _currentScreen - 1;
    notifyListeners();
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      // var user = signIn(authResult);
      // if (user != null) {
      //   _snackbarService.showSnackbar(
      //       title: 'OTP verified successfully', message: '');
      //   switchScreenTo(screenState.personalInfoScreen);
      // }
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      verificationId = verId;
      forceResendToken = forceResend;
      codeSent = true;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumberController.text}",
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  signIn(AuthCredential authCreds) async {
    var data = await FirebaseAuth.instance.signInWithCredential(authCreds);
    return data;
  }

  void timerStopped() {
    isTimerStopped = true;
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    setState(ViewState.Loading);
    var position = await Geolocator.getCurrentPosition();
    setState(ViewState.Completed);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return position;
  }

  Future<void> resendSms(String phoneNo) async {
    loaderMsg = "Resending Otp..";
    setState(ViewState.Loading);
    var response = await _commonApisService
        .generateOtp(new GenerateOtpRequest(phoneNumber: '+91$phoneNo'));

    otpId = response.result['id'];
    if (response.hasError == false) {
      isTimerStopped = false;
      setState(ViewState.Completed);
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: "Otp Send Successfully", snackbarType: SnackbarType.success);
    } else {
      isTimerStopped = false;
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: "Failed to send otp", snackbarType: SnackbarType.error);
    }
  }

  signInWithOTP(String smsCode) async {
    setState(ViewState.Loading);
    try {
      AuthCredential authCreds = PhoneAuthProvider.credential(
          verificationId: verificationId ?? "123", smsCode: smsCode);
      var request = new ValidateOtpRequest(otp: smsCode);
      var response = await _commonApisService.validateOtp(request, otpId);
      if (response.hasError == false) {
        setState(ViewState.Completed);
        // _isVerified =true;
        if (isLoginWithOtp) {
          _prefs.setIsLogIn(true);
          _prefs.setUserModel(jsonEncode(SessionManager.getUser.toMap()));

          if (SessionManager.getUser.profile != null) {
            var image = SessionManager.getUser.profile["ProfilePicture"];
            SessionManager.profileImageUrl = image;
            _prefs.setProfileImage(image);
          }

          _dialogService.showDialog(DialogType.SuccessDialog, message,
              "Login Success", Routes.selectPartnerTypeView, ok,
              isStackedCleared: true);
        } else
          incrementCurrentScreenValue();
      } else {
        setState(ViewState.Completed);

        _dialogService.showDialog(
            DialogType.ErrorDialog, message, otpVerificationFailed, "", ok);
      }
    } on Exception catch (r) {
      setState(ViewState.Completed);
      print(r);
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, otpVerificationFailed, "", ok);
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future sendOtp() async {
    var request =
        GenerateOtpRequest(phoneNumber: "+91${phoneNumberController.text}");
    var response = await _commonApisService.generateOtp(request);
    otpId = response.result['id'];
    if (response.hasError == false) {
      setState(ViewState.Completed);
      incrementCurrentScreenValue();
      _snackBarService.showSnackBar(
          title: "Otp send to +91${phoneNumberController.text}",
          snackbarType: SnackbarType.success);
    } else {
      _snackBarService.showSnackBar(
          title: "Failed to send otp", snackbarType: SnackbarType.error);
    }
  }

  Future isPhoneNumberRegistered() async {
    var genericResponse = new GenericResponse();
    loaderMsg = "Validating Phone Number";

    setState(ViewState.Loading);
    try {
      var response = await _authService
          .isPhoneNumberRegistered(internationalPhoneNumber.phoneNumber);
      genericResponse = response;
      if (response.hasError == false) {
        SessionManager.setUser =
            LoginResponseModel.fromMap(response.result as Map<String, dynamic>);

        if (isLoginWithOtp || isResetPass) {
          await sendOtp();
        } else {
          setState(ViewState.Completed);
          _snackBarService.showSnackBar(
              title: "User is already Registered",
              snackbarType: SnackbarType.error);
        }
      } else if (response.hasError == true && !isLoginWithOtp && !isResetPass) {
        await sendOtp();

        // _dialogService.showDialog(DialogType.ErrorDialog, message,
        //     somethingWentWrong, Routes.loginView, ok);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
        // _dialogService.showDialog(DialogType.ErrorDialog, message,
        //     "User is not registered", Routes.loginView, ok);

      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
      // _dialogService.showDialog(DialogType.ErrorDialog, message,
      //     somethingWentWrong, Routes.loginView, ok);
    }
  }

  Future registerUser() async {
    loaderMsg = "Registration In Process";
    var genericResponse = new GenericResponse();
    registerRequestModel.mobileNumber = internationalPhoneNumber.phoneNumber;

    try {
      setState(ViewState.Loading);
      registerRequestModel.deviceToken = SessionManager.fcmToken;
      registerRequestModel.tag = "0";
      var response = await _authService.register(registerRequestModel);
      // var genericResponse = response;
      if (response.hasError == false) {
        _prefs.setIsLogIn(true);
        _prefs.setUserModel(jsonEncode(response.result));
        SessionManager.setUser =
            LoginResponseModel.fromMap(response.result as Map<String, dynamic>);

        _navigatorService
            .navigateToAndRemoveUntil(Routes.registrationSuccessView);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future resetPassword() async {
    // var genericResponse = new GenericResponse();
    loaderMsg = "Resetting Password";
    if (newPasswordController.text != confirmPasswordController.text)
      _dialogService.showDialog(DialogType.WarningDialog, 'Password not match',
          'Please enter same password', '', 'Ok');
    else
      try {
        setState(ViewState.Loading);
        var response =
            await _authService.resetPassword(new ResetPasswordRequestModel(
          password: confirmPasswordController.text,
        ));
        // var genericResponse = response;
        if (response.hasError == false) {
          setState(ViewState.Completed);
          _dialogService.showDialog(DialogType.SuccessDialog, message,
              "Password Updated Successfully", Routes.loginView, done);
        } else {
          setState(ViewState.Completed);
          _snackBarService.showSnackBar(
              title: response.message ?? somethingWentWrong,
              snackbarType: SnackbarType.error);
        }
      } catch (e) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: somethingWentWrong, snackbarType: SnackbarType.error);
      }
  }

  void showPassword(){
    isPasswordVisible = !isPasswordVisible ;
    notifyListeners();
  }
}
