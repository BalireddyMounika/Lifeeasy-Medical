import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/common_widgets/network_image_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/utils/time_formatting.dart';
import 'package:lifeeazy_medical/view/dashboard/widgets/dashboard_appbar.dart';
import 'package:lifeeazy_medical/view/dashboard/widgets/dashboard_drawer.dart';
import 'package:lifeeazy_medical/view/dashboard/widgets/dashboard_popup.dart';
import 'package:lifeeazy_medical/view/dashboard/widgets/location_search_widget.dart';
import 'package:lifeeazy_medical/viewmodel/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../net/session_manager.dart';

class DashBoardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashBoardView();
}

class _DashBoardView extends State<DashBoardView> {
  late BuildContext _context;
  List<charts.Series> _series = [];
  List<String> carouselItem = [
    "images/dashboard/banner.jpg",
    "images/dashboard/banner.jpg",
    "images/dashboard/banner.jpg"
  ];
  late DashBoardViewModel _viewModel;

  static List<charts.Series<OrdinalSales, dynamic>> _createSampleData() {
    final data = [
      new OrdinalSales(2021, 1000, charts.Color.fromHex(code: "#20ac9a")),
      new OrdinalSales(2022, 700, charts.Color.fromHex(code: "#fc0303")),
      new OrdinalSales(2023, 500, charts.Color.fromHex(code: "#fca503")),
      new OrdinalSales(2024, 100, charts.Color.fromHex(code: "#20ac9a")),
    ];

    return [
      new charts.Series<OrdinalSales, dynamic>(
        id: 'Sales',
        colorFn: (OrdinalSales sales, __) => sales.color,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_series = _createSampleData();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var instance = DashBoardViewModel();

      instance.getIsDoctorVerified().then((value) {
        if (value.isVerified == false) {
          showModalBottomSheet(
              context: context,
              elevation: 10,
              isDismissible: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              builder: (c) => UnderVerificationBottomWidget());
        }
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return ViewModelBuilder<DashBoardViewModel>.reactive(
      onViewModelReady: (model) {
        model.getAppointmentList();

        // Future.delayed(Duration(seconds: 3)).then((_) {
        //
        // });
      },
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return WillPopScope(
          onWillPop: () async => false,
          child: RefreshIndicator(
            onRefresh: () async {
              _viewModel.getAppointmentList();
            },
            child: Scaffold(
                appBar: DashBoardAppBar(
                  context,
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: baseColor,
                  onPressed: () {
                    Map maps = Map();
                    maps['url'] = 'http://partnerbot.vivifyhealthcare.com/';
                    maps['title'] = 'Lifeeazy Partner Companion';
                    Navigator.pushNamed(context, Routes.commonWebView,
                        arguments: maps);
                  },
                  child: Icon(
                    Icons.chat,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                drawer: DashBoardDrawer(),
                body: _body()),
          ),
        );
      },
      viewModelBuilder: () => DashBoardViewModel(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceMedium,
          _locationSearchContainer(),
          _upperOptions(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: verticalSpaceSmall,
          ),
          Text(
            "Active Appointments",
            style: bodyTextStyle.copyWith(color: Colors.grey),
          ),
          verticalSpaceTiny,
          _currentWidget()
        ],
      ),
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
        return _activeAppointments();

      case ViewState.Error:
        return EmptyListWidget("Nothing Found");
      case ViewState.Empty:
        return EmptyListWidget("Nothing Found");
      default:
        return _body();
    }
  }

  Widget _locationSearchContainer() {
    return Container(
      child: GestureDetector(
        onTap: () async {
          var data =
              await Navigator.of(context).push(new MaterialPageRoute<String>(
                  builder: (BuildContext context) {
                    return new LocationSearchWidget();
                  },
                  fullscreenDialog: true));
          _viewModel.updateLocation(data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 18,
                  color: baseColor,
                ),
                Text(
                  SessionManager.getLocation.city == null
                      ? " Your Location"
                      : '${SessionManager.getLocation.city}, ${SessionManager.getLocation.state}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: darkColor,
            )
          ],
        ),
      ),
    );
  }

  Widget _activeAppointments() {
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _viewModel.appointmentList.length,
          itemBuilder: (context, index) {
            return _newItemContainer(
                _viewModel.appointmentList.length - (index + 1));
          }),
    );
  }

  Widget _newItemContainer(index) {
    var image = "";
    if (_viewModel.appointmentList[index].userId?.profile == null) {
    } else {
      image = _viewModel.appointmentList[index].familyMemberId != null
          ? _viewModel.appointmentList[index].familyMemberId!.profilePicture
          : _viewModel.appointmentList[index].userId!.profile["ProfilePicture"];
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
                            ? "${_viewModel.appointmentList[index].familyMemberId!.firstname ?? ""}  ${_viewModel.appointmentList[index].familyMemberId?.lastname ?? ""}"
                            : "${_viewModel.appointmentList[index].userId?.firstName ?? ""}  ${_viewModel.appointmentList[index].userId?.lastName ?? ""}",
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      verticalSpace(3),
                      Text(
                        "${_viewModel.appointmentList[index].userId?.mobileNumber}",
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
                              "${formatTime(_viewModel.appointmentList[index].time!.split(":").first)} : ${_viewModel.appointmentList[index].time!.split(":")[1]} ${int.parse(_viewModel.appointmentList[index].time!.split(':').first) > 12 ? "PM" : "AM"}",
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
                  _viewModel.appointmentList[index].status == "CREATED"
                      ? GestureDetector(
                          onTap: () {
                            _viewModel.updateAppointmentStatus(
                                _viewModel.appointmentList[index].id ?? 0,
                                "ACCEPTED",
                                index);
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: baseColor),
                            child: Center(
                              child: Text(
                                "Accept",
                                style:
                                    bodyTextStyle.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: unSelectedColor)),
                          child: Center(
                            child: Text(
                              "Accepted",
                              style: bodyTextStyle.copyWith(
                                  color: unSelectedColor),
                            ),
                          ),
                        ),
                ],
              ),
              verticalSpaceTiny,
            ],
          ),
        ),
      ),
    );
  }

  Widget _upperOptions() {
    return Container(
      // height: 100,
      // width: 400,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TabButtonName(
              icon: Icons.calendar_today_outlined,
              name: 'Appointments',
              routes: Routes.getAppointmentView),
          TabButtonName(
              icon: Icons.receipt_long_outlined,
              name: 'Schedule',
              routes: Routes.scheduleView),
          TabButtonName(
              icon: Icons.local_hospital,
              name: 'Clinic ',
              routes: Routes.clinicView),
        ],
      ),
    );
  }
}

class OrdinalSales {
  final int year;
  final int sales;
  final charts.Color color;

  OrdinalSales(this.year, this.sales, this.color);
}

class TabButtonName extends StatelessWidget {
  final IconData icon;

  final String name;
  final String routes;

  const TabButtonName({
    required this.icon,
    required this.name,
    required this.routes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        locator<NavigationService>().navigateTo(routes);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 68,
          width: 82,
          // width: 20,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: baseColor,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: baseColor, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
