import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';

import 'get_it/locator.dart';
import 'manager/dialog_manager.dart';
import 'net/session_manager.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

final GlobalKey<ScaffoldMessengerState> globalContextKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  String? token = await FirebaseMessaging.instance.getToken();
  SessionManager.fcmToken = token;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white70, // navigation bar color
    statusBarColor: Colors.white70, // status bar color
  ));
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: globalContextKey,
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: widget!,
          ),
        ),
      ),
      title: 'Lifeeazy Partner',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        primaryColor: AppColors.baseColor,
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: AppColors.baseMaterialColor),
      ),
      initialRoute: '/',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Routes.generateRouter,
    );
  }
}
