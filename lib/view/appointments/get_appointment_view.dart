import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/viewmodel/appointment/appointment_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'widgets/appointment_list_widget.dart';

class GetAppointmentsView extends StatelessWidget {
  late AppointmentsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentsViewModel>.reactive(
      onModelReady: (model) => model.getAppointmentList(),
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CommonAppBar(
              title: "Appointments",
              onBackPressed: () {
                locator<NavigationService>()
                    .navigateToAndRemoveUntil(Routes.dashboardView);
              },
              isClearButtonVisible: true,
              onClearPressed: () {
                locator<NavigationService>()
                    .navigateToAndRemoveUntil(Routes.dashboardView);
              },
              // isClearButtonVisible: true,
              // onBackPressed: () {
              //   locator<NavigationService>()
              //       .navigateToAndRemoveUntil(Routes.dashboardView);
              // },
            ),
            body: _currentWidget());
      },
      viewModelBuilder: () => AppointmentsViewModel(),
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
    return Container(
        margin: dashBoardMargin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SearchView(),
            _filterWidget(),
            verticalSpaceMedium,
            _viewModel.appointmentList.length == 0
                ? EmptyListWidget("Nothing Found")
                : Flexible(
                    child: AppointmentListWidget(),
                  ),
          ],
        ));
  }

  Widget _popupMenu() {
    return PopupMenuButton(
      icon: Icon(
        Icons.arrow_drop_down,
        color: baseColor,
        size: 24,
      ),
      onSelected: (dynamic value) {
        _viewModel.filterAppointment(value);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: "All",
          child: Text("ALL"),
        ),
        PopupMenuItem<String>(
          value: "CREATED",
          child: Text("CREATED"),
        ),
        PopupMenuItem<String>(
          value: "ACCEPTED",
          child: Text("ACCEPTED"),
        ),
        PopupMenuItem<String>(
          value: "CONFIRMED",
          child: Text("CONFIRMED"),
        ),
      ],
    );
  }

  Widget _filterWidget() {
    return Container(
      height: kToolbarHeight - 10,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  _viewModel.selectedFilterValue,
                  style: mediumTextStyle,
                ),
              )),
          Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: _popupMenu(),
              )),
        ],
      ),
    );
  }
}

extension something on DateTime {
  static String formatDate(String date) {
    var parsedDate = DateTime.parse(date);
    //var formattedDate =  DateFormat('dd-MM-yyyy').format(parsedDate);
    var month = parsedDate.month;
    var currentMonth = monthsList[month - 1];

    return "${parsedDate.day.toString()} $currentMonth ${parsedDate.year.toString()}";
  }
}
