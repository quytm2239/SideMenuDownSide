import 'package:flutter/material.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

class NavigationCenter {
  BuildContext appContext;
  BuildContext currentContext;
  StatefulWidget currentScreen;

  void navigate(Widget newScreen, [bool fromAppContext = false]) {
    // if (currentContext == null) return;
    // Navigator.push(
    //   fromAppContext ? appContext : (currentContext ?? appContext),
    //   MaterialPageRoute(builder: (context) => newScreen),
    // );

    SideMenuHolder.shared.push(newScreen);
  }

  void back([bool fromAppContext = false]) {
    // if (fromAppContext) {
    //   Navigator.pop(appContext);
    // } else {
    //   Navigator.pop(currentContext);
    // }

    SideMenuHolder.shared.pop();
  }

// Singleton definition
  NavigationCenter._privateConstructor();
  static final NavigationCenter _instance = NavigationCenter._privateConstructor();
  static NavigationCenter get shared => _instance;
}
