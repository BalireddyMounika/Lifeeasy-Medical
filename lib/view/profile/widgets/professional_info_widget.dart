import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/common_widgets/signature_pad_bottom_sheet.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../common_widgets/loader.dart';
import '../../../enums/viewstate.dart';

class ProfessionalInfoView extends StatefulWidget {
  const ProfessionalInfoView({Key? key}) : super(key: key);

  @override
  State<ProfessionalInfoView> createState() => _ProfessionalInfoViewState();
}

class _ProfessionalInfoViewState extends State<ProfessionalInfoView> {
  static final _formKey = GlobalKey<FormState>();
  late ProfileViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (model) => model.getHcpDetailInfo(),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          return Scaffold(
              appBar: CommonAppBar(
                title: 'Professional Information',
                onClearPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.dashboardView, (route) => false);
                },
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              body: _currentWidget());
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
            color: Colors.transparent,
            margin: authMargin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                verticalSpaceMedium,
                _professionalid(),
                _experiance(),
                _mcinumber(),
                _mcistate(),
                _specialization(),
                _area(),
                Visibility(visible: false, child: _patientshandled()),

                verticalSpaceLarge,
                GestureDetector(
                  onTap: () {
                    if (_viewModel.signatureImageUrl.isNotEmpty)
                      showSignature();
                    else
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false,
                        context: context,
                        builder: (_) => SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: SignaturePadBottomSheet(),
                        ),
                      ).then(
                        (value) {
                          _viewModel.signatureImageUrl = value;
                          _viewModel.reload();
                        },
                      );
                  },
                  child: _addSignature(),
                ),

                // _bookappointmenttype(),

                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: ButtonContainer(
            buttonText: _viewModel.hcpDetailResponse.professional == null
                ? "ADD"
                : "UPDATE",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_viewModel.signatureImageUrl.isNotEmpty) {
                  _formKey.currentState!.save();
                  if (_viewModel.hcpDetailResponse.professional == null)
                    _viewModel.addProfessionalProfile();
                  else
                    _viewModel.updateProfessionalProfile();
                } else {
                  Fluttertoast.showToast(msg: "Please Add Signature");
                }
              }
            }),
      ),
      SizedBox(
        height: 30,
      ),
    ]);
  }

  Widget _addSignature() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: redColor),
        ),
        height: _viewModel.signatureImageUrl.isEmpty ? 40 : 40,
        child: _viewModel.signatureImageUrl.isEmpty
            ? Center(
                child: Text('Add your signature'),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('View Signature'),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => SignaturePadBottomSheet(),
                          ).then((value) {
                            _viewModel.signatureImageUrl = value ?? '';
                            _viewModel.reload();
                          });
                        },
                        child: Icon(
                          Icons.edit,
                          color: baseColor,
                          size: 24,
                        ))
                  ],
                ),
              ));
  }

  Widget _professionalid() {
    return TextFormField(
      focusNode: _viewModel.professionalFocusNode,
      initialValue: _viewModel.professionalProfileRequest.professionalId ?? "",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.professionalFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.mciFocusNode);
      },
      onSaved: (value) {
        _viewModel.professionalProfileRequest.professionalId = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Professional ID';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: professionalId,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _experiance() {
    return TextFormField(
      focusNode: _viewModel.experienceFocusNode,
      initialValue: _viewModel
                  .professionalProfileRequest.professionalExperienceInYears !=
              null
          ? _viewModel.professionalProfileRequest.professionalExperienceInYears
              .toString()
          : '',
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.experienceFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.handledFocusNode);
      },
      onSaved: (value) {
        _viewModel.professionalProfileRequest.professionalExperienceInYears =
            int.parse(value!);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Experience';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: experience,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _mcinumber() {
    return TextFormField(
      focusNode: _viewModel.mciFocusNode,
      initialValue: "${_viewModel.professionalProfileRequest.mciNumber ?? ""}",
      keyboardType: TextInputType.numberWithOptions(signed: true),
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.mciFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.mciStateFocusNode);
      },
      onSaved: (value) {
        _viewModel.professionalProfileRequest.mciNumber =
            int.parse(value ?? "0");
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter MCI Number';
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: mciNumber,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _mcistate() {
    return TextFormField(
      focusNode: _viewModel.mciStateFocusNode,
      initialValue: _viewModel.professionalProfileRequest.mciStateCouncil ?? "",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.mciStateFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.areaFocusNode);
      },
      onSaved: (value) {
        _viewModel.professionalProfileRequest.mciStateCouncil = value;
      },
      validator: (value) {
        if (value!.isEmpty) return 'Enter Valid State';
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: mciState,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _specialization() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: darkColor, width: 0.5))),
      child: DropdownButton(
        hint: Text(_viewModel.specializationList.first),
        iconSize: 24,
        elevation: 16,
        value: _viewModel.specialisation,
        isExpanded: true,
        underline: Container(),
        onChanged: (value) {
          _viewModel.specialisation = value as int;
          _viewModel.professionalProfileRequest.specialization =
              _viewModel.specializationList[_viewModel.specialisation];
          _viewModel.reload();
          _formKey.currentState!.save();
        },
        items: List.generate(_viewModel.specializationList.length, (index) {
          return DropdownMenuItem(
            child: Text(
              //"Specalization",
              _viewModel.specializationList[index],
              style: mediumTextStyle,
              softWrap: true,
            ),
            value: index,
          );
        }),
      ),
      //)
    );
  }

  Widget _area() {
    return TextFormField(
      focusNode: _viewModel.areaFocusNode,
      initialValue: _viewModel.professionalProfileRequest.areaFocusOn ?? "",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.areaFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.handledFocusNode);
      },
      onSaved: (value) {
        _viewModel.professionalProfileRequest.areaFocusOn = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Current Area';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: area,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _patientshandled() {
    return TextFormField(
      obscureText: false,
      initialValue:
          "${_viewModel.professionalProfileRequest.patientsHandledPerDay ?? ""}",
      focusNode: _viewModel.patientsFocusNode,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      textInputAction: TextInputAction.next,
      enabled: true,
      onFieldSubmitted: (v) {
        _viewModel.handledFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.slotFocusNode);
      },
      // onSaved: (value) {
      //   _viewModel.professionalProfileRequest.patientsHandledPerDay =
      //       int.parse(value ?? "0");
      // },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Patients Handled/day';
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: patientsHandled,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _bottomView() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          _viewModel.selectConsultantType(0);
        },
        child: Container(
          // margin: EdgeInsets.all(18),
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              border: Border.all(
                  color: _viewModel.consultantTypeList
                              .where((element) => element.index == 0)
                              .first
                              .isSelected ==
                          true
                      ? baseColor
                      : Colors.grey)),
          child: Column(
            children: [
              Icon(
                Icons.person,
                color: _viewModel.consultantTypeList
                            .where((element) => element.index == 0)
                            .first
                            .isSelected ==
                        true
                    ? baseColor
                    : Colors.grey,
                size: 24,
              ),
              Text(
                "In-Clinic",
                style: smallTextStyle,
              )
            ],
          ),
          // child: Text("In_clinic"),
        ),
      ),
      GestureDetector(
        onTap: () {
          _viewModel.selectConsultantType(1);
        },
        child: Container(
          // margin: EdgeInsets.all(18),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: _viewModel.consultantTypeList
                              .where((element) => element.index == 1)
                              .first
                              .isSelected ==
                          true
                      ? baseColor
                      : Colors.grey)),
          child: Column(
            children: [
              Icon(
                Icons.videocam_sharp,
                color: _viewModel.consultantTypeList
                            .where((element) => element.index == 1)
                            .first
                            .isSelected ==
                        true
                    ? baseColor
                    : Colors.grey,
                size: 24,
              ),
              Text(
                "Tele Consultation",
                style: smallTextStyle,
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          _viewModel.selectConsultantType(2);
        },
        child: Container(
          // margin: EdgeInsets.all(18),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: _viewModel.consultantTypeList
                              .where((element) => element.index == 2)
                              .first
                              .isSelected ==
                          true
                      ? baseColor
                      : Colors.grey)),
          child: Column(
            children: [
              Icon(
                Icons.home_outlined,
                color: _viewModel.consultantTypeList
                            .where((element) => element.index == 2)
                            .first
                            .isSelected ==
                        true
                    ? baseColor
                    : Colors.grey,
                size: 24,
              ),
              Text(
                "At Home",
                style: smallTextStyle,
              )
            ],
          ),
        ),
      ),
    ]);
  }

  showSignature() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return Container(
            child: SingleChildScrollView(
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
                      imageName: _viewModel.signatureImageUrl,
                      width: double.infinity,
                      height: double.infinity)
                ],
              ),
            ),
          );
        });
  }
}
