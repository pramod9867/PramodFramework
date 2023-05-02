import 'package:flutter/cupertino.dart';

class NavigationService {

  static NavigationService navigationService =NavigationService();

  GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {


    print("Into the ROute Name");

    print(navigatorKey.currentState);
    return  navigatorKey.currentState!.pushNamedAndRemoveUntil(
        "/login", (Route<dynamic> route) => false);
  }


}