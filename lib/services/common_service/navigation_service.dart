import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>(); 

  Future<dynamic> navigateTo(String routeName, {arguments, routes}) {
    return navigatorKey.currentState!.pushNamed(routeName,arguments: arguments);
  }

  Future<dynamic> navigateToAndRemoveUntil(String routeName,{arguments, routes}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (routes) => false,arguments: arguments);
  }

  void goBack() {
    if(navigatorKey.currentState!.canPop())
      return navigatorKey.currentState!.pop();
  }
}
