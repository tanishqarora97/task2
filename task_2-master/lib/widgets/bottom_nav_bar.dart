import 'dart:io';
import 'package:flutter/material.dart';
import 'package:task_1/model/nav_model.dart';

// ignore: must_be_immutable
class AnimatedBottomNavBar extends StatefulWidget {
  final List<NavBarItems> navBarItems;
  final Function onPressed;
  Duration animationDuration = Duration(milliseconds: 300);
  AnimatedBottomNavBar({
    @required this.navBarItems,
    @required this.onPressed,
  });
  @override
  _AnimatedBottomNavBarState createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35.0),
        topRight: Radius.circular(35.0),
      ),
      elevation: 10.0,
      color: Colors.grey[200],
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.grey[400],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40.0),
          ),
        ),
        padding: EdgeInsets.only(
            bottom: (Platform.isIOS) ? 22 : 10.0, top: 9, left: 4, right: 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildNavBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildNavBarItems() {
    List<Widget> _barItems = [];
    for (int i = 0; i < widget.navBarItems.length; i++) {
      NavBarItems barItems = widget.navBarItems[i];
      bool isSelected = _selectedIndex == i;
      _barItems.add(
        InkWell(
          borderRadius: BorderRadius.circular(30.0),
          splashColor: Colors.transparent,
          onTap: () {
            setState(
              () {
                _selectedIndex = i;
                widget.onPressed(_selectedIndex);
              },
            );
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
                color: isSelected ? Colors.blue[900] : Colors.white,
                borderRadius: BorderRadius.circular(30.0)),
            padding: EdgeInsets.all(10.0),
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSize(
                  vsync: this,
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  child: Icon(
                    barItems.iconData,
                    color: !isSelected ? Colors.black : Colors.white,
                  ),
                ),
                SizedBox(
                  width: isSelected ? 8.0 : 0.0,
                ),
                AnimatedSize(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  vsync: this,
                  child: Text(
                    isSelected ? barItems.text : '',
                    style: TextStyle(
                      color: !isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _barItems;
  }
}
