import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../common_widgets/button_container.dart';
import '../../common_widgets/loader.dart';
import '../../constants/colors.dart';
import '../../constants/margins.dart';
import '../../constants/strings.dart';
import '../../constants/styles.dart';
import '../../enums/snackbar_type.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../models/profile/hcp_detail_response.dart';
import '../../net/session_manager.dart';
import '../../services/common_service/snackbar_service.dart';
import '../dashboard/widgets/location_search_widget.dart';

class PersonalInformationView extends StatefulWidget {
  final HcpDetailResponse hcpDetailResponse;
  const PersonalInformationView(this.hcpDetailResponse);

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  late ProfileViewModel _viewModel;

  late BuildContext _context;
  final _picker = ImagePicker();
  late File _image;
  bool isImageSelected = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _context = context;
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (model) => model.getHcpDetailInfo(),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          return Scaffold(
            appBar: AppBar(
              title: Text('Personal Information'),
            ),
            body: _currentWidget(),
          );
        });
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: _viewModel.loaderMsg,
          loadingMsgColor: Colors.black,
        );

      case ViewState.Completed:
        return _body();

      case ViewState.Error:
        return Center(
            child: Text(
          somethingWentWrong,
          style: mediumTextStyle,
        ));

      default:
        return _body();
    }
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
                    // Visibility(
                    //     visible: _viewModel.hcpDetailResponse.profile == null
                    //         ? false
                    //         : true,
                    //     child: _firstName()),
                    // Visibility(
                    //     visible: _viewModel.hcpDetailResponse.profile == null
                    //         ? false
                    //         : true,
                    //     child: _lastname()),
                    // Visibility(
                    //     visible: _viewModel.hcpDetailResponse.profile == null
                    //         ? false
                    //         : true,
                    //     child: _email()),
                    verticalSpaceMedium,
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => SimpleDialog(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(dialogContext);
                                            var image = await _picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 60);
                                            setState(() {
                                              _image = File(image?.path ?? "");
                                              _viewModel
                                                  .addUserProfileImage(_image);
                                              isImageSelected = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.camera,
                                                  color: baseColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  camera,
                                                  style: mediumTextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(dialogContext);
                                            var image = await _picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 60);
                                            setState(() {
                                              _image = File(image?.path ?? "");
                                              _viewModel
                                                  .addUserProfileImage(_image);
                                              isImageSelected = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  color: baseColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  gallery,
                                                  style: mediumTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: _profileCurrentWidget()),
                    ),
                    verticalSpaceLarge,
                    _firstName(),
                    _lastname(),
                    _email(),
                    _timeZone(),
                    _address(context),
                    _city(),
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
          buttonText: widget.hcpDetailResponse.profile == null
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

  Widget _profileCurrentWidget() {
    switch (_viewModel.profileState) {
      case ProfileImageState.Loading:
        return Loader(
          isScaffold: false,
        );

      case ProfileImageState.Completed:
        return SizedBox(
            height: 100,
            width: 100,
            child: ClipOval(
              child: NetworkImageWidget(
                  imageName: SessionManager.profileImageUrl ?? "",
                  width: 100,
                  height: 100),
            ));

      case ProfileImageState.Error:
        return Center(child: Icon(Icons.error));

      case ProfileImageState.Idle:
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ]),
          child: Center(
            child: Icon(
              Icons.add_a_photo,
              color: darkColor,
              size: 40,
            ),
          ),
        );

      default:
        return _body();
    }
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
        if (value!.isEmpty) return 'Enter Lastname';
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

        FocusScope.of(_context).requestFocus(_viewModel.addressFocusNode);
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

  // Widget _address() {
  //   return Flexible(
  //     child: TextFormField(
  //       controller: _viewModel.addressTextController,
  //       enabled: true,
  //       focusNode: _viewModel.addressFocusNode,
  //
  //       // initialValue: _viewModel.profileRequest.address??"",
  //       keyboardType: TextInputType.text,
  //       obscureText: false,
  //       textInputAction: TextInputAction.next,
  //       onFieldSubmitted: (term) {
  //         _viewModel.addressFocusNode.unfocus();
  //         FocusScope.of(_context!).requestFocus(_viewModel.zipcodeFocusNode);
  //       },
  //       // controller: _viewModel.addressController,
  //       onSaved: (value) {
  //         _viewModel.profileRequest.address = value;
  //       },
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return 'Enter your present Address';
  //         }
  //       },
  //       style: mediumTextStyle,
  //       decoration: InputDecoration(
  //           labelStyle: textFieldsHintTextStyle,
  //           hintStyle: textFieldsHintTextStyle,
  //           labelText: address,
  //           alignLabelWithHint: true,
  //           suffixIcon: GestureDetector(
  //             onTap: () async {
  //               var data = await Navigator.of(context)
  //                   .push(new MaterialPageRoute<String>(
  //                       builder: (BuildContext context) {
  //                         return new LocationSearchWidget();
  //                       },
  //                       fullscreenDialog: true));
  //               _viewModel.updateLocation(data);
  //             },
  //             child: Icon(
  //               Icons.location_on,
  //               color: baseColor,
  //             ),
  //           )),
  //     ),
  //   );
  // }

  Widget _address(context) {
    return TextFormField(
      obscureText: false,
      maxLines: 2,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      controller: _viewModel.addressTextController,
      onSaved: (value) {
        _viewModel.profileRequest.address =
            _viewModel.addressTextController.text;
      },
      validator: (value) {
        if (value!.isEmpty) return "Empty Address";
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: address,
          alignLabelWithHint: true,
          suffixIcon: GestureDetector(
            onTap: () async {
              var data = await Navigator.of(context)
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
        FocusScope.of(_context).requestFocus(_viewModel.cityFocusNode);
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
        FocusScope.of(_context).requestFocus(_viewModel.emailFocusNode);
      },
      // onFieldSubmitted: (v) {
      //   FocusScope.of(_context!).nearestScope;
      // },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter mobile Number';
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
          return 'Enter email Address';
        } else if (!value.contains('@')) {
          return 'Enter valid email address';
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
            return 'Enter your State';
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
      keyboardType: TextInputType.numberWithOptions(signed: true),
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _viewModel.addressFocusNode.unfocus();
        FocusScope.of(_context).nearestScope;
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
