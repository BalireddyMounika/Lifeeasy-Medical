import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/authentication/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

//ignore: must_be_immutable
class EnterPhoneNumberWidget extends ViewModelWidget<RegistrationViewModel> {
  late RegistrationViewModel _viewModel;
  @override
  Widget build(BuildContext context, RegistrationViewModel model) {
    _viewModel = model;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: displayHeight(context) * 0.5,
        ),
        Text(
          enterYourMobileNumber,
          style: authHeaderTextStyle,
        ),
        SizedBox(
          height: displayHeight(context) * .3,
        ),
        _enterNumberWidget(),
        Divider(
          thickness: 1.5,
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.topRight,
            child: Text(
              sendOtpToThisNumber,
              style: bodyTextStyle.copyWith(color: darkColor),
              textAlign: TextAlign.right,
            )),
      ],
    );
  }

  Widget _enterNumberWidget() {
    return InternationalPhoneNumberInput(
      keyboardAction: TextInputAction.done,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      onInputChanged: (PhoneNumber number) {
        _viewModel.internationalPhoneNumber = number;
      },
      textFieldController: _viewModel.phoneNumberController,
      inputBorder: InputBorder.none,
      onFieldSubmitted: (term) {
        if (_viewModel.phoneNumberController.text.isNotEmpty)
          _viewModel.isPhoneNumberRegistered();
        else
          locator<SnackBarService>().showSnackBar(
              title: "Phone Number Required", snackbarType: SnackbarType.error);
      },
      formatInput: false,
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      initialValue: _viewModel.internationalPhoneNumber,
    );
  }
}
