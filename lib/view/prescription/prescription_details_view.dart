import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/prescription/get_prescription_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/utils/date_formatting.dart';

class PrescriptionDetailsView extends StatelessWidget {
  BuildContext? _context;

  GetPrescriptionResponse prescription = GetPrescriptionResponse();

  PrescriptionDetailsView(this.prescription);

  @override
  Widget build(BuildContext context) {
    // TODO: implement builds
    return Scaffold(
        appBar: CommonAppBar(
          title: " Prescription Details",
          onBackPressed: () {
            Navigator.pop(context);
          },
          isClearButtonVisible: true,
          onClearPressed: () {
            locator<NavigationService>()
                .navigateToAndRemoveUntil(Routes.dashboardView);
          },
        ),
        body: _body());
  }

  Widget _body() {

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topView(),
            // Container(
            //   child: Text("Dr.Name : Raghu",style: TextStyle(color:Colors.blue,fontSize: 15),),
            //
            //
            //
            // ),
            Divider(
              color: Colors.grey,
            ),
            verticalSpaceMedium,
            Text(
              "Patient Details",
              style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),

            verticalSpaceSmall,
            _details("First Name ", prescription.userId!.firstname ?? ""),
            _details(
              "Last Name",
              prescription.userId!.firstname ?? "",
            ),
            _details("Mobile", prescription.userId!.mobileNumber ?? ""),
            _details("Email", prescription.userId!.email ?? ""),
            verticalSpaceMedium,
            Divider(
              color: Colors.black,
            ),
            verticalSpaceMedium,
            Text(
              "Medication Details",
              style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalSpaceSmall,
            _details("Drug Name", prescription.drugName ?? ""),
            _details("Quantity", prescription.quantity.toString() ?? ""),
            _details("Dosages", prescription.dosages ?? ""),
            _details("Frequency", prescription.frequency.toString() ?? ""),
            _details("Route", prescription.route ?? ""),
            _details("Instruction", prescription.instructions ?? ""),
            // _details(
            //     "Next Follow Up Date", prescription.nextFollowUpDate ?? ""),
            _details("Next Follow Up", "${formatDate(prescription.nextFollowUpDate??"")}",)
          ],
        ),
      ),
    );
  }
  Widget _topView() {
    var image =  prescription.userId!.profile["ProfilePicture"];

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(
              height: 100,
              width: 60,
              child: CircleAvatar(
                  foregroundImage:
                  image == ""? Image.asset("images/dashboard/profile_dummy.png").image:Image.network(image).image
                // backgroundColor: Colors.white,
                // child: Image.asset("images/dashboard/profile_dummy.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              // child: Row(
              //      children: [
              //    Text("Dr.Name:"),
              //    Text("Raghu", style: const TextStyle(color:Colors.blue,fontWeight: FontWeight.bold))
              //  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${SessionManager.getUser.firstName ?? ""} ${SessionManager.getUser.lastName ?? ""} ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Mobile : ${SessionManager.getUser.mobileNumber ?? ""}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    " Email: ${SessionManager.getUser.email ?? ""}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              // child: Text(
              //   "Dr.Name",
              //   style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold),
              // ),
            ),
          ]),
        ]);
  }
}



Widget _details(String title, String data) {
  return Container(
    child: Center(
      child: Row(
        children: [
          Column(children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: "$title : ",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  TextSpan(
                      text: data,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
              // Text(
              //   title,
              //   style: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold),
            ),
          ]),
        ],
      ),
    ),
    margin: EdgeInsets.all(4),
  );
}

Widget _data(String title, String data) {
  return Container(
    child: Center(
      child: Row(
        children: [
          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "$title  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    TextSpan(text: data, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              // Text(
              //   title,
              //   style: TextStyle(
              //     color: Colors.grey,
              //     fontSize: 15,fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    ),
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.all(1),
  );
}
