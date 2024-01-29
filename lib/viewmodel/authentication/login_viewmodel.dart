import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/authentication/login_request_model.dart';
import 'package:lifeeazy_medical/models/authentication/login_response_model.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/authentication/auth_servcices.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class LoginViewModel extends CustomBaseViewModel {
  var _authService = locator<AuthService>();
  var _dialogService = locator<DialogService>();
  var navigationService = locator<NavigationService>();
  var _snackBarService = locator<SnackBarService>();
  var _prefs = locator<LocalStorageService>();
  bool _isShowPassword =false;
  bool get isShowPassword => _isShowPassword;
  set isShowPassword(value) {
    _isShowPassword =value;
    notifyListeners();
  }
  TextEditingController userNameController =
  new TextEditingController(text: "");
  TextEditingController passwordController =
  new TextEditingController(text: "");

  Future<GenericResponse> login() async {
    setState(ViewState.Loading);
    var genericResponse;
    try {
      var response = await _authService.login(new LoginRequestModel(
        username: !ifMobile() ? userNameController.text : '+91${userNameController.text}',
        password: passwordController.text,
        deviceToken:SessionManager.fcmToken??"",
      ));
      genericResponse = response;
      if (response.hasError==false) {
        _prefs.setIsLogIn(true);
        _prefs.setUserModel(jsonEncode(response.result));
        print(jsonEncode(response.result));
        SessionManager.setUser =
            LoginResponseModel.fromMap(response.result as Map<String, dynamic>);


        if( SessionManager.getUser.profile == null)
          SessionManager.profileImageUrl = "";
        else {
          var image = SessionManager.getUser.profile["ProfilePicture"];
          SessionManager.profileImageUrl = image;
          _prefs.setProfileImage(image);

        }
        navigationService.navigateToAndRemoveUntil(Routes.selectPartnerTypeView);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: "Username or Password is incorrect",
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong,
          snackbarType: SnackbarType.error);
    }
    return genericResponse;
  }

  bool ifMobile()
  {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(userNameController.text);
  }
}
