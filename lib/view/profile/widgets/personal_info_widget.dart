import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/view/dashboard/widgets/location_search_widget.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../enums/snackbar_type.dart';
import '../../../get_it/locator.dart';
import '../../../services/common_service/snackbar_service.dart';

class PersonalInfoWidget extends ViewModelWidget<ProfileViewModel> {
  late BuildContext _context;
  late ProfileViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    _context = context;
    _viewModel = viewModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(children: [
      SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Container(
                margin: authMargin,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                        visible: _viewModel.hcpDetailResponse.profile == null
                            ? false
                            : true,
                        child: _firstName()),
                    Visibility(
                        visible: _viewModel.hcpDetailResponse.profile == null
                            ? false
                            : true,
                        child: _lastname()),
                    Visibility(
                        visible: _viewModel.hcpDetailResponse.profile == null
                            ? false
                            : true,
                        child: _email()),
                    _timeZone(),
                    _city(),
                    _address(),
                    _zipcode(),
                    _state(),
                    SizedBox(
                      height: 200,
                    )
                  ],
                ),
              ))),
      SizedBox(
        height: 140,
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: ButtonContainer(
          buttonText: _viewModel.hcpDetailResponse.profile == null
              ? "ADD PROFILE"
              : "UPDATE PROFILE",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (_viewModel.hcpDetailResponse.profile == null) {
                if (SessionManager.profileImageUrl!.isEmpty) {
                  locator<SnackBarService>().showSnackBar(
                      title: "Add Profile Image",
                      snackbarType: SnackbarType.error);
                } else {
                  _viewModel.addPersonalProfile();
                }
              } else {
                _viewModel.updatePersonalProfile();
              }
            }
          },
        ),
      )
    ]);
  }

  Widget _firstName() {
    return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) return 'Enter Firstname';
      },
      controller: _viewModel.firstnameController,
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: firstName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _lastname() {
    return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) return 'Enter Name';
      },
      controller: _viewModel.lastnameController,
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: lastName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _city() {
    return TextFormField(
      controller: _viewModel.cityTextController,
      enabled: true,
      focusNode: _viewModel.cityFocusNode,
      // initialValue: _viewModel.profileRequest.city??"",
      keyboardType: TextInputType.text,
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _viewModel.cityFocusNode.unfocus();

        FocusScope.of(_context!).requestFocus(_viewModel.addressFocusNode);
      },
      onSaved: (value) {
        _viewModel.profileRequest.city = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter City';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: city,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _address() {
    return Flexible(
      child: TextFormField(
        controller: _viewModel.addressTextController,
        enabled: true,
        focusNode: _viewModel.addressFocusNode,

        // initialValue: _viewModel.profileRequest.address??"",
        keyboardType: TextInputType.text,
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _viewModel.addressFocusNode.unfocus();
          FocusScope.of(_context!).requestFocus(_viewModel.zipcodeFocusNode);
        },
        // controller: _viewModel.addressController,
        onSaved: (value) {
          _viewModel.profileRequest.address = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter your Present Address';
          }
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
            labelStyle: textFieldsHintTextStyle,
            hintStyle: textFieldsHintTextStyle,
            labelText: address,
            alignLabelWithHint: true,
            suffixIcon: GestureDetector(
              onTap: () async {
                var data = await Navigator.of(_context)
                    .push(new MaterialPageRoute<String>(
                        builder: (BuildContext context) {
                          return new LocationSearchWidget();
                        },
                        fullscreenDialog: true));
                _viewModel.updateLocation(data);
              },
              child: Icon(
                Icons.location_on,
                color: baseColor,
              ),
            )),
      ),
    );
  }

  Widget _timeZone() {
    return TextFormField(
      autofocus: false,
      focusNode: _viewModel.timezoneFocusNode,
      initialValue: _viewModel.profileRequest.timezone ?? "IST",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.timezoneFocusNode.unfocus();
        FocusScope.of(_context!).requestFocus(_viewModel.cityFocusNode);
      },
      onSaved: (value) {
        _viewModel.profileRequest.timezone = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter India Standard Time';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: timezone,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _mobile() {
    return TextFormField(
      enabled: true,
      focusNode: _viewModel.mobileFocusNode,
      keyboardType: TextInputType.text,
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _viewModel.mobileFocusNode.unfocus();
        FocusScope.of(_context!).requestFocus(_viewModel.emailFocusNode);
      },
      // onFieldSubmitted: (v) {
      //   FocusScope.of(_context!).nearestScope;
      // },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Mobile Number';
        } else if (value.length > 10) {
          return 'Enter Valid Phone Number';
        }
      },

      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: enterYourMobileNumber,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      enabled: true,
      keyboardType: TextInputType.text,
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {},
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter email address';
        } else if (!value.contains('@')) {
          return 'Enter Valid email Address';
        }
      },
      controller: _viewModel.emailController,
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: email,
        hintText: "example@gmail.com",
        alignLabelWithHint: true,
      ),
    );
  }

  // Widget _state() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         border: Border(bottom: BorderSide(color: darkColor, width: 0.5))),
  //     child: DropdownButton(
  //
  //       hint: Text(_viewModel. stateList[0]),
  //       iconSize: 24,
  //       elevation: 16,
  //       isExpanded: true,
  //       underline: Container(),
  //       onChanged: (value) {
  //
  //         _viewModel.stateIndex= value as int;
  //         _viewModel.profileRequest.state =
  //         _viewModel.stateList[_viewModel.stateIndex];
  //         _viewModel.reload();
  //         _formKey.currentState!.save();
  //       },
  //
  //       items: List.generate(_viewModel. stateList.length, (index) {
  //         return DropdownMenuItem(
  //
  //           child: Text(
  //             _viewModel. stateList[index],
  //             style: mediumTextStyle,
  //             softWrap: true,
  //           ),
  //           value: index,
  //         );
  //       }),
  //       value: _viewModel.stateIndex,
  //     ),
  //   );
  // }

  Widget _state() {
    return Flexible(
      child: TextFormField(
        controller: _viewModel.stateTextController,
        enabled: true,
        // initialValue: _viewModel.profileRequest.state??"",
        keyboardType: TextInputType.text,
        obscureText: false,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (term) {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if (_viewModel.hcpDetailResponse.profile == null)
              _viewModel.addPersonalProfile();
            else
              _viewModel.updatePersonalProfile();
          }
        },
        onSaved: (value) {
          _viewModel.profileRequest.state = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter your Present Address';
          }
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: state,
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _zipcode() {
    return TextFormField(
      controller: _viewModel.zipCodeTextController,
      enabled: true,
      //   initialValue: _viewModel.profileRequest.pincode??"",
      focusNode: _viewModel.zipcodeFocusNode,
      keyboardType: TextInputType.phone,
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _viewModel.addressFocusNode.unfocus();
        FocusScope.of(_context!).nearestScope;
      },

      onSaved: (value) {
        _viewModel.profileRequest.pincode = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter PinCode';
        } else if (value.length < 6) {
          return 'Enter Valid Number';
        } else if (value.length > 6) {
          return "Enter valid Number";
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Pin Code",
        alignLabelWithHint: true,
      ),
    );
  }
}
