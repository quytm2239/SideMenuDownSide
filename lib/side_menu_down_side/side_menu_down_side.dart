import 'package:flutter/material.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_content.dart';
import 'package:side_menu_down_side/side_menu_down_side/side_menu_screen_container.dart';

class SideMenuDownSide extends StatefulWidget {
  @override
  _SideMenuDownSideState createState() => _SideMenuDownSideState();
}

class _SideMenuDownSideState extends State<SideMenuDownSide> {
  /// This property - [SideMenuScreenContainer] will handle
  /// Animation of current screen to show/hide the [SideMenuContent]
  var screenContainer = SideMenuScreenContainer();

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
                onBackgroundClicked: this._onBackgroundClicked,
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
                        style: TextStyle(color: const Color(0xFFE9E9E9), fontWeight: FontWeight.bold, fontSize: 15),
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
                        style: TextStyle(color: const Color(0xFFE9E9E9), fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            screenContainer,
          ],
        ),
      ),
    );
  }

  /// This function is called when user tap on item of [SideMenuContent]
  /// that is made with [SideMenuContent._makeMenuItem]
  /// tell [SideMenuHolder] that we need to move to new "root screen"
  void _onMenuItemClicked(int index) {
    SideMenuHolder.shared.moveToRoot(index);
    print('SideMenuContainer: user just clicked: ' + SideMenuHolder.shared.selectedIndex.toString());
  }

  /// This function is called when user tap on "background" of [SideMenuContent]
  /// tell [SideMenuHolder] that we need to close [SideMenuContent]
  void _onBackgroundClicked() {
    SideMenuHolder.shared.toggleDisplay(refresh: true);
  }
}
