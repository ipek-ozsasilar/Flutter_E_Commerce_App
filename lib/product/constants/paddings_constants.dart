import 'package:flutter/material.dart';

@immutable
class PaddingsConstants {
  const PaddingsConstants._();
  static const PaddingsConstants paddingsInstance = PaddingsConstants._();
  
  static const EdgeInsets splashIconOnlyLeftPadding = EdgeInsets.only(left: 10);
  static const EdgeInsets onboardingLeadingPadding = EdgeInsets.only(left: 17,top: 15);
  static const EdgeInsets onboardingPageHorizontalPadding = EdgeInsets.symmetric(horizontal: 17);
  static const EdgeInsets onboardingTitlePadding = EdgeInsets.only(top:25,bottom: 10);
  
} 