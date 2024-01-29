import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/common_card.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ClinicView extends StatelessWidget {
  late BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  late ProfileViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onViewModelReady: (model) => model.initialisedDate(),
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              title: "Add Clinic View",
              onBackPressed: () {
                Navigator.pop(context);
              },
              onClearPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.dashboardView, (route) => false);
              },
            ),
            body: _currentWidget());
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
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
    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(_context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _clinicname(),
                  _location(),
                  verticalSpaceMedium,
                  verticalSpaceMedium,
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _viewModel.clinicListResponse.length,
                      itemBuilder: (_context, idx) => CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _viewModel
                                          .clinicListResponse[idx].clinicName ??
                                      '_',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _viewModel.updateClinicData(
                                        data:
                                            _viewModel.clinicListResponse[idx]);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.baseColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              _viewModel.clinicListResponse[idx].address ?? '_',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 12, horizontal: 20),
                      ).paddingSymmetric(vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ButtonContainer(
            buttonText: _viewModel.isClinicEdit ? "UPDATE" : "SAVE",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                _viewModel.isClinicEdit
                    ? _viewModel.updateClinic()
                    : _viewModel.addClinic();
              } else {
                locator<SnackBarService>().showSnackBar(
                    title: "Fields are required*",
                    snackbarType: SnackbarType.error);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _clinicname() {
    return TextFormField(
      controller: _viewModel.clinicNameController,
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context).nearestScope;
      },
      onSaved: (value) {
        _viewModel.clinicInfoRequest.clinicName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Clinic Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Clinic Name",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _location() {
    return TextFormField(
      obscureText: false,
      controller: _viewModel.clinicAddressController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          _viewModel.isClinicEdit
              ? _viewModel.updateClinic()
              : _viewModel.addClinic();
        } else {
          locator<SnackBarService>().showSnackBar(
              title: "Fields are required*", snackbarType: SnackbarType.error);
        }
        // FocusScope
        //     .of(_context!)
        //     .nearestScope;
      },
      onSaved: (value) {
        _viewModel.clinicInfoRequest.address = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Location';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: location,
        alignLabelWithHint: true,
      ),
    );
  }
}
