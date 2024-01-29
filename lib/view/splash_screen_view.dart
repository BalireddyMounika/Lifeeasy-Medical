import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/authentication/location_response_model.dart';
import 'package:lifeeazy_medical/models/authentication/login_response_model.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/notification_service/notification_service.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';

class SplashScreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenStateView();
}

class _SplashScreenStateView extends State<SplashScreenView> {
  var _navigationService = locator<NavigationService>();
  var _prefs = locator<LocalStorageService>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize();

    listenNotification();

    getDeviceTokenToSendNotification();

    /// This method call when app in terminated state and you get a notification
    /// when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          LocalNotificationService.displayNotification(message);
          onClickNotification(message.data['navigator_route']);
        }
      },
    );

    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.displayNotification(message);
        }
      },
    );

    /// This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['navigator_route']}");
          onClickNotification(message.data['navigator_route']);
        }
      },
    );
    super.initState();

    Timer(Duration(seconds: 2), () {
      if (_prefs.isLoggedIn == true) {
        SessionManager.setUser = LoginResponseModel.fromJson(_prefs.userModel);
        SessionManager.profileImageUrl = _prefs.getProfileImage;
        if (_prefs.getLocation.isNotEmpty)
          SessionManager.setLocation =
              LocationResponseModel.fromJson(_prefs.getLocation);

        _navigationService
            .navigateToAndRemoveUntil(Routes.selectPartnerTypeView);
      } else
        _navigationService.navigateToAndRemoveUntil(Routes.introScreensView);
    });
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    print("Token Value : $token");
  }

  void listenNotification() {
    LocalNotificationService.onNotification.stream.listen(onClickNotification);
  }

  onClickNotification(data) {
    print('$data');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.all(0),
      child: Center(
        child: Image.asset(
          "images/lifeeazy.png",
          width: 150,
        ),
      ),
    );
  }
}
