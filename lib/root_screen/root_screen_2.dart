import 'package:flutter/material.dart';
import 'package:side_menu_down_side/navigation_center.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

class RootScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Update current text (a "context" of root screen) to perform a navigation like real drawer
    NavigationCenter.shared.currentContext = context;
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            SideMenuHolder.shared.onMenuButtonClickListener();
          },
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: Text('RootScreen2'),
      ),
      body: Center(
        child: Text('Screen 2'),
      ),
    );
  }
}
