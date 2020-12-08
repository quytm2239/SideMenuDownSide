import 'package:flutter/material.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_content.dart';

class SideMenuDownSide extends StatefulWidget {
  @override
  _SideMenuDownSideState createState() => _SideMenuDownSideState();
}

class _SideMenuDownSideState extends State<SideMenuDownSide> {
  // These properties for scale content view to match UI design
  // It is like push content view to the right then scale down the content
  double _width = 100;
  double _height = 100;
  Matrix4 _transform = Matrix4.translationValues(0.0, 0.0, 0.0);
  bool _isMenuOpened = false;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(16);

  _SideMenuDownSideState() {
    /// Update [MenuItem]'s click event-listener for [SideMenuHolder] to be used in [RootScreen]
    /// [RootScreen] will send an event vii this [_onMenuButtonClicked] when user click [MenuButton] on [AppBar]
    SideMenuHolder.shared.onMenuButtonClickListener = _onMenuButtonClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            // Background image of SideMenu (Drawer)
            Image(
              width: double.infinity,
              height: double.infinity,
              image: AssetImage('assets/images/sample_background.jpg'),
              fit: BoxFit.cover,
            ),
            // This is side menu container for decoration
            Container(
              // color: ColorSideMenu.gradient2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [const Color(0xcc000000), const Color(0x88000000)],
                    begin: const FractionalOffset(0, 1),
                    end: const FractionalOffset(0, 0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              // This is side menu item list
              child: SideMenuContent(
                onItemClicked: this._onMenuItemClicked,
              ),
            ),
            // Bottom part
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Container(
                // Outer container
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Row(
                    children: [
                      Container(
                        // Make margin for Icon
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(
                          Icons.settings,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                      Text(
                        'Setting',
                        style: TextStyle(
                            color: const Color(0xFFE9E9E9),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(width: 50),
                      Container(
                        // Make margin for Icon
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(
                          Icons.logout,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                            color: const Color(0xFFE9E9E9),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // This container to animate the content, to display SideMenu
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
                  borderRadius:
                      _isMenuOpened ? _borderRadius : BorderRadius.zero,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMenuOpened = false;
                      });
                    },
                    child: _getRootScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // These functions will be called every time widget(content/screen) has to be re-rendered
  Matrix4 _getTransform(BuildContext ctx) {
    var width = MediaQuery.of(context).size.width; // screenWidth
    _transform =
        Matrix4.translationValues(width * (_isMenuOpened ? 0.4 : 0), 0.0, 0.0);
    return _transform;
  }

  double _getHeight(BuildContext ctx) {
    var height = MediaQuery.of(context).size.height;
    _height = height * (_isMenuOpened ? 0.75 : 1);
    return _height;
  }

  double _getWidth(BuildContext ctx) {
    var width = MediaQuery.of(context).size.width;
    _width = width * (_isMenuOpened ? 0.75 : 1);
    return _width;
  }

// This is used for SideMenu Itemlist
  void _onMenuItemClicked(int index) {
    setState(() {
      SideMenuHolder.shared.selectedIndex = index;
      _isMenuOpened = !_isMenuOpened;
      print('SideMenuContainer: user just clicked: ' +
          SideMenuHolder.shared.selectedIndex.toString());
    });
  }

  /// Menu button on AppBar is clicked event
  void _onMenuButtonClicked() {
    setState(() {
      _isMenuOpened = !_isMenuOpened;
    });
  }

  Widget _getRootScreen() {
    return SideMenuHolder.shared.getSelectedItem().rootScreen;
  }
}
