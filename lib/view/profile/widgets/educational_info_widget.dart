import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../common_widgets/loader.dart';
import '../../../enums/viewstate.dart';

class EducationalInfoView extends StatefulWidget {
  const EducationalInfoView({Key? key}) : super(key: key);

  @override
  State<EducationalInfoView> createState() => _EducationalInfoViewState();
}

class _EducationalInfoViewState extends State<EducationalInfoView> {
  final _formKey = GlobalKey<FormState>();
  late ProfileViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onModelReady: (model)=>model.getHcpDetailInfo(),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          return Scaffold(
            appBar: CommonAppBar(
              title: 'Education Information',
              onBackPressed: (){
                Navigator.pop(context);
              },
              isClearButtonVisible: false,
            ),
            backgroundColor: Colors.white,
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
              children: [
                // _name(),
                _degree(),
                _college(),
                _year(),
                _education(),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 340,
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: ButtonContainer(
            buttonText: _viewModel.hcpDetailResponse.education == null
                ? "ADD"
                : "UPDATE",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_viewModel.hcpDetailResponse.education == null)
                  _viewModel.addEducationalProfile();
                else
                  _viewModel.updateEducationalProfile();
              }
            }),
      ),
      SizedBox(
        height: 40,
      ),
    ]);
  }

  Widget _degree() {
    return TextFormField(
      focusNode: _viewModel.degreeFocusNode,
      initialValue: _viewModel.hcpDetailResponse.education?.degree ?? '',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.degreeFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.educationFocusNode);
      },
      onSaved: (value) {
        _viewModel.educationalProfileRequest.degree = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Degree Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: degree,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _college() {
    return TextFormField(
      focusNode: _viewModel.collegeFocusNode,
      initialValue:
          _viewModel.hcpDetailResponse.education?.collegeUniversity ?? '',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.collegeFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.educationFocusNode);
      },
      onSaved: (value) {
        _viewModel.educationalProfileRequest.collegeUniversity = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Institute Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: college,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _year() {
    return TextFormField(
      focusNode: _viewModel.yearsFocusNode,
      initialValue:
          _viewModel.hcpDetailResponse.education?.yearOfEducation.toString() ,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        _viewModel.yearsFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_viewModel.educationFocusNode);
      },
      onSaved: (value) {
        _viewModel.educationalProfileRequest.yearOfEducation =
            int.parse(value ?? '');
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Year';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: year,
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _education() {
    return TextFormField(
      focusNode: _viewModel.educationFocusNode,
      initialValue:
          _viewModel.hcpDetailResponse.education?.educationalLocation??'',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      enabled: true,
      obscureText: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).unfocus();
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (_viewModel.hcpDetailResponse.education == null)
            _viewModel.addEducationalProfile();
          else
            _viewModel.updateEducationalProfile();
        }
      },
      onSaved: (value) {
        _viewModel.educationalProfileRequest.educationalLocation = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Education Location ';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: education,
        alignLabelWithHint: true,
      ),
    );
  }
}
