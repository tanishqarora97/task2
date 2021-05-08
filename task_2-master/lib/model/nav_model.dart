import 'package:flutter/cupertino.dart';

class NavBarItems {
  final IconData iconData;
  final Color color;
  final String text;
  final Widget onPressed;
  const NavBarItems({
    this.color,
    this.iconData,
    this.text,
    this.onPressed,
  });
}
