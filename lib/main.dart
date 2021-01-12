import 'package:flutter/material.dart';
import 'package:side_menu_down_side/navigation_center.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_down_side.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// You can setup your [SideMenuContent]'s item at here
    /// Required at least 1 item
    /// call this: SideMenuHolder.shared.makeMenuItem([]);

    // Update appContext for later usage
    NavigationCenter.shared.appContext = context;
    return MaterialApp(
      title: 'SideMenu DownSide',
      theme: ThemeData(
        //
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SideMenuDownSide(),
    );
  }
}
