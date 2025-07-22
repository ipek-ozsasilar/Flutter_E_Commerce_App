import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

//Navigator Manager for navigate to page or close page
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
