import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/common_widgets/profile_image_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DashBoardDrawer extends ViewModelWidget<DashBoardViewModel> {
  @override
  Widget build(BuildContext context, DashBoardViewModel viewModel) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: Container(
                  decoration: BoxDecoration(
                      color: baseColor,
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.5))),
                  height: 200,
                  child: Center(
                      child: ListTile(
                    leading: GestureDetector(
                        onTap: () {
                          locator<NavigationService>()
                              .navigateTo(Routes.profileView);
                        },
                        child: ProfileImageWidget(
                          circleSize: 40,
                        )),
                    title: Text(
                      "${SessionManager.getUser.firstName}  ${SessionManager.getUser.lastName}",
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      "${SessionManager.getUser.mobileNumber ?? ""}",
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                  )))),

          DrawerMenu(
              label: myProfile, icon: Icons.person, routes: Routes.profileView),
          // DrawerMenu(label:"Prescriptions", icon: Icons.add_chart_sharp,
          //     routes: Routes.prescriptionView),
          DrawerMenu(
              label: bankDetails,
              icon: Icons.account_balance,
              routes: Routes.addBankDetailView),
          // DrawerMenu(label:'select business', icon:Icons.food_bank_rounded,routes: Routes.selectBusiness),
          DrawerMenu(
              label: "Change Password",
              icon: Icons.lock,
              routes: Routes.resetPasswordView),
          //  DrawerMenu(label:"Add Signature", icon: Icons.edit ,routes:Routes.addSignatureView),

          DrawerMenu(
            label: "Home",
            icon: Icons.logout,
            routes: Routes.selectPartnerTypeView,
          ),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final String label;
  final IconData icon;
  final String routes;
  const DrawerMenu({
    required this.icon,
    required this.label,
    required this.routes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: baseColor),
      title: new Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      onTap: () {
        if (label == "Log Out") {
          locator<LocalStorageService>().setIsLogIn(false);
          showDialog(
              context: context,
              builder: (context) => PopUpDialog(
                    dialogType: DialogType.WarningDialog,
                    title: "Are you sure you want to Log Out",
                    buttonText: "Yes",
                    isStackCleared: true,
                    isCancelButtonVisible: true,
                    routes: Routes.loginView,
                  ));
        } else
          locator<NavigationService>().navigateTo(routes);
      },
    );
  }
}
