import 'package:flutter/material.dart';
import 'package:side_menu_down_side/navigation_center.dart';
import 'package:side_menu_down_side/root_screen/root_screen_1.dart';
import 'package:side_menu_down_side/root_screen/root_screen_2.dart';
import 'package:side_menu_down_side/root_screen/root_screen_3.dart';
import 'package:side_menu_down_side/root_screen/root_screen_4.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_content.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_screen_container.dart';

/// This Singleton of [SideMenuHolder] store state data,
/// will help [SideMenuDownSide][SideMenuContent][SideMenuScreenContainer]
/// to redisplay with correct/current state [selectedIndex][isMenuOpened]
class SideMenuHolder {
  /// Listener to be used, [SideMenuHolder] is just a Holder to store data, action
  VoidCallback onOpenMenu;
  VoidCallback onContentChanged;

  // This is hardcode data
  HeaderInfo _headerInfo = HeaderInfo(
    image: Icons.face_rounded,
    name: 'John Doe',
    subInfo: 'Membership: 💎',
  );

  // Global state variables
  int selectedIndex = 0;
  bool isMenuOpened = false;

  List<_MenuItem> _menus = [
    _MenuItem(
      name: 'RootScreen1',
      icon: Icons.home,
      isHeader: false,
      rootScreen: RootScreen1(),
    ),
    _MenuItem(
      name: 'RootScreen2',
      icon: Icons.face,
      isHeader: false,
      rootScreen: RootScreen2(),
    ),
    _MenuItem(
      name: 'RootScreen3',
      icon: Icons.star,
      isHeader: false,
      rootScreen: RootScreen3(),
    ),
    _MenuItem(
      name: 'RootScreen4',
      icon: Icons.icecream,
      isHeader: false,
      rootScreen: RootScreen4(),
    ),
    _MenuItem(
      name: 'RootScreen5',
      icon: Icons.wb_sunny,
      isHeader: false,
      rootScreen: RootScreen5(),
    ),
    _MenuItem(
      name: 'RootScreen6',
      icon: Icons.ramen_dining,
      isHeader: false,
      rootScreen: RootScreen6(),
    ),
  ];

  /// Change state - visible/hidden of [SideMenuContent]
  /// [SideMenuScreenContainer] will use [isMenuOpened] to animate its content
  void toggleDisplay({bool refresh = false}) {
    isMenuOpened = !isMenuOpened;
    if (refresh) refreshScreen();
  }

  // Stack of Screen to perform navigation
  ScreenStack _screenStack = ScreenStack();

  /// [SideMenuContent] will call this to display a vertial-menu
  List<_MenuItem> menus() {
    return this._menus;
  }

  /// Get root screen based on user selection - [selectedIndex]
  /// that is display on [SideMenuContent]
  /// from the list [menus]
  _MenuItem getSelectedItem() {
    return _menus[this.selectedIndex];
  }

  /// Update info of Header, this will tell [SideMenuContent] to re-display [Header] part
  HeaderInfo getHeaderInfo() => _headerInfo;
  void updateHeaderInfo(HeaderInfo info) {
    _headerInfo = info;
    onContentChanged();
  }

  /// We can setup with outside source of Menu item for more Isolation
  void makeMenuItem(List<_MenuItem> items) {
    if (items.isEmpty) {
      this._menus = [
        _MenuItem(
          name: 'RootScreen1',
          icon: Icons.home,
          isHeader: false,
          rootScreen: RootScreen1(),
        ),
        _MenuItem(
          name: 'RootScreen2',
          icon: Icons.face,
          isHeader: false,
          rootScreen: RootScreen2(),
        ),
        _MenuItem(
          name: 'RootScreen3',
          icon: Icons.star,
          isHeader: false,
          rootScreen: RootScreen3(),
        ),
        _MenuItem(
          name: 'RootScreen4',
          icon: Icons.icecream,
          isHeader: false,
          rootScreen: RootScreen4(),
        ),
        _MenuItem(
          name: 'RootScreen5',
          icon: Icons.wb_sunny,
          isHeader: false,
          rootScreen: RootScreen5(),
        ),
        _MenuItem(
          name: 'RootScreen6',
          icon: Icons.ramen_dining,
          isHeader: false,
          rootScreen: RootScreen6(),
        ),
      ];
    } else {
      this._menus = items;
    }
  }

  /// [NavigationCenter] will call this method
  /// when we open new screen by [NavigationCenter].navigate()
  void push(Widget w) {
    _screenStack.push(w);
    refreshScreen();
  }

  /// [NavigationCenter] will call this method
  /// when we call [NavigationCenter].back()
  void pop() {
    _screenStack.pop();
    refreshScreen();
  }

  /// Whenever user tap on [SideMenuContent]'s item
  /// that mean we move to new "Root Screen"
  /// popAll the subScreens which are pushed by calling [NavigationCenter].navigate()
  /// then tell [SideMenuScreenContainer] to refreshScreen()
  /// if user select same Root Screen (item on [SideMenuContent]), just hide [SideMenuContent]
  void moveToRoot(int newSelectedIndex) {
    if (newSelectedIndex != selectedIndex) {
      _screenStack.popAll();
    }
    selectedIndex = newSelectedIndex;
    onContentChanged(); // refresh ui of [SideMenuContent]
    toggleDisplay(); // hide the [SideMenuContent]
    refreshScreen(); // tell [SideMenuScreenContainer] to refreshScreen()
  }

  /// After [NavigationCenter] call above pop(), push(),...
  /// we need to tell [SideMenuScreenContainer] to refreshScreen()
  VoidCallback refreshScreen;

  /// [SideMenuScreenContainer] will call this method to get
  /// the corresponding screen to display, after [refreshScreen] is called
  Widget getScreenToDisplay() {
    var widget = _screenStack.current();
    if (widget != null) return widget;
    return _menus[this.selectedIndex].rootScreen;
  }

  /// Singleton definitions
  SideMenuHolder._privateConstructor();
  static final SideMenuHolder _instance = SideMenuHolder._privateConstructor();
  static SideMenuHolder get shared => _instance;
}

class _MenuItem {
  final String name;
  final IconData icon;
  final bool isHeader;
  final Widget rootScreen;

  _MenuItem({this.name, this.icon, this.isHeader, this.rootScreen});
}

class HeaderInfo {
  final IconData image;
  final String name;
  final String subInfo;

  HeaderInfo({this.image, this.name, this.subInfo});
}
//------------------------------------------------------------------------------

class ScreenStack {
  List<Widget> _stack = [];

  Widget current() {
    if (_stack.isEmpty) return null;
    var a = _stack.last;
    return a;
  }

  void push(Widget screen) {
    _stack.add(screen);
  }

  Widget pop() {
    if (_stack.isEmpty) return null;
    var a = _stack.removeLast();
    return a;
  }

  void popAll() {
    _stack.clear();
  }
}
