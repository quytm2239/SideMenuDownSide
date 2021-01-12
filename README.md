# SideMenuDownSide
This project is about a Customized Flutter Drawer

## Table of contents
* [How it work](#how-it-work)
* [Struture](#structure)
* [How to use](#how-to-use)
* [Contribution](#contribution)

## How it work
![alt text](SideMenuDownSideAnimate.gif?raw=true)
	
## Structure
This project is created with `Dart` and `Flutter 1.25.0-4.0.pre`.

Class `SideMenuDownSide` is container of `SideMenuContent`.
  - `SideMenuDownSide` is a skeleton, hub to combine another component together. It is written file `side_menu_down_side.dart`
  - `SideMenuContent` contains logic about how to display `Menu Items`. It is written in file `side_menu_content.dart`
  - `SideMenuHolder` contains a `DataSource` for screen list (a list of Widget). It is written in file `side_menu_holder.dart`
  - `SideMenuScreenContainer` will help us to relayout, trigger animation, display current screen. It is written in file `side_menu_screen_container.dart`

## How to use (Outdated, will be updated soon! But I already added comment for each important block of codes)
  - Update your `main.dart`. Here is your new `main.dart` content:
  ```
  import 'package:flutter/material.dart';
  import 'package:side_menu_down_side/navigation_center.dart';
  import 'package:side_menu_down_side/side_menu_down_side/side_menu_down_side.dart';
  
  // Another your desired import ...

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      // Update appContext for later usage
      NavigationCenter.shared.appContext = context;
      return MaterialApp(
        title: 'SideMenu DownSide',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SideMenuDownSide(), // <--- Here is our SideMenuDownSide
      );
    }
  }
  ```
  - Take a look at class `SideMenuHolder`(a singleton) in `lib\side_menu_down_side\side_menu_holder.dart`, 
  this class has a list of `_MenuItem`. That stores data of each `RootScreen` in menu.
  ```
  List<_MenuItem> _menus = ... // This is place where we display menu items.
  ```
  - Here is our `_MenuItem` and `HeaderInfo` class to contain data of `SideMenuContent`
  ```
  class _MenuItem {
    final String name; // Menu item's name
    final IconData icon; // Icon of Menu item
    final bool isHeader;
    final Widget rootScreen; // Scren to be displayed (A Scaffold - Widget)

    _MenuItem({this.name, this.icon, this.isHeader, this.rootScreen});
  }

  class HeaderInfo {
    final IconData image;
    final String name;
    final String subInfo;

    HeaderInfo({this.image, this.name, this.subInfo});
  }
  ```
  - You can adjust the `position, size` of `Content` (our `RootScreen`, that is displayed after click menu item). 
  In file `side_menu_down_side.dart`
  ```
    // These functions will be called every time widget(content/screen) has to be re-rendered
  Matrix4 _getTransform(BuildContext ctx) {
    var width = MediaQuery.of(context).size.width; // screenWidth
    
    // if menu is displayed, move content to the RIGHT by 40% of screen width
    _transform =
        Matrix4.translationValues(width * (_isMenuOpened ? 0.4 : 0), 0.0, 0.0); 
	
    return _transform;
  }

  double _getHeight(BuildContext ctx) {
    var height = MediaQuery.of(context).size.height;
    
    // if menu is displayed, scale down content's height (of RootScreen) to 75% of screen height (original)
    _height = height * (_isMenuOpened ? 0.75 : 1); 
    
    return _height;
  }

  double _getWidth(BuildContext ctx) {
    var width = MediaQuery.of(context).size.width;
    
    // if menu is displayed, scale down content's width (of RootScreen) to 75% of screen width (original)
    _width = width * (_isMenuOpened ? 0.75 : 1); 
    
    return _width;
  }
  ```
  - You can adjust the Open-Close animation speed in `side_menu_down_side.dart`:
  ```
   AnimatedContainer(
                // Use the properties stored in the State class.
                width: _getWidth(context),
                height: _getHeight(context),
                transform: _getTransform(context),
                // Define how long the animation should take.
                duration: Duration(milliseconds: 500), // <-- Here is animation time
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.fastOutSlowIn,
   ```
   - Finally, check the example RootScreen(The screen which is opened from SideMenu, or placed in SideMenu), like below:
```
class RootScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Update current text (a "context" of root screen) to perform a navigation like real drawer
    NavigationCenter.shared.currentContext = context; // <- Here to keep a refer to your current "Root Screen"'s Build Context for later usage
    return Scaffold(
      appBar: AppBar(
	leading:
	    // You can make this button become a Customized Button for Appbar
	    FlatButton(
	  onPressed: () {
	    SideMenuHolder.shared.onMenuButtonClickListener(); // <- You can call this function anywhere to open the SideMenu
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
	    NavigationCenter.shared.navigate(SubScreen1()); // <- This is how I navigate in this project
	  },
	  child: Text('Screen 1'),
	),
      ),
    );
  }
}
```
- And, this is how your SubScreen Appbar is:
```
class SubScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            NavigationCenter.shared.back(); // <- This how I navigate back, or pop,... in this project
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
```
- You can also change the logic of Navigation in class NavigationCenter to has "real" push animation when navigate to new screen.
```
import 'package:flutter/cupertino.dart'; // for this CupertinoPageRoute
import 'package:flutter/material.dart'; // for this MaterialPageRoute

class NavigationCenter {
  BuildContext appContext;
  BuildContext currentContext;
  StatefulWidget currentScreen;

  void navigate(Widget newScreen, [bool fromAppContext = false]) {
    if (currentContext == null) return;
    Navigator.push(
        fromAppContext ? appContext : (currentContext ?? appContext),
        // MaterialPageRoute(builder: (context) => newScreen), // (1) - Slide Upward
        CupertinoPageRoute(builder: (context) => newScreen)); // (2) - Push Left
  }
...
}
```

## Contribution
If you have anything to upgrade this project, feel free to contact me via email: `quytm2239@gmail.com` or skype: `tranquy239`.

Thank you!
