import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/enums/appointment_status.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/colors.dart';
import '../../../constants/margins.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';
import '../../../constants/ui_helpers.dart';
import '../../../get_it/locator.dart';
import '../../../routes/route.dart';
import '../../../services/common_service/navigation_service.dart';
import '../../../utils/date_formatting.dart';
import '../../../utils/time_formatting.dart';
import '../../../viewmodel/appointment/appointment_viewmodel.dart';

class AppointmentListWidget extends ViewModelWidget<AppointmentsViewModel> {
  AppointmentListWidget({Key? key}) : super(key: key, reactive: true);
  late AppointmentsViewModel _viewModel;
  @override
  Widget build(BuildContext context, AppointmentsViewModel _viewModel) {
    this._viewModel = _viewModel;
    return ListView.builder(
        itemCount: _viewModel.appointmentList.length,
        itemBuilder: (context, index) {
          return _newItemContainer(
              _viewModel.appointmentList.length - (index + 1));
        });
  }

  Widget _itemContainer(index) {
    var image = "";
    if (_viewModel.appointmentList[index].userId?.profile == null) {
    } else {
      image = _viewModel.appointmentList[index].familyMemberId != null
          ? _viewModel.appointmentList[index].familyMemberId?.profilePicture
          : _viewModel.appointmentList[index].userId?.profile["ProfilePicture"];
    }
    return Container(
      child: Card(
        elevation: standardCardElevation,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                          foregroundImage:
                              // Image.asset("images/dashboard/profile_dummy.png")
                              //     .image,
                              image == ""
                                  ? Image.asset(
                                          "images/dashboard/profile_dummy.png")
                                      .image
                                  : Image.network(image).image),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _viewModel.appointmentList[index]
                                          .familyMemberId !=
                                      null
                                  ? "${_viewModel.appointmentList[index].familyMemberId!.firstname ?? ""}  ${_viewModel.appointmentList[index].familyMemberId!.lastname ?? ""}"
                                  : "${_viewModel.appointmentList[index].userId!.firstName ?? ""}  ${_viewModel.appointmentList[index].userId!.lastName ?? ""}",
                              style: mediumTextStyle,
                            ),
                            // Text('${_viewModel.appointmentList[index].date}')
                            Text(
                                "${formatDate(_viewModel.appointmentList[index].date ?? "")}"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_viewModel.appointmentList[index].userId!.mobileNumber}",
                              style: bodyTextStyle.copyWith(color: darkColor),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                "${formatTime(_viewModel.appointmentList[index].time!.split(":").first)} : 00 ${int.parse(_viewModel.appointmentList[index].time!.split(':').first ?? "0") > 12 ? "PM" : "AM"}"),
                          ],
                          // Text(
                          //   "${_viewModel.appointmentList[index].userId!.mobileNumber}",
                          //   style: bodyTextStyle.copyWith(color: darkColor),
                          // ),
                        ),
                        Visibility(
                          visible: true,
                          child: Text(
                            "${_viewModel.appointmentList[index].userId!.email ?? ""}",
                            style: bodyTextStyle.copyWith(color: darkColor),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _viewModel.appointmentList[index].appointmentType ??
                              "",
                          style: mediumTextStyle.copyWith(color: baseColor),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                color: darkColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: true,
                    child: GestureDetector(
                      onTap: () {
                        var maps = Map();
                        maps['appointmentResponse'] =
                            _viewModel.appointmentList[index];
                        locator<NavigationService>().navigateTo(
                            Routes.appointmentDetailView,
                            arguments: maps);
                      },
                      child: Text(
                        viewDetails,
                        style: bodyTextStyle.copyWith(color: darkColor),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_viewModel.appointmentList[index].status ==
                          appointmentStatus.CREATED.toString().split('.').last)
                        _viewModel.updateAppointmentStatus(
                            _viewModel.appointmentList[index].id ?? 0,
                            appointmentStatus.ACCEPTED
                                .toString()
                                .split('.')
                                .last);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: _viewModel.appointmentList[index].status ==
                                  appointmentStatus.CREATED
                                      .toString()
                                      .split('.')
                                      .last
                              ? baseColor
                              : _viewModel.appointmentList[index].status ==
                                      appointmentStatus.ACCEPTED
                                          .toString()
                                          .split('.')
                                          .last
                                  ? Colors.orange
                                  : Colors.blueAccent,
                          borderRadius:
                              BorderRadius.circular(standardBorderRadius)),
                      child: Center(
                        child: Text(
                          _viewModel.appointmentList[index].status ==
                                  appointmentStatus.CREATED
                                      .toString()
                                      .split('.')
                                      .last
                              ? "Accept"
                              : _viewModel.appointmentList[index].status ?? "",
                          style: bodyTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _newItemContainer(index) {
    var image = "";
    if (_viewModel.appointmentList[index].userId?.profile == null) {
    } else {
      image = _viewModel.appointmentList[index].familyMemberId != null
          ? _viewModel.appointmentList[index].familyMemberId?.profilePicture
          : _viewModel.appointmentList[index].userId?.profile["ProfilePicture"];
    }
    return Container(
      child: Card(
        elevation: 2,
        shadowColor: Colors.white30,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _viewModel.appointmentList[index].familyMemberId != null
                            ? "${_viewModel.appointmentList[index].familyMemberId?.firstname ?? ""}  ${_viewModel.appointmentList[index].familyMemberId?.lastname ?? ""}"
                            : "${_viewModel.appointmentList[index].userId?.firstName ?? ""}  ${_viewModel.appointmentList[index].userId?.lastName ?? ""}",
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      verticalSpace(3),
                      Text(
                        "${_viewModel.appointmentList[index].userId?.mobileNumber ?? ""}",
                        style: smallTextStyle.copyWith(color: darkColor),
                      ),
                      // Text(
                      //   "${_viewModel.appointmentList[index].userId!.email ?? ""}",
                      //   style: smallTextStyle.copyWith(color: darkColor),
                      // ),
                    ],
                  ),
                  Container(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: image == ""
                            ? Image.asset("images/dashboard/doctor.png")
                            : NetworkImageWidget(
                                imageName: image, width: 50, height: 50),
                      )),
                ],
              ),
              verticalSpace(3),
              Divider(
                color: disableColor,
              ),
              verticalSpace(3),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: disableColor,
                          ),
                          horizontalSpace(3),
                          Text(
                            "${formatDate(_viewModel.appointmentList[index].date ?? "")}",
                            style: smallTextStyle.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm,
                            size: 14,
                            color: disableColor,
                          ),
                          horizontalSpace(3),
                          Text(
                              "${formatTime(_viewModel.appointmentList[index].time!.split(":").first)} : ${_viewModel.appointmentList[index].time!.split(":")[1]} ${int.parse(_viewModel.appointmentList[index].time!.split(':').first ?? "0") > 12 ? "PM" : "AM"}",
                              style: smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.orange,
                          ),
                          horizontalSpace(3),
                          Text(
                              _viewModel
                                      .appointmentList[index].appointmentType ??
                                  "",
                              style: smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      var maps = Map();
                      maps['appointmentResponse'] =
                          _viewModel.appointmentList[index];
                      locator<NavigationService>().navigateTo(
                          Routes.appointmentDetailView,
                          arguments: maps);
                    },
                    child: Container(
                      width: 100,
                      child: Text(
                        "View Details",
                        style: bodyTextStyle.copyWith(color: baseColor),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_viewModel.appointmentList[index].status ==
                          appointmentStatus.CREATED.toString().split('.').last)
                        _viewModel.updateAppointmentStatus(
                            _viewModel.appointmentList[index].id ?? 0,
                            appointmentStatus.ACCEPTED
                                .toString()
                                .split('.')
                                .last);
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: _viewModel.appointmentList[index].status ==
                                  appointmentStatus.CREATED
                                      .toString()
                                      .split('.')
                                      .last
                              ? baseColor
                              : _viewModel.appointmentList[index].status ==
                                      appointmentStatus.ACCEPTED
                                          .toString()
                                          .split('.')
                                          .last
                                  ? Colors.orange
                                  : Colors.blueAccent,
                          borderRadius:
                              BorderRadius.circular(standardBorderRadius)),
                      child: Center(
                        child: Text(
                          _viewModel.appointmentList[index].status ==
                                  appointmentStatus.CREATED
                                      .toString()
                                      .split('.')
                                      .last
                              ? "Accept"
                              : _viewModel.appointmentList[index].status ?? "",
                          style: bodyTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              verticalSpaceTiny,
            ],
          ),
        ),
      ),
    );
  }
}
