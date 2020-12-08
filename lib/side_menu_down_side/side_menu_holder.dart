import 'package:flutter/material.dart';
import 'package:side_menu_down_side/root_screen/root_screen_1.dart';
import 'package:side_menu_down_side/root_screen/root_screen_2.dart';
import 'package:side_menu_down_side/root_screen/root_screen_3.dart';
import 'package:side_menu_down_side/root_screen/root_screen_4.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_content.dart';

/// This Singleton of [SideMenuHolder] store state data,
/// will help [SideMenuDownSide] to redisplay with correct/current state (selectedIndex)
class SideMenuHolder {
  /// Listener to be used, [SideMenuHolder] is just a Holder to store data, action
  VoidCallback onMenuButtonClickListener;
  VoidCallback onContentChanged;
  // This is hardcode data
  HeaderInfo _headerInfo = HeaderInfo(
      image: Icons.face_rounded, name: 'John Doe', subInfo: 'Membership: 💎');
  int selectedIndex = 0;
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

  List<_MenuItem> menus() {
    return this._menus;
  }

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

// Singleton definitions
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
