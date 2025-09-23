import 'package:flutter/material.dart';

@immutable
class PaddingsConstants {
  PaddingsConstants._();
  static PaddingsConstants get instance => PaddingsConstants._();

  final EdgeInsets splashIconOnlyLeftPadding = EdgeInsets.only(left: 10);
  final EdgeInsets onboardingLeadingPadding = EdgeInsets.only(
    left: 17,
    top: 15,
  );
  final EdgeInsets onboardingPageHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 17,
  );
  final EdgeInsets onboardingTitlePadding = EdgeInsets.only(
    top: 25,
    bottom: 10,
  );
  final EdgeInsets bottomContainerHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 10,
  );
  final EdgeInsets onboardingBottomPadding = EdgeInsets.symmetric(
    vertical: 17,
    horizontal: 17,
  );
  final EdgeInsets loginAppbarPadding =
      EdgeInsets.symmetric(horizontal: 30) + const EdgeInsets.only(top: 60);
  final EdgeInsets loginBodyPadding =
      const EdgeInsets.symmetric(horizontal: 30) +
      const EdgeInsets.only(top: 40);
  final EdgeInsets loginButtonPadding = EdgeInsets.symmetric(vertical: 15);
  final EdgeInsets loginWelcomeInputPadding = EdgeInsets.only(
    top: 30,
    bottom: 5,
  );
  final EdgeInsets welcomeLoginButtonPadding = EdgeInsets.only(
    top: 40,
    bottom: 70,
  );
  final EdgeInsets otherLoginButtonVerticalPadding = EdgeInsets.symmetric(
    vertical: 20,
  );
  final EdgeInsets otherLoginButtonHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 10,
  );
  final EdgeInsets forgotPasswordDetailPadding = EdgeInsets.only(
    top: 25,
    bottom: 35,
  );
  final EdgeInsets createAccountButtonPadding = EdgeInsets.only(
    top: 20,
    bottom: 35,
  );
  final EdgeInsets createAccountPasswordPadding = EdgeInsets.symmetric(
    vertical: 30,
  );
  final EdgeInsets orContinuePadding = EdgeInsets.only(top: 40, bottom: 20);
  final EdgeInsets createAccountRichTextPadding = EdgeInsets.only(top: 20);
  final EdgeInsets bottomSheetPadding = EdgeInsets.all(16.0);
  final EdgeInsets bottomSheetListTilePadding = EdgeInsets.only(top: 16);
  final EdgeInsets getStartedPagePadding = EdgeInsets.only(right: 60,left: 60,bottom: 40,);
  final EdgeInsets getStartedTitlePadding = EdgeInsets.only(top: 15, bottom: 45);
  final EdgeInsets homePagePadding = EdgeInsets.symmetric(horizontal: 20);
  final EdgeInsets homeSearchPadding = EdgeInsets.only(top: 25, bottom: 15);
  final EdgeInsets homeSearchInsidePadding = EdgeInsets.symmetric(horizontal: 15, vertical: 12);
  final EdgeInsets homeSortPadding = EdgeInsets.only(right: 10);
  final EdgeInsets homeSortInsidePadding = EdgeInsets.symmetric(horizontal: 6, vertical: 4);
  final EdgeInsets homeSingleChildScrollViewPadding = EdgeInsets.symmetric(vertical: 15);
  final EdgeInsets homeSingleChildScrollViewInsidePadding = EdgeInsets.all(5);
  final EdgeInsets homeSingleChildScrollElementPadding = EdgeInsets.only(right: 15);
  final EdgeInsets homeAppbarPadding = EdgeInsets.only(top: 25, left: 30, right: 30);
  final EdgeInsets homeAppbarLeadingPadding = EdgeInsets.only(left: 20, top: 25);
  final EdgeInsets homeAppbarActionsPadding = EdgeInsets.only(right: 20, top: 25);
  final EdgeInsets homeSortFilterPadding = EdgeInsets.only(right: 5);
  final EdgeInsets homeIndicatorInsidePadding = EdgeInsets.symmetric(horizontal: 5.0);
  final EdgeInsets homeTrendingDealInsidePadding = EdgeInsets.all(12);
  final EdgeInsets homeStarTextPadding = EdgeInsets.only(left: 4);
  final EdgeInsets homeSponsordPadding = EdgeInsets.only(top: 10);
  final EdgeInsets homeOutlinedButtonPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  final EdgeInsets homeFlatBottomPadding = EdgeInsets.only(bottom: 12);
  final EdgeInsets homeFlatAndHeelsPadding = EdgeInsets.only(bottom:4);
  final EdgeInsets homeBottomNavigationBarPadding = EdgeInsets.symmetric(horizontal: 20)+EdgeInsets.only(top: 10);
  final EdgeInsets homeBottomNavigationBarBasketInsidePadding = EdgeInsets.all(5);
    final EdgeInsets profileAppbarLeadingPadding = EdgeInsets.only(left: 10);
     final EdgeInsets profileSaveButtonPadding = EdgeInsets.symmetric(vertical: 40);
     final EdgeInsets profileTextAndInputPadding = EdgeInsets.only(bottom: 10, top: 25);
     final EdgeInsets profileAppbarActionsPadding = EdgeInsets.only(right: 10);
     final EdgeInsets shoppingBagSizeAndQuantityPadding = EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    );
}
