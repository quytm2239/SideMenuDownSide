import 'package:flutter/material.dart';
import 'package:side_menu_down_side/navigation_center.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

class RootScreen4 extends StatelessWidget {
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
        title: Text('RootScreen4'),
      ),
      body: Center(
        child: Text('Screen 4'),
      ),
    );
  }
}

class RootScreen5 extends StatelessWidget {
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
        title: Text('RootScreen5'),
      ),
      body: Center(
        child: Text('Screen 5'),
      ),
    );
  }
}

class RootScreen6 extends StatelessWidget {
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
        title: Text('RootScreen6'),
      ),
      body: Center(
        child: Text('Screen 6'),
      ),
    );
  }
}

class RootScreen7 extends StatelessWidget {
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
        title: Text('RootScreen7'),
      ),
      body: Center(
        child: Text('Screen 7'),
      ),
    );
  }
}
