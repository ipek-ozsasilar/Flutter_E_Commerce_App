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
  final EdgeInsets loginAppbarPadding = EdgeInsets.symmetric(horizontal: 30) + const EdgeInsets.only(top: 60);
  final EdgeInsets loginBodyPadding = const EdgeInsets.symmetric(horizontal: 30) + const EdgeInsets.only(top: 40);
  final EdgeInsets loginButtonPadding = EdgeInsets.symmetric(vertical: 15);
  final EdgeInsets loginWelcomeInputPadding = EdgeInsets.only(top: 30,bottom: 5);
  final EdgeInsets welcomeLoginButtonPadding = EdgeInsets.only(top: 40, bottom: 70);
  final EdgeInsets otherLoginButtonVerticalPadding = EdgeInsets.symmetric(vertical: 20);
  final EdgeInsets otherLoginButtonHorizontalPadding = EdgeInsets.symmetric(horizontal: 10);
  final EdgeInsets forgotPasswordDetailPadding = EdgeInsets.only(top: 25, bottom: 35);
  final EdgeInsets createAccountButtonPadding = EdgeInsets.only(top: 20, bottom: 35);
  final EdgeInsets createAccountPasswordPadding = EdgeInsets.symmetric(vertical: 30);
  final EdgeInsets orContinuePadding = EdgeInsets.only(top: 40,bottom: 20);
  final EdgeInsets createAccountRichTextPadding = EdgeInsets.only(top: 20);
  final EdgeInsets bottomSheetPadding = EdgeInsets.all(16.0);
  final EdgeInsets bottomSheetListTilePadding = EdgeInsets.only(top: 16);
} 