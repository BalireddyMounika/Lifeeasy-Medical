import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/bank_details/bank_details_viewmodel.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../utils/upper_case_formatters.dart';

class AddBankDetailsView extends StatefulWidget {
  //changed something

  @override
  State<StatefulWidget> createState() => _AddBankDetailsView();
}

class _AddBankDetailsView extends State<AddBankDetailsView> {
  final _picker = ImagePicker();
  late File _image;
  bool isImageSelected = false;
  late BankDetailsViewModel _viewModel;

  RegExp validateIfsc = RegExp("^[A-Z]{4}0[A-Z0-9]{6}");
  RegExp accountNumber = RegExp("^([0-9]{11})|([0-9]{2}-[0-9]{3}-[0-9]{6})");
  RegExp validatePan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");

  late FocusNode bank;
  late FocusNode bankName;
  late FocusNode ifscCode;
  late FocusNode bankBranch;
  late FocusNode accounts;
  late FocusNode panNumber;
  late FocusNode submit;

  @override
  void initState() {
    super.initState();

    bank = FocusNode();
    bankName = FocusNode();
    ifscCode = FocusNode();
    bankBranch = FocusNode();
    accounts = FocusNode();
    panNumber = FocusNode();
    submit = FocusNode();
  }

  @override
  void dispose() {
    bank.dispose();
    bankName.dispose();
    ifscCode.dispose();
    bankBranch.dispose();
    accounts.dispose();
    panNumber.dispose();
    submit.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  late BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BankDetailsViewModel>.reactive(
        onModelReady: (model) => model.getBankDetailsInfo(),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          _context = context;
          return Scaffold(
            appBar: CommonAppBar(
              title: "Add Bank Details",
              onBackPressed: () {
                Navigator.pop(context);
              },
              isClearButtonVisible: true,
              onClearPressed: () {
                locator<NavigationService>()
                    .navigateToAndRemoveUntil(Routes.dashboardView);
              },
            ),
            body: _currentWidget(),
            bottomSheet: ButtonContainer(
              buttonText: _viewModel.isEdit ? "UPDATE" : "ADD",
              onPressed: () {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _viewModel.isEdit
                      ? _viewModel.updateBankDetails()
                      : _viewModel.postBankDetailsInfo();
                }
              },
            ),
          );
        },
        viewModelBuilder: () => BankDetailsViewModel());
  }

  Widget _body() {
    return Stack(children: [
      SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(right: 15, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Note:- Don't Worry Data is Safe With Us Please Fill The Details Below",
                maxLines: 1,
                style: smallTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _bankaccount(),
                  _account(),
                  _bankname(),
                  _ifsccode(),
                  _bankbranch(),
                  _pan(),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _icon(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              Navigator.pop(dialogContext);
                                              var image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                      imageQuality: 60);
                                              setState(() {
                                                _image =
                                                    File(image?.path ?? "");
                                                _viewModel.addUserProfileImage(
                                                    _image);
                                                isImageSelected = true;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              var image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      imageQuality: 60);
                                              setState(() {
                                                _image =
                                                    File(image?.path ?? "");
                                                _viewModel.addUserProfileImage(
                                                    _image);
                                                isImageSelected = true;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                    child: Container(
                      height: 50,
                      width: 270,

                      //  margin: EdgeInsets.all(2),
                      //   padding: EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                        "Upload Documents",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                      decoration: BoxDecoration(
                        color: baseColor,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'please upload cancelled cheaque for the Account number',
                style: bodyTextStyle.copyWith(color: Colors.grey),
              ),
              _remarks(),
              SizedBox(
                height: kToolbarHeight,
              )
            ],
          ),
        ),
      )),
    ]);
  }

  Widget _bankaccount() {
    return TextFormField(
      focusNode: bank,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      key: _viewModel.postBankDetailsRequest.bankAccountNumber == null
          ? Key("1")
          : Key(_viewModel.postBankDetailsRequest.bankAccountNumber ?? ""),
      initialValue: _viewModel.postBankDetailsRequest.bankAccountNumber ?? "",
      onFieldSubmitted: (term) {
        bank.unfocus();
        FocusScope.of(context).requestFocus(accounts);
      },
      onSaved: (value) {
        _viewModel.postBankDetailsRequest.bankAccountNumber = value ?? "0";
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Bank Account Number';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: bankAccount,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _bankname() {
    return TextFormField(
      focusNode: bankName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      key: _viewModel.postBankDetailsRequest.bankName == null
          ? Key("2")
          : Key(_viewModel.postBankDetailsRequest.bankName ?? ""),
      initialValue: _viewModel.postBankDetailsRequest.bankName ?? "",
      onFieldSubmitted: (term) {
        bankName.unfocus();
        FocusScope.of(context).requestFocus(ifscCode);
      },
      onSaved: (value) {
        _viewModel.postBankDetailsRequest.bankName = value ?? "0";
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Bank Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: BankName,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _ifsccode() {
    return TextFormField(
      focusNode: ifscCode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      key: _viewModel.postBankDetailsRequest.ifscCode == null
          ? Key("3")
          : Key(_viewModel.postBankDetailsRequest.ifscCode ?? ""),
      initialValue: _viewModel.postBankDetailsRequest.ifscCode ?? "",
      inputFormatters: [UpperCaseTextFormatter()],
      onFieldSubmitted: (term) {
        ifscCode.unfocus();
        FocusScope.of(context).requestFocus(bankBranch);
      },
      onSaved: (value) {
        _viewModel.postBankDetailsRequest.ifscCode = value ?? "0";
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your IFSCode';
        } else if (value.length < 11) {
          return 'Enter Valid Number';
        } else if (value.length > 11) {
          return "Enter valid Number";
        } else if (!validateIfsc.hasMatch(value)) {
          return "Please specify a valid ifsc code Number";
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: IfscCode,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _bankbranch() {
    return TextFormField(
      focusNode: bankBranch,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      key: _viewModel.postBankDetailsRequest.bankBranch == null
          ? Key("4")
          : Key(_viewModel.postBankDetailsRequest.bankBranch ?? ""),
      initialValue: _viewModel.postBankDetailsRequest.bankBranch ?? "",
      onFieldSubmitted: (term) {
        bankBranch.unfocus();
        FocusScope.of(context).requestFocus(accounts);
      },
      onSaved: (value) {
        _viewModel.postBankDetailsRequest.bankBranch = value ?? "0";
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Bank Branch Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: BankBranch,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _account() {
    return TextFormField(
      focusNode: accounts,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      key: Key("8"),
      initialValue: _viewModel.postBankDetailsRequest.bankAccountNumber ?? "",

      onFieldSubmitted: (term) {
        accounts.unfocus();
        FocusScope.of(context).requestFocus(bankName);
      },

      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Account Number';
        } else if (_viewModel.postBankDetailsRequest.bankAccountNumber != value)
          return "Please specify a valid Account Number";
      },
      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: account,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _pan() {
    return TextFormField(
      focusNode: panNumber,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      enabled: true,
      obscureText: false,
      key: _viewModel.postBankDetailsRequest.panNumber == null
          ? Key("7")
          : Key(_viewModel.postBankDetailsRequest.panNumber ?? ""),
      initialValue: _viewModel.postBankDetailsRequest.panNumber ?? "",
      inputFormatters: [UpperCaseTextFormatter()],
      onFieldSubmitted: (term) {
        panNumber.unfocus();
        FocusScope.of(context).requestFocus(submit);
        if (_formKey.currentState!.validate()) {}
      },
      onSaved: (value) {
        _viewModel.postBankDetailsRequest.panNumber = value ?? "0";
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter PAN Number';
        } else if (!validatePan.hasMatch(value)) {
          return "Please specify a valid  Number";
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: pan,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _containers(String title) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 330,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(1),
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remarks() {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      enabled: true,
      onFieldSubmitted: (v) {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _viewModel.isEdit
              ? _viewModel.updateBankDetails()
              : _viewModel.postBankDetailsInfo();
        }
      },
      onSaved: (values) {
        _viewModel.postBankDetailsRequest.remarks = values ?? "0";
      },
      validator: (values) {},
      key: _viewModel.postBankDetailsRequest.remarks == null
          ? Key("11")
          : Key(_viewModel.postBankDetailsRequest.remarks ?? ""),
      initialValue: _viewModel.postBankDetailsRequest.remarks ?? "",
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: remarks,
        helperText: 'Any thing  extra you want to add',
        alignLabelWithHint: true,
      ),
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
                        child: NetworkImageWidget(
                          imageName: _viewModel.uriImage,
                          width: 50,
                          height: 50,
                        )))));

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

  Widget _icon() {
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
                    builder: (dialogContext) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(dialogContext);
                              },
                              child: Center(
                                child: Icon(
                                  Icons.clear,
                                  size: 34,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            verticalSpaceMedium,
                            NetworkImageWidget(
                              imageName: _viewModel.uriImage ?? "",
                              height: double.infinity,
                              width: double.infinity,
                            )
                          ],
                        ),
                      );
                    });
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

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: _viewModel.loadingMsg,
        );

      case ViewState.Completed:
        return _body();

      case ViewState.Error:
        return const Center(
            child: Text(
          "Something Went Wrong",
          style: TextStyle(fontSize: 18),
        ));
      case ViewState.Empty:
        return EmptyListWidget("Nothing Found");
      default:
        return _body();
    }
  }
}
