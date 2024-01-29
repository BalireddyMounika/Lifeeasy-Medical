

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';

class SettingsView extends StatelessWidget {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    return Scaffold(
      appBar: CommonAppBar(
        title: myProfile,
        isClearButtonVisible: false,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: profileMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              //_itemContainer("Add Profile", Icons.person,routes: Routes.addprofileView),
              _itemContainer(myProfile, Icons.person,
                  routes: Routes.profileView),
              _itemContainer("Prescriptions", Icons.add_chart_sharp,
                  routes: Routes.prescriptionView),
              //  _itemContainer("ListNotes", Icons.book_online,routes: Routes.addNoteListView),
               _itemContainer(bankDetails, Icons.food_bank_rounded,routes: Routes.addBankDetailView),
              // _itemContainer("Add Scheduler", Icons.food_bank_outlined,routes: Routes.schedulerView),
              // _itemContainer("Add Clinic", Icons.dynamic_feed,routes: Routes.clinicView),
              // _itemContainer("Prescription",Icons.add_chart_sharp,routes: Routes.prescriptionView),
              // _itemContainer(" View Appointment", Icons.dynamic_feed,routes: Routes.AppointmentRescheduleView),
              // _itemContainer("Patient Records", Icons.book,routes: Routes.PatientRecordsView),
              _itemContainer(logOut, Icons.logout),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemContainer(label, icon, {routes}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          if (label == "Log Out") {
            locator<LocalStorageService>().setIsLogIn(false);
            showDialog(
                context: _context,
                builder: (context) => PopUpDialog(
                      dialogType: DialogType.WarningDialog,
                      title: "Are You Sure You Want To Log Out",
                     buttonText: "Yes",
                      //button: "No",
                      isStackCleared: true,
                      routes: Routes.loginView,
                    ));
          } else
             Navigator.pushNamed(_context, routes);
        },
        child: Card(
          elevation: standardCardElevation,
          shadowColor: Colors.white70,
          child: Container(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      icon,
                      color: baseColor,
                      size: 24,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      label,
                      style: mediumTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
