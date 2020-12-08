import 'package:flutter/material.dart';

import 'package:side_menu_down_side/side_menu_down_side/side_menu_holder.dart';

class SideMenuContent extends StatefulWidget {
  final Function(int) onItemClicked;

  const SideMenuContent({
    Key key,
    this.onItemClicked,
  }) : super(key: key);
  @override
  _SideMenuContentState createState() =>
      _SideMenuContentState(this.onItemClicked);
}

class _SideMenuContentState extends State<SideMenuContent> {
  Function(int) _onItemClicked;

  _SideMenuContentState(Function(int) onItemClicked) {
    /// [SideMenuHolder] holds [RootScreen]'s list and [HeaderInfo] object
    /// This listener [_onContentChanged] will help us to change content of [Header],
    /// if needed in [Runtime] by updating data of [HeaderInfo] object
    SideMenuHolder.shared.onContentChanged = _onContentChanged;

    /// [onItemClicked] is a listener of [SideMenuDownSide], tell it to re-layout (open the SideMenu)
    this._onItemClicked = onItemClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // This is side menu item list
      child: ListView.builder(
          primary:
              false, // disable scrolling, but if [RootScreen] is long, we should enable
          padding: EdgeInsets.zero,
          itemCount: SideMenuHolder.shared.menus().length + 1, // + 1 for header
          itemBuilder: (_, index) {
            if (index == 0) {
              // Header part
              return _makeHeader(SideMenuHolder.shared.getHeaderInfo());
            }
            // Item part
            var validIndex = index - 1;
            return GestureDetector(
              onTap: () {
                _onItemClicked(validIndex);
              },
              child: _makeMenuItem(validIndex),
            );
          }),
    );
  }

  DrawerHeader _makeHeader(HeaderInfo headerInfo) {
    return DrawerHeader(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: ClipRRect(
              child: Icon(
                headerInfo.image,
                color: Colors.white,
                size: 50,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerInfo.name,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    headerInfo.subInfo,
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: const Color(0xFFE0E0E0), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }

  Container _makeMenuItem(int index) {
    var isSelected = SideMenuHolder.shared.selectedIndex == index;
    return Container(
      // Outer container
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      child: Container(
        // Highlight/selected container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: isSelected
          //     ? const Color(0x50FFFFFF)
          //     : Colors.transparent, // this will be highlighted when click
        ),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          children: [
            Container(
              // Make margin for Icon
              margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(
                SideMenuHolder.shared.menus()[index].icon,
                size: 22,
                color: isSelected ? Colors.white : const Color(0xFFD0D0D0),
              ),
            ),
            Text(
              SideMenuHolder.shared.menus()[index].name,
              style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFFE9E9E9),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: isSelected ? 16 : 15),
            ),
          ],
        ),
      ),
    );
  }

  void _onContentChanged() {
    setState(() {});
  }
}
