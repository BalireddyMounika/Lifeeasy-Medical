import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';

class UnderVerificationBottomWidget extends StatelessWidget {
  const UnderVerificationBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        margin: EdgeInsets.only(top: 0),
        height: 270,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "Your profile is under review",
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                    Text(
                      "we are verifying once it is done",
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                    Text(
                      "we will notify you",
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Click help center for more details.",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Map maps = Map();
                  maps['url'] =
                      "https://vivifyhealthcare.atlassian.net/servicedesk/customer/portal/5/group/-1";
                  maps['title'] = "Help Center";
                  locator<NavigationService>()
                      .navigateTo(Routes.commonWebView, arguments: maps);
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color(0xff32a887),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Help Center",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
