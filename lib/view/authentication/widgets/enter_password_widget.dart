import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EnterPasswordWidget extends ViewModelWidget<RegistrationViewModel> {
  late BuildContext _context;
  late RegistrationViewModel _viewModel;
  final _formState = GlobalKey<FormState>();
  var passRegex =
      new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#%^&*.,?]).+");

  @override
  Widget build(BuildContext context, RegistrationViewModel model) {
    this._context = context;
    _viewModel = model;
    return SingleChildScrollView(
      child: Form(
        key: _viewModel.formState,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: displayHeight(context) * 0.5,
            ),
            Text(
              changeYourPassword,
              style: authHeaderTextStyle,
            ),
            SizedBox(
              height: displayHeight(context) * .2,
            ),
            _enterNewPassword(),
            _confirmNewPassword(),
          ],
        ),
      ),
    );
  }

  Widget _enterNewPassword() {
    return TextFormField(
      obscureText: true,
      controller: _viewModel.newPasswordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        // FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty)
          return "Password must be enter";
        else if (value!.length < 6)
          return "Password must be at least 6 characters";
        else if (passRegex.hasMatch(value) == false)
          return "Must contain one capital letter , number and special character";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: enterNewPassword,
        helperText:
            "Password must contain on capital letter, special character & Number",
        hintMaxLines: 2,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _confirmNewPassword() {
    return TextFormField(
      controller: _viewModel.confirmPasswordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        if (_viewModel.formState.currentState!.validate()) {
          _viewModel.formState.currentState!.save();
          if (_viewModel.currentScreen == 1)
            _viewModel.isPhoneNumberRegistered();
          else if (_viewModel.currentScreen == 3) _viewModel.resetPassword();
        }
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty)
          return "Enter Confirmed Password";
        else if (value!.length < 6)
          return "Password must be at least 6 characters";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: confirmNewPassword,
        alignLabelWithHint: true,
      ),
    );
  }
}
