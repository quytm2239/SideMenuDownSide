import 'package:flutter/material.dart';
import 'package:side_menu_down_side/navigation_center.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

class RootScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Update current text (a "context" of root screen) to perform a navigation like real drawer
    NavigationCenter.shared.currentContext = context;
    return Scaffold(
      appBar: AppBar(
        leading:
            // You can make this button become a Customized Button for Appbar
            FlatButton(
          onPressed: () {
            SideMenuHolder.shared.onOpenMenu();
          },
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: Text('RootScreen1'),
        titleSpacing: 0,
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            NavigationCenter.shared.navigate(SubScreen1());
          },
          child: Text('Screen 1'),
        ),
      ),
    );
  }
}

class SubScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            NavigationCenter.shared.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Subscreen1'),
      ),
      body: Center(
        child: Text('Sub Screen 1'),
      ),
    );
  }
}
