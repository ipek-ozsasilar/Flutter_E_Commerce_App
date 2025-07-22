import 'package:flutter/material.dart';

@immutable
class PaddingsConstants {
   PaddingsConstants._();
  static PaddingsConstants get instance => PaddingsConstants._();
  
  final EdgeInsets splashIconOnlyLeftPadding = EdgeInsets.only(left: 10);
  final EdgeInsets onboardingLeadingPadding = EdgeInsets.only(left: 17,top: 15);
  final EdgeInsets onboardingPageHorizontalPadding = EdgeInsets.symmetric(horizontal: 17);
  final EdgeInsets onboardingTitlePadding = EdgeInsets.only(top:25,bottom: 10);
  final EdgeInsets bottomContainerHorizontalPadding = EdgeInsets.symmetric(horizontal: 10);
  final EdgeInsets onboardingBottomPadding = EdgeInsets.symmetric(vertical: 17,horizontal: 17);
} 