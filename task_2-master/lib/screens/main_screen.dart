import 'package:flutter/material.dart';
import 'package:task_1/model/nav_model.dart';
import 'package:task_1/screens/add_screen.dart';
import 'package:task_1/widgets/bottom_nav_bar.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<NavBarItems> _navigationItems = [
      NavBarItems(
          color: Colors.green,
          text: 'Explore',
          onPressed: HomeScreen(),
          iconData: _selectedIndex == 0 ? Icons.home : Icons.home),
      NavBarItems(
          color: Colors.red,
          text: 'Search',
          onPressed: AddScreen(),
          iconData: _selectedIndex == 1 ? Icons.search : Icons.search),
    ];
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavBar(
        navBarItems: _navigationItems,
        onPressed: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _navigationItems[_selectedIndex].onPressed,
    );
  }
}
