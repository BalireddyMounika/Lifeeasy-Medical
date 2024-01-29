import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EnterDetailsWidget extends ViewModelWidget<RegistrationViewModel> {
  // final GlobalKey<FormState> _formState = GlobalKey();
  late BuildContext _context;
  late RegistrationViewModel _viewModel;
  @override
  Widget build(BuildContext context, RegistrationViewModel model) {
    this._context = context;
    _viewModel = model;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: displayHeight(context) * 0.5,
            ),
            Text(
              enterYourDetails,
              style: authHeaderTextStyle,
            ),

            verticalSpaceSmall,
            // Text("Address : ${SessionManager.getLocation.address}",style: smallTextStyle,),
            // SizedBox(
            //   height: displayHeight(context) * .2,
            // ),
            _firstName(),
            _lastName(),
            _email(),
            _userName(),
            _passWord(),
            _confirmPassWord(),

            verticalSpaceMedium,
            verticalSpaceMedium,

            SizedBox(
              height: 20,
            ),

            Padding(
              padding: authMargin,
              // child: Text(acceptTermsAndConditions,style: smallTextStyle.copyWith(color: darkColor),textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstName() {
    return TextFormField(
      obscureText: false,
      //  key: _viewModel.registerRequestModel.firstname== null? Key("1") : Key(_viewModel.registerRequestModel.firstname??""),
      initialValue: _viewModel.registerRequestModel.firstname ?? "",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {
        _viewModel.registerRequestModel.firstname = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) return "Enter FirstName";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: firstName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _lastName() {
    return TextFormField(
      obscureText: false,
      //   key: _viewModel.registerRequestModel.lastname== null? Key("2") : Key(_viewModel.registerRequestModel.lastname??""),

      initialValue: _viewModel.registerRequestModel.lastname ?? "",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {
        _viewModel.registerRequestModel.lastname = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) return "Enter LastName";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: lastName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //   key: _viewModel.registerRequestModel.email== null? Key("3") : Key(_viewModel.registerRequestModel.email??""),

      initialValue: _viewModel.registerRequestModel.email ?? "",
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {
        _viewModel.registerRequestModel.email = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty)
          return "Enter email address";
        else if (!value.contains('@')) {
          return 'Enter Valid email Address';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: email,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _userName() {
    return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //   key: _viewModel.registerRequestModel.username== null? Key("6") : Key(_viewModel.registerRequestModel.username??""),

      initialValue: _viewModel.registerRequestModel.username ?? "",
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {
        _viewModel.registerRequestModel.username = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) return "Enter UserName";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: userName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _passWord() {
    return TextFormField(
      controller: _viewModel.newPasswordController,
      obscureText: !_viewModel.isPasswordVisible,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //  key: _viewModel.registerRequestModel.password== null? Key("7") : Key(_viewModel.registerRequestModel.password??""),
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {
        _viewModel.registerRequestModel.password = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty)
          return "Password must be enter";
        else if (value.length <= 6)
          return "Password must be at least 6 characters";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: password,
          helperText:
              "Password must contain on capital letter, special character and number",
          alignLabelWithHint: true,
          suffixIcon: InkWell(
            onTap: () => _viewModel.showPassword(),
            child: _viewModel.isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
          )),
    );
  }

  Widget _confirmPassWord() {
    return TextFormField(
      controller: _viewModel.confirmPasswordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        _viewModel.formState.currentState!.validate();
        _viewModel.formState.currentState!.save();

        if (_viewModel.formState.currentState!.validate()) if (_viewModel
                .newPasswordController.text ==
            _viewModel.confirmPasswordController.text) {
          _viewModel.registerUser();
        } else {
          Fluttertoast.showToast(msg: 'Password mismatch');
        }
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty)
          return "Enter Confirm Password";
        else if (value.length <= 6) return "Password Do Not Match";
      },
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(10,),
      // ],
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: confirmPassword,
        alignLabelWithHint: true,
      ),
    );
  }
}
