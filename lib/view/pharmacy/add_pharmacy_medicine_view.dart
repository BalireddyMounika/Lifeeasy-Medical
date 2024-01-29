import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/pharmacy/add_pharmacy_medicine_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../common_widgets/empty_list_widget.dart';
import '../../common_widgets/loader.dart';
import '../../constants/strings.dart';
import '../../constants/styles.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../models/pharmacy/pharmacy_order_response.dart';
import '../../routes/route.dart';

class AddPharmacyMedicineView extends StatefulWidget {
  PharmacyOrderResponse responseData = new PharmacyOrderResponse();
  AddPharmacyMedicineView(this.responseData);
  @override
  State<StatefulWidget> createState() => _AddPharmacyMedicineView();
}

class _AddPharmacyMedicineView extends State<AddPharmacyMedicineView> {
  final _formKey = GlobalKey<FormState>();
  late AddPharmacyMedicineViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPharmacyMedicineViewModel>.reactive(
        viewModelBuilder: () =>
            AddPharmacyMedicineViewModel(widget.responseData),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;

          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: FloatingActionButton(
                child: Center(
                  child: Icon(Icons.add),
                ),
                onPressed: () {
                  _viewModel.addMoreMedication();
                },
              ),
            ),
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              title: "Add Medicine",
              onBackPressed: () {
                locator<NavigationService>().goBack();
              },
              onClearPressed: () {
                locator<NavigationService>()
                    .navigateTo(Routes.pharmacyDashBoardView);
              },
              isClearButtonVisible: true,
            ),
            bottomSheet: ButtonContainer(
              buttonText: "ADD",
              onPressed: () {
                _formKey.currentState?.save();
                var s = _viewModel.medicineRequestList;
                _formKey.currentState?.validate();
                if (_formKey.currentState?.validate() == true)
                  _viewModel.addPharmacyMedicine();
              },
            ),
            body: _currentWidget(),
          );
        });
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: _viewModel.loadingMsg,
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

  Widget _medicineContainer(index) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(color: redColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: mediumTextStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _viewModel.deleteMedicine(index);
                },
                child: Visibility(
                  visible: index != 0 ? true : false,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(left: 270),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: redColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          _medicineName(index),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _medicinePower(index)),
              horizontalSpaceMedium,
              Expanded(child: _medicineQty(index)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _medicinePrice(index)),
              horizontalSpaceMedium,
              Expanded(child: _medicineDiscount(index)),
            ],
          ),
          _instruction(index),
          verticalSpaceMassive
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      imageName:
                                          widget.responseData.uploadDocument ??
                                              "",
                                      height: double.infinity,
                                      width: double.infinity,
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffF8F8F6)),
                        child: Center(
                            child: Icon(Icons.image,
                                size: 64, color: Colors.grey)),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text("Click this Icon to see"),
                          Text("the Prescription")
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                Flexible(
                  child: ListView.builder(
                      itemCount: _viewModel.medicineRequestList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _medicineContainer(index);
                      }),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _medicineName(index) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      initialValue: _viewModel.medicineRequestList[index].medicine == null
          ? " "
          : _viewModel.medicineRequestList[index].medicine,
      //   key:_viewModel.postBankDetailsRequest.bankAccountNumber == null? Key("1") :Key(_viewModel.postBankDetailsRequest.bankAccountNumber??""),
      //  initialValue:
      //   onFieldSubmitted: (term) {
      //     bank.unfocus();
      //     FocusScope.of(context).requestFocus(bankName);
      //   },
      onSaved: (value) {
        _viewModel.medicineRequestList[index].medicine =
            value?.trim().toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Medicine Name';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Enter Medicine Name",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _medicinePower(index) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      initialValue: _viewModel.medicineRequestList[index].power == null
          ? " "
          : _viewModel.medicineRequestList[index].power,

      //   key:_viewModel.postBankDetailsRequest.bankAccountNumber == null? Key("1") :Key(_viewModel.postBankDetailsRequest.bankAccountNumber??""),
      //  initialValue:
      //   onFieldSubmitted: (term) {
      //     bank.unfocus();
      //     FocusScope.of(context).requestFocus(bankName);
      //   },
      onSaved: (value) {
        _viewModel.medicineRequestList[index].power = value?.trim().toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Medicine Power';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Power",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _medicineQty(index) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      initialValue: _viewModel.medicineRequestList[index].quantity == null
          ? " "
          : _viewModel.medicineRequestList[index].quantity.toString(),

      //   key:_viewModel.postBankDetailsRequest.bankAccountNumber == null? Key("1") :Key(_viewModel.postBankDetailsRequest.bankAccountNumber??""),
      //  initialValue:
      //   onFieldSubmitted: (term) {
      //     bank.unfocus();
      //     FocusScope.of(context).requestFocus(bankName);
      //   },
      onSaved: (value) {
        if (value!.isNotEmpty && value != " ")
          _viewModel.medicineRequestList[index].quantity = int.parse(value);
      },
      validator: (value) {
        if (value!.isEmpty || value == " ") {
          return 'Enter Medicine Quantity';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Quantity",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _medicinePrice(index) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      initialValue: _viewModel.medicineRequestList[index].cost == null
          ? " "
          : _viewModel.medicineRequestList[index].cost.toString(),

      //   key:_viewModel.postBankDetailsRequest.bankAccountNumber == null? Key("1") :Key(_viewModel.postBankDetailsRequest.bankAccountNumber??""),
      //  initialValue:
      //   onFieldSubmitted: (term) {
      //     bank.unfocus();
      //     FocusScope.of(context).requestFocus(bankName);
      //   },
      onSaved: (value) {
        if (value!.isNotEmpty && value != " ")
          _viewModel.medicineRequestList[index].cost = int.parse(value);
        int quantity = _viewModel.medicineRequestList[index].quantity!.toInt();
        int cost = _viewModel.medicineRequestList[index].cost!.toInt();
        int total = quantity * cost;
        _viewModel.medicineRequestList[index].total = total.toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Medicine Price';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Price",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _medicineDiscount(index) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      initialValue: _viewModel.medicineRequestList[index].discount == null
          ? " "
          : _viewModel.medicineRequestList[index].discount,

      //   key:_viewModel.postBankDetailsRequest.bankAccountNumber == null? Key("1") :Key(_viewModel.postBankDetailsRequest.bankAccountNumber??""),
      //  initialValue:
      //   onFieldSubmitted: (term) {
      //     bank.unfocus();
      //     FocusScope.of(context).requestFocus(bankName);
      //   },
      onSaved: (value) {
        _viewModel.medicineRequestList[index].discount =
            value?.trim().toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Medicine Discount';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: "Discount",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _instruction(index) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      enabled: true,
      obscureText: false,
      initialValue: _viewModel
                  .medicineRequestList[index].specialInstructionsForMedicine ==
              null
          ? " "
          : _viewModel
              .medicineRequestList[index].specialInstructionsForMedicine,

      //   key:_viewModel.postBankDetailsRequest.bankAccountNumber == null? Key("1") :Key(_viewModel.postBankDetailsRequest.bankAccountNumber??""),
      //  initialValue:
      //   onFieldSubmitted: (term) {
      //     bank.unfocus();
      //     FocusScope.of(context).requestFocus(bankName);
      //   },
      onSaved: (value) {
        _viewModel.medicineRequestList[index].specialInstructionsForMedicine =
            value?.trim().toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Instruction';
        }
      },
      style: mediumTextStyle,
      decoration: InputDecoration(
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        helperText: "Optional",
        helperStyle: smallTextStyle.copyWith(color: Colors.red),
        labelText: "Instruction",
        alignLabelWithHint: true,
      ),
    );
  }
}
