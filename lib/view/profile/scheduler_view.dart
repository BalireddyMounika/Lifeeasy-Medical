import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
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
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/utils/time_formatting.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SchedulerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchedulerView();
}

class _SchedulerView extends State<SchedulerView> {
  late BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  late ProfileViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onModelReady: (model) => model.getSchedulerInfo(),
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              title: "Add Schedule",
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

  Widget _body() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              height: MediaQuery.of(_context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  verticalSpaceSmall,
                  // Container(
                  //   child: Text(
                  //     "LOCATION SLOT :-CBMCompound,Asilmetta,Visakhapatnam,Andhra Pradesh 530003.",
                  //     style: TextStyle(color: Colors.grey, fontSize: 13),
                  //   ),
                  //   margin: EdgeInsets.all(2),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  // ),

                  _inClinic(),
                  _homeConsultation(),
                  _teleConsulation(),
                  verticalSpaceMedium,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _fromDate(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: _toDate(),
                      ),
                    ],
                  ),

                  verticalSpaceMedium,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _fromTime(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: _toTime(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ButtonContainer(
              buttonText: _viewModel.isScheduleEdit ? "UPDATE" : "ADD",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _viewModel.isScheduleEdit
                      ? _viewModel.updateSchedulerProfile()
                      : _viewModel.addSchedulerProfile();
                } else {
                  locator<SnackBarService>().showSnackBar(
                      title: "Fill the required fields",
                      snackbarType: SnackbarType.error);
                }
              }),
        ),
      ],
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
          "Clinic details mandatory before  adding Schedule",
          style: mediumTextStyle,
        ));

      default:
        return _body();
    }
  }

  Widget _inClinic() {
    return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      key: ValueKey("${_viewModel.schedulerInfoRequest.inclinicFees ?? ""}"),
      initialValue: "${_viewModel.schedulerInfoRequest.inclinicFees ?? ""}",
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        _viewModel.schedulerInfoRequest.inclinicFees = int.parse(value ?? "0");
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter In-Clinic Fees';
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: 'In-Clinic',
        hintText: "Fees",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _homeConsultation() {
    return TextFormField(
      obscureText: false,

      // key: ValueKey("${_viewModel.schedulerInfoRequest.homeFees??""}"),
      initialValue: "${_viewModel.schedulerInfoRequest.homeFees ?? ""}",
      keyboardType: TextInputType.phone,

      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(_context!).nearestScope;
      },
      onSaved: (value) {
        _viewModel.schedulerInfoRequest.homeFees = int.parse(value ?? "0");
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Consultation Fee';
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        labelText: 'Home Consult',
        hintText: "Fees",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _teleConsulation() {
    return TextFormField(
      obscureText: false,
      key: Key("1"),
      initialValue:
          "${_viewModel.schedulerInfoRequest.teleconsultationFees ?? ""}",
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _viewModel.isScheduleEdit
              ? _viewModel.updateSchedulerProfile()
              : _viewModel.addSchedulerProfile();
        } else {
          locator<SnackBarService>().showSnackBar(
              title: "Fill the required fields",
              snackbarType: SnackbarType.error);
        }
      },
      onSaved: (value) {
        _viewModel.schedulerInfoRequest.teleconsultationFees =
            int.parse(value ?? "0");
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Tele Consultation Fee';
        }
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: mediumTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelStyle: textFieldsHintTextStyle,
        hintStyle: textFieldsHintTextStyle,
        hintText: "Fees",
        labelText: 'Tele consult',
        //helperText: "Fees",
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _fromDate() {
    return GestureDetector(
      onTap: () {
        _showFromDatePicker();
      },
      child: TextFormField(
        obscureText: false,
        key: UniqueKey(),
        enabled: false,
        initialValue: _viewModel.schedulerInfoRequest.fromDate == null
            ? " "
            : "${formatDate(_viewModel.schedulerInfoRequest.fromDate ?? "")}",
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
          // helperText: "Should be after ${formatDate(_viewModel.clinicInfoRequest.fromDate??"")}",
          helperStyle: smallTextStyle.copyWith(color: baseColor),
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

  Widget _toDate() {
    return GestureDetector(
      onTap: () {
        if (_viewModel.schedulerInfoRequest.fromDate != null)
          _showToDatePicker();
        else
          locator<SnackBarService>().showSnackBar(
              title: "From time not there", snackbarType: SnackbarType.error);
      },
      child: TextFormField(
        initialValue: _viewModel.schedulerInfoRequest.toDate == null
            ? ' '
            : "${formatDate(_viewModel.schedulerInfoRequest.toDate ?? "")}",
        key: UniqueKey(),
        obscureText: false,
        enabled: false,
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
          labelText: toDate,
          // helperText: "Should be before ${formatDate(_viewModel.clinicInfoRequest.toDate??"")}",
          helperStyle: smallTextStyle.copyWith(color: baseColor),
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

  void _showFromDatePicker() {
    showDatePicker(
            context: _context!,
            initialDate:
                DateTime.parse(_viewModel.clinicInfoRequest.fromDate ?? "0"),
            //which date will display when user open the picker
            firstDate:
                DateTime.parse(_viewModel.clinicInfoRequest.fromDate ?? "0"),
            //what will be the previous supported year in picker
            lastDate: DateTime.now().add(new Duration(days: 365)))
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        return;
      } else {
        _viewModel.schedulerInfoRequest.fromDate =
            pickedDate.toString().split(' ').first;
        _viewModel.reload();

        // _viewModel.setClinicFromDate(pickedDate
        //     .toString()
        //     .split(' ')
        //     .first);
      }
    });
  }

  void _showToDatePicker() {
    showDatePicker(
            context: _context!,
            initialDate:
                DateTime.parse(_viewModel.schedulerInfoRequest.fromDate ?? ""),
            //which date will display when user open the picker
            firstDate:
                DateTime.parse(_viewModel.schedulerInfoRequest.fromDate ?? ""),
            //what will be the previous supported year in picker
            lastDate: DateTime.parse(
                    _viewModel.schedulerInfoRequest.fromDate ?? "")
                .add(Duration(
                    days:
                        300))) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        return;
      } else {
        _viewModel.schedulerInfoRequest.toDate =
            pickedDate.toString().split(' ').first;
        _viewModel.reload();
      }
    });
  }

  Widget _fromTime() {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? initialTime = TimeOfDay.now();
        TimeOfDay? pickedTime = await showTimePicker(
          context: _context,
          initialTime: initialTime,
        ).then((value) {
          _viewModel.schedulerInfoRequest.fromTIme =
              "${value!.hour}:${value.minute}:00";
          _viewModel.reload();
        });
      },
      child: TextFormField(
        obscureText: false,
        //initialValue: _viewModel.schedulerInfoRequest.fromTIme??"",
        initialValue: _viewModel.schedulerInfoRequest.fromTIme == null
            ? ''
            : "${formatTime(_viewModel.schedulerInfoRequest.fromTIme!.split(':').first)} : ${_viewModel.schedulerInfoRequest.fromTIme!.split(':')[1]} ${int.parse(_viewModel.schedulerInfoRequest.fromTIme!.split(':').first ?? "0") > 12 ? "PM" : "AM"}",
        enabled: false,
        key: UniqueKey(),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(_context!).nearestScope;
        },
        onSaved: (value) {},
        validator: (value) {},
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          //  helperText: "Should be after ${_viewModel.clinicInfoRequest.fromTime}",
          //  helperText: "Should be after ${formatTime(_viewModel.clinicInfoRequest.fromTime!.split(':').first)} : 00 ${int.parse(_viewModel.clinicInfoRequest.fromTime!.split(':').first??"0")>12?"PM":"AM"}",
          helperStyle: smallTextStyle.copyWith(color: baseColor),
          labelText: "From Time",
          suffixIcon: Icon(
            Icons.access_time,
            color: darkColor,
            size: 24,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _toTime() {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? initialTime = TimeOfDay.now();

        TimeOfDay? pickedTime = await showTimePicker(
          context: _context,
          initialTime: initialTime,
        ).then((value) {
          print(value.toString());
          _viewModel.schedulerInfoRequest.toTime =
              "${value!.hour}:${value!.minute}:00";
          _viewModel.reload();
        });
      },
      child: TextFormField(
        obscureText: false,
        enabled: false,
        // initialValue: _viewModel.schedulerInfoRequest.toTime??"",
        initialValue: _viewModel.schedulerInfoRequest.toTime == null
            ? ''
            : "${formatTime(_viewModel.schedulerInfoRequest.toTime!.split(':').first)} : ${_viewModel.schedulerInfoRequest.toTime!.split(':')[1]} ${int.parse(_viewModel.schedulerInfoRequest.toTime!.split(':').first ?? "0") > 12 ? "PM" : "AM"}",
        key: UniqueKey(),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(_context!).nearestScope;
        },
        onSaved: (value) {},
        validator: (value) {},
        onTap: () async {
          TimeOfDay? initialTime = TimeOfDay.now();
          TimeOfDay? pickedTime = await showTimePicker(
            context: _context,
            initialTime: initialTime,
          ).then((value) {
            print(value.toString());
          });
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: "To Time",
          //helperText: "Should be before ${_viewModel.clinicInfoRequest.toTime}",
          //  helperText: "Should be before  ${formatTime(_viewModel.clinicInfoRequest.toTime!.split(':').first)} : 00 ${int.parse(_viewModel.clinicInfoRequest.toTime!.split(':').first??"0")>12?"PM":"AM"}",
          helperStyle: smallTextStyle.copyWith(color: baseColor),
          suffixIcon: Icon(
            Icons.access_time,
            color: darkColor,
            size: 24,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

// Widget _dateContainer(String title) {
  //   return Container(
  //       child: Center(
  //         child: Text(
  //           title,
  //           style: TextStyle(color: Colors.blueAccent, fontSize: 18),
  //         ),
  //       ),
  //       margin: EdgeInsets.all(8),
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: Colors.blue),
  //       )
  //   );
  //
  // }
  // Widget _session(String title) {
  //   return Container(
  //     child: Center(
  //       child: Text(
  //         title,
  //         style: TextStyle(color: Colors.black, fontSize: 15),
  //       ),
  //     ),
  //     height: 40,
  //     width: 120,
  //     margin: EdgeInsets.all(10),
  //     padding: EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.lightBlueAccent),
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //   );
  // }
  // Widget _afternoon(String title) {
  //   return Container(
  //     child: Center(
  //       child: Text(
  //         title,
  //         style: TextStyle(color: Colors.black, fontSize: 15),
  //       ),
  //     ),
  //     height: 40,
  //     width: 120,
  //     margin: EdgeInsets.all(10),
  //     padding: EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.lightBlueAccent),
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //   );
  // }
  // Widget _slotduration() {
  //   return TextFormField(
  //     obscureText: false,
  //     textInputAction: TextInputAction.next,
  //     onFieldSubmitted: (v) {
  //       FocusScope.of(_context!).nearestScope;
  //     },
  //     onSaved: (value) {},
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return 'Enter Slot Time';
  //       }
  //     },
  //     style: mediumTextStyle,
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.all(10),
  //       labelStyle: textFieldsHintTextStyle,
  //       hintStyle: textFieldsHintTextStyle,
  //       labelText: slotduration,
  //       suffixIcon: Icon(
  //         Icons.timer,
  //         color: darkColor,
  //         size: 24,
  //       ),
  //       alignLabelWithHint: true,
  //     ),
  //   );
  // }
  //  Widget _consulation(String title) {
  //   return Container(
  //       child: Text(
  //         title,
  //         style: TextStyle(color: Colors.black, fontSize: 14),
  //       ),
  //     margin: EdgeInsets.all(8),
  //     padding: EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //   );
  // }
  // Widget _inclincfees() {
  //   return TextFormField(
  //     obscureText: false,
  //     textInputAction: TextInputAction.next,
  //     onFieldSubmitted: (v) {
  //       FocusScope.of(_context!).nearestScope;
  //     },
  //     onSaved: (value) {},
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return 'Enter InClinic Fees ';
  //       }
  //     },
  //     style: mediumTextStyle,
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.all(10),
  //       labelStyle: textFieldsHintTextStyle,
  //       hintStyle: textFieldsHintTextStyle,
  //        labelText: inclincfees,
  //       alignLabelWithHint: true,
  //     ),
  //   );
  // }

}
