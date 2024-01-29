import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';
import 'package:lifeeazy_medical/viewmodel/notification/notification_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NotificationAlertsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationAlertsView();
}

class _NotificationAlertsView extends State<NotificationAlertsView> {
  late BuildContext _context;
  late NotificationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      onViewModelReady: (model) => model.getNotificationInfo(),
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        _context = context;

        return Scaffold(
          appBar: CommonAppBar(
            title: "Notifications & Alerts",
            onBackPressed: () {
              Navigator.pop(context);
            },
            isClearButtonVisible: true,
            onClearPressed: () {
              locator<NavigationService>()
                  .navigateToAndRemoveUntil(Routes.dashboardView);
            },
          ),
          body: _currentWidget(),
        );
      },
      viewModelBuilder: () => NotificationViewModel(),
    );
  }

  Widget _body() {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Flexible(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _viewModel.notificationList.length,
              itemBuilder: (context, index) {
                return _iteamcontainer(
                    _viewModel.notificationList.length - (index + 1));
              }),
        ),
      ],
    ));
  }

  Widget _iteamcontainer(index) {
    return Card(
        child: Row(
      children: [
        SizedBox(
          height: 60,
          width: 40,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.baseColor,
            child: Center(
                child: Image.asset(
              "images/vector.png",
              cacheHeight: 25,
            )),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_viewModel.notificationList[index].title ?? ""}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6),
              Text(
                "${_viewModel.notificationList[index].body ?? ""}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                maxLines: 3,
              ),
              SizedBox(height: 6),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "${formatDate(_viewModel.notificationList[index].currentDate!.split("T").first)}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 12, vertical: 6));
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: _viewModel.loadingMsg,
        );

      case ViewState.Completed:
        return _body();

      case ViewState.Error:
        return const Center(
            child: Text(
          "Something went wrong",
          style: TextStyle(fontSize: 18),
        ));
      case ViewState.Empty:
        return EmptyListWidget("Nothing Found");

      default:
        return _body();
    }
  }
}
