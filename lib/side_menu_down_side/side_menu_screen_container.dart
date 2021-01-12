import 'package:flutter/material.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

class SideMenuScreenContainer extends StatefulWidget {
  @override
  _SideMenuScreenContainerState createState() => _SideMenuScreenContainerState();
}

class _SideMenuScreenContainerState extends State<SideMenuScreenContainer> {
  // These properties for scale content view to match UI design
  // It is like push content view to the right then scale down the content
  double _width = 100;
  double _height = 100;
  Matrix4 _transform = Matrix4.translationValues(0.0, 0.0, 0.0);
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(16);

  @override
  void initState() {
    super.initState();
    SideMenuHolder.shared.onOpenMenu = _onMenuOpen;
    SideMenuHolder.shared.refreshScreen = _refreshScreen;
  }

  @override
  Widget build(BuildContext context) {
    return // This container to animate the content, to display SideMenu
        Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: _getWidth(context),
        height: _getHeight(context),
        transform: _getTransform(context),
        // Define how long the animation should take.
        duration: Duration(milliseconds: 500),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        // This is our screen to display
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: SideMenuHolder.shared.isMenuOpened ? _borderRadius : BorderRadius.zero,
          child: GestureDetector(
            onTap: () {
              if (SideMenuHolder.shared.isMenuOpened) {
                setState(() {
                  SideMenuHolder.shared.toggleDisplay();
                });
              }
            },
            child: SideMenuHolder.shared.getScreenToDisplay(),
          ),
        ),
      ),
    );
  }

  void _refreshScreen() {
    setState(() {});
  }

  /// Menu button on AppBar is clicked event
  void _onMenuOpen() {
    setState(() {
      SideMenuHolder.shared.toggleDisplay();
    });
  }

  // These functions will be called every time widget(content/screen) has to be re-rendered
  Matrix4 _getTransform(BuildContext ctx) {
    var width = MediaQuery.of(context).size.width; // screenWidth
    _transform = Matrix4.translationValues(width * (SideMenuHolder.shared.isMenuOpened ? 0.4 : 0), 0.0, 0.0);
    return _transform;
  }

  double _getHeight(BuildContext ctx) {
    var height = MediaQuery.of(context).size.height;
    _height = height * (SideMenuHolder.shared.isMenuOpened ? 0.75 : 1);
    return _height;
  }

  double _getWidth(BuildContext ctx) {
    var width = MediaQuery.of(context).size.width;
    _width = width * (SideMenuHolder.shared.isMenuOpened ? 0.75 : 1);
    return _width;
  }
}
