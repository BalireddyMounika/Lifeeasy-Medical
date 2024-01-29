import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/login_viewmodel.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  static var userName = "";

  @override
  State<StatefulWidget> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  String currentAppVersion = '';

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      currentAppVersion = info.version;
    });
  }

  void initState() {
    _initPackageInfo();
    super.initState();
  }

  late LoginViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: _currentWidget());
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }

  Widget _loginContainer() {
    return Container(
      margin: authMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: displayHeight(context) * 1),
          Align(
              alignment: Alignment.center,
              child: Container(
                  height: 100,
                  width: 200,
                  child: Image.asset(
                    "images/lifeeazy.png",
                    fit: BoxFit.contain,
                  ))),
          SizedBox(height: 30),
          // Row(
          //   children: [
          //     Text("vivify healthcare private company",style: TextStyle(color: Colors.black,fontSize: 10),)
          //   ],
          // ),

          _userName(),
          _passWord(),
          SizedBox(height: displayHeight(context) * 0.3),
          _registerAndResetPasswordHint(),
          SizedBox(height: displayHeight(context) * 0.5),
          _signInWithOtp(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: _text(),
          ),
          verticalSpaceMedium
          // Row(
          //   children: [
          //     Center(child: Text("vivify healthcare private company",style: TextStyle(color: Colors.black,fontSize: 10),))
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _passWord() {
    return TextFormField(
      //focusNode: passwords,
      obscureText: !_viewModel.isShowPassword,
      controller: _viewModel.passwordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        if (_viewModel.userNameController.text.isEmpty ||
            _viewModel.passwordController.text.isEmpty)
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text("Either Username or Password is Empty")));
        else
          _viewModel.login();
      },

      onSaved: (value) {},
      validator: (value) {},
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: password,
        suffixIcon: IconButton(
          icon: Icon(_viewModel.isShowPassword
              ? Icons.visibility
              : Icons.visibility_off),
          onPressed: () {
            _viewModel.isShowPassword =
                _viewModel.isShowPassword == false ? true : false;
          },
        ),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _userName() {
    return TextFormField(
      //focusNode: username,
      obscureText: false,
      controller: _viewModel.userNameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      onFieldSubmitted: (v) {
        FocusScope.of(context).nearestScope;
      },

      onSaved: (value) {},
      validator: (value) {},
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: phoneInputHint,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _registerAndResetPasswordHint() {
    return Container(
      height: kToolbarHeight - 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.registerView);
            },
            child: RichText(
              text: TextSpan(
                  text: notSignUpYet,
                  style: smallTextStyle.copyWith(color: darkColor),
                  children: <TextSpan>[
                    TextSpan(
                        text: register,
                        style: mediumTextStyle.copyWith(
                            color: baseColor, fontWeight: FontWeight.bold))
                  ]),
            ),
          ),
          Spacer(),
          VerticalDivider(
            thickness: 1,
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.resetPasswordView);
            },
            child: Text(resetPassword,
                style: bodyTextStyle.copyWith(
                    color: darkColor, fontWeight: FontWeight.normal)),
          )
        ],
      ),
    );
  }

  Widget _signInWithOtp() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.signInWithOtpView);
      },
      child: Container(
        height: kToolbarHeight,
        width: displayWidth(context) * 3.5,
        decoration: BoxDecoration(
            border: Border.all(color: baseColor, width: 1),
            borderRadius: BorderRadius.circular(standardBorderRadius)),
        child: Center(
            child: Text(
          signInWithOtp,
          style: bodyTextStyle.copyWith(color: baseColor),
        )),
      ),
    );
  }

  Widget _text() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          "Vivify Healthcare Pvt. Ltd. \n"
          "V $currentAppVersion",
          style: TextStyle(color: Colors.black, fontSize: 15),
          textAlign: TextAlign.center,
        ))
      ],
    );
  }

  Widget _body() {
    return Container(
      child: Stack(children: [
        _loginContainer(),
        Align(
          alignment: Alignment.bottomCenter,
          // child: Padding(
          //   padding: const EdgeInsets.only(bottom: buttonBottomPadding),

          child: ButtonContainer(
            buttonText: login,
            onPressed: () {
              if (_viewModel.userNameController.text.isEmpty ||
                  _viewModel.passwordController.text.isEmpty)
                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                    content: new Text("Either Username or Password is Empty")));
              else
                _viewModel.login();
            },
          ),
        ),
      ]),
    );
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: "Logging In",
          loadingMsgColor: Colors.black,
        );

      case ViewState.Completed:
        return _body();

      default:
        return _body();
    }
  }

//   Future<void> initializeFirebaseService() async {
//     String firebaseAppToken;
//     bool isFirebaseAvailable;
//
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       isFirebaseAvailable =
//           await AwesomeNotifications().isNotificationAllowed();
//
//       if (isFirebaseAvailable) {
//         try {
//           //firebaseAppToken = await AwesomeNotifications().;
//
//           //SessionManager.getInstance().setFcmToken = firebaseAppToken;
//           // debugPrint('Firebase token: $firebaseAppToken');
//         } on Exception {
//           firebaseAppToken = 'failed';
//           debugPrint('Firebase failed to get token');
//         }
//       } else {
//         firebaseAppToken = 'unavailable';
//         debugPrint('Firebase is not available on this project');
//       }
//     } on Exception {
//       isFirebaseAvailable = false;
//       firebaseAppToken = 'Firebase is not available on this project';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
// //    if (!mounted){
// //      _firebaseAppToken = firebaseAppToken;
// //      return;
// //    }
// //
// //    setState(() {
// //      _firebaseAppToken = firebaseAppToken;
// //    });
//   }
}
