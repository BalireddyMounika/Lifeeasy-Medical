import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/viewmodel/pharmacy/my_pharmacy_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../common_widgets/empty_list_widget.dart';
import '../../common_widgets/loader.dart';
import '../../constants/strings.dart';
import '../../constants/styles.dart';
import '../../enums/viewstate.dart';

class MyPharmacyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPharmacy();
}

class _MyPharmacy extends State<MyPharmacyView> {
  final _formKey = GlobalKey<FormState>();
  late MyPharmacyViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyPharmacyViewModel>.reactive(
        onViewModelReady: (model) => model.getPharmacyByProfId(),
        viewModelBuilder: () => MyPharmacyViewModel(),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          return Scaffold(
              appBar: CommonAppBar(
                title: "My Pharmacy",
                onBackPressed: () {
                  Navigator.pop(context);
                },
                isClearButtonVisible: false,
              ),
              bottomSheet: ButtonContainer(
                buttonText:
                    _viewModel.isEdit ? "Update Pharmacy" : "Add Pharmacy",
                onPressed: () {
                  _formKey.currentState?.save();
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState?.save();
                    _viewModel.isEdit
                        ? _viewModel.updatePharmacy()
                        : _viewModel.addMyPharmacy();
                  }
                },
              ),
              body: _currentWidget());
        });
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: "",
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
      case ViewState.Empty:
        return EmptyListWidget("Nothing Found");
      default:
        return _body();
    }
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pharmacyTextField(
                  controller: _viewModel.pharmacyNameController,
                  labelText: pharmacyName),
              pharmacyTextField(
                  controller: _viewModel.pharmacyRegNumberController,
                  labelText: pharmacyRegisterNo),
              pharmacyTextField(
                  controller: _viewModel.pharmacyEmailController,
                  labelText: pharmacyEmailId,
                  keyboardType: TextInputType.emailAddress),
              pharmacyTextField(
                  controller: _viewModel.pharmacyContactNumController,
                  labelText: pharmacyContactNo,
                  keyboardType: TextInputType.phone),
              pharmacyTextField(
                controller: _viewModel.pharmacyWebUrlController,
                labelText: pharmacyWebsiteUrl,
                keyboardType: TextInputType.url,
              ),
              InkWell(
                onTap: () {
                  _viewModel.selectTime(
                      context: context,
                      controller: _viewModel.pharmacyOpenTimeController);
                },
                child: AbsorbPointer(
                  child: pharmacyTextField(
                    controller: _viewModel.pharmacyOpenTimeController,
                    labelText: pharmacyOpenTime,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _viewModel.selectTime(
                      context: context,
                      controller: _viewModel.pharmacyCloseTimeController);
                },
                child: AbsorbPointer(
                  child: pharmacyTextField(
                    controller: _viewModel.pharmacyCloseTimeController,
                    labelText: pharmacyCloseTime,
                  ),
                ),
              ),
              pharmacyTextField(
                  controller: _viewModel.pharmacyAuthFirstNameController,
                  labelText: authorisedFirstName),
              pharmacyTextField(
                  controller: _viewModel.pharmacyAuthLastNameController,
                  labelText: authorisedLastName),
              pharmacyTextField(
                controller: _viewModel.pharmacyAuthEmailController,
                labelText: authorisedEmailId,
                keyboardType: TextInputType.url,
              ),
              pharmacyTextField(
                  controller: _viewModel.pharmacyAuthContactController,
                  labelText: authorisedMobileNo,
                  keyboardType: TextInputType.phone),
              pharmacyTextField(
                  controller: _viewModel.pharmacyAddressController,
                  labelText: authorisedAddress),
              pharmacyTextField(
                  controller: _viewModel.pharmacyLicenceController,
                  labelText: authorisedLicenseNo),
              verticalSpace(100)
            ],
          ),
        ),
      ),
    );
  }

  Widget pharmacyTextField(
      {required TextEditingController controller,
      required String labelText,
      VoidCallback? onTap,
      bool? isEnable,
      TextInputType? keyboardType,
      Widget? preFixWidget}) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.next,
        enabled: isEnable ?? true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'required field';
          }
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: labelText,
          alignLabelWithHint: true,
          prefix: preFixWidget,
        ),
      ),
    );
  }
}
