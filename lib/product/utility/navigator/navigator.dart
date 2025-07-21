import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NavigatorManager {
  NavigatorManager._();
  static final NavigatorManager instance = NavigatorManager._();

  void closePagePop(BuildContext context) {
    context.route.pop();
  }

  void navigatePage(BuildContext context, Widget page) {
    context.route.navigateToPage(page);
  }
}
