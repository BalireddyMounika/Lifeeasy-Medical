import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/appointment_status.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/utils/time_formatting.dart';
import 'package:lifeeazy_medical/viewmodel/appointment/appointment_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AppointmentDetailView extends StatefulWidget {
  GetAppointmentResponse appointmentResponse;

  AppointmentDetailView(this.appointmentResponse);
  @override
  State<StatefulWidget> createState() => _AppointmentDetailView();
}

class _AppointmentDetailView extends State<AppointmentDetailView> {
  late AppointmentsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentsViewModel>.reactive(
        viewModelBuilder: () => AppointmentsViewModel(),
        onModelReady: (e) {
          if (widget.appointmentResponse.appointmentType ==
              'Teleconsultation') {
            if (widget.appointmentResponse.status != 'CREATED') {
              e.getScheduleCallStatusList(widget.appointmentResponse.id ?? 0);
            }
          }
        },
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          return Scaffold(
            appBar: CommonAppBar(
              title: "Appointment Details",
              isClearButtonVisible: true,
              onBackPressed: () {
                Navigator.pop(context);
              },
              onClearPressed: () {
                locator<NavigationService>()
                    .navigateToAndRemoveUntil(Routes.dashboardView);
              },
            ),
            body: _currentWidget(),
            bottomSheet: widget.appointmentResponse.status ==
                    appointmentStatus.CONFIRMED.toString().split('.').last
                ? _viewPrescriptionContainer()
                : Container(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (widget.appointmentResponse.status ==
                                      appointmentStatus.CREATED
                                          .toString()
                                          .split('.')
                                          .last ||
                                  widget.appointmentResponse.status ==
                                      appointmentStatus.CONFIRMED
                                          .toString()
                                          .split('.')
                                          .last) {
                              } else {
                                if (widget.appointmentResponse
                                            .appointmentType ==
                                        'Teleconsultation' &&
                                    _viewModel.scheduleCallStatusList.length >=
                                        1) {
                                  var maps = Map();
                                  maps['appointmentResponse'] =
                                      widget.appointmentResponse;

                                  locator<NavigationService>().navigateTo(
                                      Routes.addEditPrescriptionView,
                                      arguments: maps);
                                } else if (widget
                                        .appointmentResponse.appointmentType !=
                                    'Teleconsultation') {
                                  var maps = Map();
                                  maps['appointmentResponse'] =
                                      widget.appointmentResponse;

                                  locator<NavigationService>().navigateTo(
                                      Routes.addEditPrescriptionView,
                                      arguments: maps);
                                }
                              }
                            },
                            child: Container(
                              color: widget.appointmentResponse.status ==
                                          appointmentStatus.CREATED
                                              .toString()
                                              .split('.')
                                              .last ||
                                      widget.appointmentResponse.status ==
                                          appointmentStatus.CONFIRMED
                                              .toString()
                                              .split('.')
                                              .last
                                  ? Colors.grey
                                  : widget.appointmentResponse
                                                  .appointmentType ==
                                              'Teleconsultation' &&
                                          _viewModel.scheduleCallStatusList
                                                  .length ==
                                              0
                                      ? Colors.grey
                                      : baseColor,
                              child: Center(
                                child: Text(
                                  "Add Prescription",
                                  style: bodyTextStyle.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       var maps = Map();
                        //       maps['appointmentResponse'] =
                        //           widget.appointmentResponse;
                        //
                        //       locator<NavigationService>()
                        //           .navigateTo(Routes.addNoteView, arguments: maps);
                        //     },
                        //     child: Container(
                        //       color: Colors.white60,
                        //       child: Center(
                        //         child: Text(
                        //           "Add Notes",
                        //           style: bodyTextStyle.copyWith(color: baseColor),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget _viewPrescriptionContainer() {
    return ButtonContainer(
      buttonText: "View Prescription",
      onPressed: () {
        Map map = new Map();
        map["appointmentId"] = widget.appointmentResponse.id;

        locator<NavigationService>()
            .navigateTo(Routes.prescriptionView, arguments: map);
      },
    );
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

      case ViewState.Empty:
        return Center(child: Text("Empty"));
      case ViewState.Error:
        return Center(child: Text("Error"));
      default:
        return _body();
    }
  }

  String getDuration() {
    if (int.parse(_viewModel.scheduleCallStatusList.first.duration ?? "0") >
        60) {
      var min =
          (int.parse(_viewModel.scheduleCallStatusList.first.duration ?? "0") ~/
                  60)
              .toInt();
      var sec =
          (int.parse(_viewModel.scheduleCallStatusList.first.duration ?? "0") %
                  60)
              .toInt();
      return "${min.toString()} min ${sec.toString()} sec";
    }

    return "${_viewModel.scheduleCallStatusList.first.duration} sec";
  }

  Widget _body() {
    var image = "";
    if (widget.appointmentResponse.userId?.profile == null) {
    } else {
      image = widget.appointmentResponse.familyMemberId != null
          ? widget.appointmentResponse.familyMemberId?.profilePicture
          : widget.appointmentResponse.userId?.profile["ProfilePicture"];
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 40.0,
                  width: 200,
                  margin: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Status : ${widget.appointmentResponse.status}",
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: redColor,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Patient Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipOval(
                            child: image == ""
                                ? Image.asset("images/dashboard/doctor")
                                : NetworkImageWidget(
                                    imageName: image, width: 60, height: 60))),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              _details(
                  "First Name",
                  widget.appointmentResponse.familyMemberId != null
                      ? widget.appointmentResponse.familyMemberId?.firstname ??
                          ""
                      : widget.appointmentResponse.userId?.firstName ?? ""),
              _details(
                  "Last Name",
                  widget.appointmentResponse.familyMemberId != null
                      ? widget.appointmentResponse.familyMemberId?.lastname ??
                          ""
                      : widget.appointmentResponse.userId?.lastName ?? ""),
              _details(
                  "Email",
                  widget.appointmentResponse.familyMemberId != null
                      ? widget.appointmentResponse.familyMemberId?.email ?? ""
                      : widget.appointmentResponse.userId?.email ?? ""),

              _details("Phone Number",
                  widget.appointmentResponse.userId?.mobileNumber ?? ""),
              _details("Symptoms",
                  widget.appointmentResponse.symptoms['Symptom'] ?? ""),
              _details("Comments",
                  widget.appointmentResponse.symptoms['comments'] ?? ""),
              verticalSpaceMedium,
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(4),
                child: Text(
                  " Appointment Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),

              // _details("Date", widget.appointmentResponse.date ?? ""),
              _details("Date",
                  "${formatDate(widget.appointmentResponse.date ?? "")}"),
              _details(
                "Time",
                "${formatTime(widget.appointmentResponse.time!.split(':').first)} : ${widget.appointmentResponse.time!.split(":")[1]} ${int.parse(widget.appointmentResponse.time!.split(':').first ?? "0") > 12 ? "PM" : "AM"}",
              ),
              _details("Appointment Type",
                  widget.appointmentResponse.appointmentType ?? ""),
              _details("Appointment Charges",
                  widget.appointmentResponse.fees.toString() ?? ""),
              verticalSpaceMedium,

              Visibility(
                visible: widget.appointmentResponse.appointmentType ==
                            'Teleconsultation' &&
                        _viewModel.scheduleCallStatusList.length >= 1
                    ? true
                    : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "Teleconsultation",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),

                    _details('Date',
                        "${_viewModel.scheduleCallStatusList.length >= 1 ? formatDate(_viewModel.scheduleCallStatusList.first.createdDate.toString().split(' ').first) : ''}"),
                    //_details('Date',"${formatDate(_viewModel.scheduleCallStatusList.length>=1?_viewModel.scheduleCallStatusList.first.createdDate.toString().split(' ').first:'')}"),
                    _details('Duration',
                        "${_viewModel.scheduleCallStatusList.length >= 1 ? getDuration() : ""}"),
                    _details(
                        'Status',
                        _viewModel.scheduleCallStatusList.length >= 1
                            ? _viewModel.scheduleCallStatusList.first.status
                                .toString()
                            : ''),
                  ],
                ),
              ),

              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: widget.appointmentResponse.appointmentType ==
                                'Teleconsultation' &&
                            widget.appointmentResponse.status != "CONFIRMED"
                        ? _viewModel.scheduleCallStatusList.length == 0
                            ? true
                            : false
                        : false,
                    child: GestureDetector(
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color:
                                  widget.appointmentResponse.status == 'CREATED'
                                      ? disableBtnColor
                                      : baseColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: widget.appointmentResponse.status ==
                                            'CREATED'
                                        ? disableBtnColor
                                        : baseColor,
                                    offset: const Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(-4, -4),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                              ]),
                          child: Icon(
                            Icons.videocam,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          if (widget.appointmentResponse.status != 'CREATED') {
                            var maps = Map();
                            maps['userId'] = widget.appointmentResponse.userId?.id;
                            maps['appointmentId'] = widget.appointmentResponse.id;
                            locator<NavigationService>().navigateTo(
                                Routes.videocallView,
                                arguments: maps);
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   margin:  EdgeInsets.all(4),
    //   padding: EdgeInsets.all(4),
    //   child: Text("Doctor Details"),
    // );
  }

  RichText statusDetails(String name, String value) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: name, style: bodyTextStyle.copyWith(color: Colors.grey)),
          TextSpan(
              text: value,
              style: mediumTextStyle.copyWith(color: Colors.black)),
        ],
      ),
      // Text(
      //   title,
      //   style: TextStyle(fontWeight: FontWeight.normal),
      // ),
    );
  }

  Widget _details(String title, String data) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Text('$title : ', style: TextStyle(fontWeight: FontWeight.w500),),
            Text(data , maxLines: 2,)
          ],
        ),
      ),
      margin: EdgeInsets.all(8),
    );
  }
}
