import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LabWidget extends ViewModelWidget<ProfileViewModel>
{
  BuildContext? _context;
  final _formkey = GlobalKey<FormState> ();
  late ProfileViewModel _viewModel;
  @override
  Widget build(BuildContext context, viewModel) {
    return Scaffold(
      body: _body(),
    );
  }
      Widget _body()
    {
      return Stack(
        children:[
      SingleChildScrollView(
        child:Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.only(right: 10,left: 10),
          padding: EdgeInsets.all(22),
          child: Column(
            children: [
              _labtest(),
              _lab(),
              Container(
                child: Column(
                  children: [
                    _comments(),
                  ],
                ),
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.all(3),
              ),
            ],
          ),
        ),
      ),
      ),
          Align(
          alignment: Alignment.bottomCenter,
          child: ButtonContainer(
        buttonText: "Save & Next",
        onPressed: () {
          if (_formkey.currentState!.validate()) {}
        },
      ),
      )
      ]
      );
  }
  Widget _labtest() {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Name of Lab Test';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: labTest,
        alignLabelWithHint: true,
      ),
    );
  }
  Widget _lab() {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return ' Enter Lab Code';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: lab,
        alignLabelWithHint: true,
      ),
    );
  }
  Widget _comments() {
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {},
      validator: (value) {
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: comments,
        helperText: 'optional',
        alignLabelWithHint: true,
      ),
    );
  }
}