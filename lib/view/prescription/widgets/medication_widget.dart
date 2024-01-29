import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/viewmodel/prescription/prescription_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../../../common_widgets/loader.dart';
import '../../../get_it/locator.dart';
import '../../../viewmodel/profile/profile_viewmodel.dart';

class MedicationWidget extends ViewModelWidget<PrescriptionViewModel> {
  BuildContext? _context;
  final _formkey = GlobalKey<FormState>();
  late PrescriptionViewModel _viewModel;
  final _picker = ImagePicker();
  late File _image;

  @override
  Widget build(BuildContext context, PrescriptionViewModel viewModel) {
    _viewModel = viewModel;
    _context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: ButtonContainer(
        buttonText: "Prescribe",
        onPressed: () {
          _formkey.currentState!.save();
          //  var s = _viewModel.medicationRequestList;
          if (_viewModel.followUpDateController.text.isNotEmpty) {
            if (_formkey.currentState!.validate()) {
              _formkey.currentState!.save();
              _viewModel.postPrescription();
            }
          } else {
            locator<SnackBarService>().showSnackBar(
                title: "Select FollowUpDate", snackbarType: SnackbarType.error);
          }
        },
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _followUpDate(),
          //  verticalSpaceSmall,
          // Padding(
          //   padding: EdgeInsets.only(right: 10, left: 10,top:10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text("Add Signature",style: mediumTextStyle,),
          //       _icon(_context),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(right: 10, left: 10,top:10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //
          //       Text("Add More Medication"),
          //       GestureDetector(
          //         onTap: (){
          //
          //           _formkey.currentState!.save();
          //           _viewModel.addMoreMedication();
          //         },
          //         child: CircleAvatar(
          //           backgroundColor: baseColor,
          //           child: Center(child: Icon(Icons.add,color: Colors.white,),),
          //         ),
          //       ),
          //
          //
          //
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
            child: _followUpDate(),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Add More Medication"),
                GestureDetector(
                  onTap: () {
                    _formkey.currentState!.save();
                    _viewModel.addMoreMedication();
                  },
                  child: CircleAvatar(
                    backgroundColor: baseColor,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _viewModel.medicationRequestList.length,
                itemBuilder: (context, index) {
                  return _prescriptionContainer(index + 1);
                }),
          ),
        ],
      )),
    );
  }

  Widget _prescriptionContainer(index) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      padding: EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange,
                child: Center(
                  child: Text(
                    "${index.toString()}",
                    style: mediumTextStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _viewModel.deleteAddedMedication(index - 1);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24,
                  ))
            ],
          ),
          _drugname(index - 1),
          _quantity(index - 1),
          _frequency(index - 1),
          _drug(index - 1),
          _route(index - 1),
          _comments(index - 1),
          // _followUpDate(),
          verticalSpaceLarge,
          Visibility(
            visible: false,
            child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add Signature",
                    style: mediumTextStyle,
                  ),
                  _icon(_context),
                ],
              ),
            ),
          ),

          // _followUpDate()
        ],
      ),
    );
  }

  Widget _drugname(index) {
    return TextFormField(
      obscureText: false,
      key: Key(_viewModel.medicationRequestList[index].drugName ??
          new UniqueKey().toString()),
      initialValue: _viewModel.medicationRequestList[index].drugName ?? "",
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        if (value!.isNotEmpty)
          _viewModel.medicationRequestList[index].drugName = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Drug Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: drugName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _quantity(index) {
    return TextFormField(
      obscureText: false,
      key: Key(UniqueKey().toString()),
      initialValue: "${_viewModel.medicationRequestList[index].quantity ?? ""}",
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        if (value!.isNotEmpty)
          _viewModel.medicationRequestList[index].quantity =
              int.parse(value!.trim());
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Quantity';
        }
      },
      // inputFormatters: [
      //
      //   FilteringTextInputFormatter.digitsOnly
      // ],

      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: quantity,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _drug(index) {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      key: Key(UniqueKey().toString()),
      initialValue: _viewModel.medicationRequestList[index].dosages ?? "",
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        if (value!.isNotEmpty)
          _viewModel.medicationRequestList[index].dosages = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Drug Dosage';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: drug,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _frequency(index) {
    return TextFormField(
      obscureText: false,
      key: Key(UniqueKey().toString()),
      initialValue:
          "${_viewModel.medicationRequestList[index].frequency ?? ""}",
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,

      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        if (value!.isNotEmpty)
          _viewModel.medicationRequestList[index].frequency = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Frequency';
        }
      },
      // inputFormatters: [
      //
      //   FilteringTextInputFormatter.digitsOnly
      // ],

      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: frequency,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _from() {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Valid Date';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: from,
        suffixIcon: Icon(
          Icons.calendar_today_outlined,
          color: darkColor,
          size: 24,
        ),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _followUpDate() {
    return GestureDetector(
      onTap: () {
        _showFollowUpDatePicker();
      },
      child: TextFormField(
        obscureText: false,
        enabled: false,
        //controller: _viewModel.followUpDateController,
        initialValue: _viewModel.followUpDateController.text == ""
            ? _viewModel.followUpDateController.text
            : "${formatDate(_viewModel.followUpDateController.text ?? "")}",
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(_context!).nearestScope;
        },
        onSaved: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter Valid Date';
          }
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: date,
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: darkColor,
            size: 24,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _days() {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Number of Days';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: days,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _route(index) {
    return TextFormField(
      obscureText: false,
      initialValue: "${_viewModel.medicationRequestList[index].route ?? ""}",
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        if (value!.isNotEmpty)
          _viewModel.medicationRequestList[index].route = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Route';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: route,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _comments(index) {
    return TextFormField(
      obscureText: false,
      key: Key(UniqueKey().toString()),
      initialValue: _viewModel.medicationRequestList[index].instructions ?? "",
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        if (value!.isNotEmpty)
          _viewModel.medicationRequestList[index].instructions = value!.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'please fill this field';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: comments,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _icon(context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        Navigator.pop(dialogContext);
                                        var image = await _picker.pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 60);
                                        _image = File(image?.path ?? "");
                                        _viewModel.addUserProfileImage(_image);
                                        // setState(() {
                                        //   _image = File(image?.path??"");
                                        //   _viewModel.addUserProfileImage(_image);
                                        //   isImageSelected =true;
                                        // });
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
                                      )),
                                  InkWell(
                                      onTap: () async {
                                        Navigator.pop(dialogContext);
                                        var image = await _picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 60);
                                        _image = File(image?.path ?? "");
                                        _viewModel.addUserProfileImage(_image);
                                        // setState(() {
                                        //   _image = File(image?.path??"");
                                        //   _viewModel.addUserProfileImage(_image);
                                        //   isImageSelected =true;
                                        // });
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
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ));
              },
              child: _profileCurrentWidget(),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget _profileCurrentWidget() {
    switch (_viewModel.profileState) {
      case ProfileImageState.Loading:
        return Loader(
          isScaffold: false,
        );

      case ProfileImageState.Completed:
        return Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
            child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: AspectRatio(
                      aspectRatio: 9 / 8,
                      child: Image.network(
                        (_viewModel.uriImage ?? "image"),
                        fit: BoxFit.fill,
                      ),
                    ))));

      case ProfileImageState.Error:
        return Center(child: Icon(Icons.error));

      case ProfileImageState.Idle:
        return Container(
            height: 50,
            width: 60,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                size: 25,
              ),
            ));
      //
      // );
      default:
        return _body();
    }
  }

  void _showFollowUpDatePicker() {
    showDatePicker(
            context: _context!,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime.now(),
            //what will be the previous supported year in picker
            lastDate: DateTime.now().add(new Duration(
                days: 365))) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        return;
      } else {
        _viewModel.followUpDateController.text =
            pickedDate.toString().split(' ').first;
        _formkey.currentState!.save();
        _viewModel.reload();
      }
    });
  }
}
