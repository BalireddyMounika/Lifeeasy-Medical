import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/manager/string_extention.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/dashboard/dashboard_viewmodel.dart';
import 'package:lifeeazy_medical/viewmodel/pharmacy/pharmacy_dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../common_widgets/empty_list_widget.dart';
import '../../common_widgets/loader.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../routes/route.dart';
import '../../utils/date_formatting.dart';

class PharmacyDashBoardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PharmacyDashBaordView();
}

class _PharmacyDashBaordView extends State<PharmacyDashBoardView> {
  final textColor = Color(0xff9B9B9B);
  late PharmacyDashBoardViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PharmacyDashBoardViewModel>.reactive(
        onViewModelReady: (model) {
          model.getPharmacyOrders();
        },
        viewModelBuilder: () => PharmacyDashBoardViewModel(),
        builder: (context, viewModel, child) {
          _viewModel = viewModel;
          return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: _bottomNavigationBar(),
            body: RefreshIndicator(
                onRefresh: () async {
                  _viewModel.getPharmacyOrders();
                },
                child: _body()),
          );
        });
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
      child: Column(
        children: [
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  horizontalSpaceSmall,
                  CircleAvatar(
                    backgroundImage:
                        Image.asset("images/dashboard/profile_dummy.png").image,
                  ),
                  horizontalSpaceSmall,
                  Text(
                    "My Pharmacy",
                    style:
                        mediumTextStyle.copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {
                    locator<NavigationService>()
                        .navigateTo(Routes.selectPartnerTypeView);
                  },
                  child: Icon(
                    Icons.logout,
                    size: 24,
                    color: baseColor,
                  ))
            ],
          ),
          verticalSpaceSmall,
          _currentWidget()
        ],
      ),
    );
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: "Fetching Orders",
          loadingMsgColor: Colors.black,
        );
      case ViewState.Empty:
        return EmptyListWidget("Nothing Found");
      case ViewState.Completed:
        return Flexible(
            child: ListView.builder(
                itemCount: _viewModel.pharmacyOrderList.length,
                itemBuilder: (context, index) {
                  return _itemContainer(
                      _viewModel.pharmacyOrderList.length - (index + 1));
                }));

      case ViewState.Error:
        return Center(
            child: Text(
          somethingWentWrong,
          style: mediumTextStyle,
        ));

      default:
        return Flexible(
            child: ListView.builder(
                reverse: true,
                itemCount: _viewModel.pharmacyOrderList.length,
                itemBuilder: (context, index) {
                  return _itemContainer(index);
                }));
    }
  }

  Widget _itemContainer(index) {
    var data = _viewModel.pharmacyOrderList[index];
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0xffF8F8F6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.username ?? "",
                  style: mediumTextStyle.copyWith(
                      color: Color(0xff0A0909), fontWeight: FontWeight.w500)),
              Visibility(
                visible: data.orderStatus == "confirmed" ? true : false,
                child: GestureDetector(
                  onTap: () {
                    _viewModel.updatePharmacyOrder(data);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: baseColor),
                    height: 30,
                    width: 120,
                    child: Center(
                      child: Text(
                        "Tap If Delivered",
                        style: bodyTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(formatDate(data.deliveredDate ?? ""),
              style: smallTextStyle.copyWith(color: textColor)),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                size: 16,
                color: textColor,
              ),
              horizontalSpaceSmall,
              Flexible(
                  child: Text(
                data.userAddress ?? "",
                style: bodyTextStyle.copyWith(color: textColor),
              ))
            ],
          ),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: textColor,
              ),
              horizontalSpaceSmall,
              Text(
                "+91 ${data.userPhoneNumber}",
                style: smallTextStyle.copyWith(color: textColor),
              )
            ],
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Map map = new Map();
                  map['pharmacyOrderResponse'] = data;
                  locator<NavigationService>().navigateTo(
                      Routes.pharmacyOrderDetailView,
                      arguments: map);
                },
                child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      "View Details",
                      style: bodyTextStyle.copyWith(
                          color: baseColor, fontWeight: FontWeight.w500),
                    )),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: redColor)),
                child: Center(
                    child: Text(
                  data.orderStatus?.capitalize() ?? "",
                  style: smallTextStyle.copyWith(color: redColor),
                )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        selectedItemColor: baseColor,
        unselectedItemColor: unSelectedColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services,
            ),
            label: "My Pharmacy",
          ),
        ]);
  }

  onTabTapped(int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(context, Routes.myPharmacyView);
        break;

      default:
        print('choose a different choice');
    }

    // setState(() {
    //   _currentIndex = index;
    //   if (_currentIndex == 2) {
    //     Navigator.pushNamed(context, Routes.settingsView);
    //   } else {
    //     if (_currentIndex == 1) {
    //       Navigator.pushNamed(context, Routes.appointmentHistoryView);
    //     }
    //   }
    // }
  }
}
