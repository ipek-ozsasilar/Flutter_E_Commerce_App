//Icon Size Enum for get icon size
enum IconSizeEnum {
  splashIconWidthAndHeight(125),
  homeAppbarIconSize(60),
  homeSortFilterIconSize(20),
  homeIconSize(30),
  homeStarIconSize(14),
  homePaymentCardIconSize(20),
  homeCouponIconSize(16),
  homeCouponIconContainerSize(24),
  paymentSuccessDialogIconSize(40);



  final double value;

  const IconSizeEnum(this.value);
}

//Image Size Enum for get image size
enum ImageSizeEnum {
  chooseProductWidthAndHeight(300),
  imagePickerWidthAndHeight(800),
  imagePickerImageQuality(85),
  getYourOrderWidthAndHeight(350),
  makePaymentWidth(350),
  makePaymentHeight(230),
  homeSponsordWidth(400),
  shoppingBagImageWidth(150),
  shoppingBagImageHeight(160);

  final double value;

  const ImageSizeEnum(this.value);
}

//Text Size Enum for get text size
enum TextSizeEnum {
  onboardingTitleSize(24),
  onboardingSkipSize(16),
  loginWelcomeSize(30),
  loginInputHintTextSize(13),
  loginButtonTextSize(15),
  homeTitleSize(40),
  homeDescriptionSize(15),
  homeCardsTitleSize(14),
  homeCardsDetailSize(12),
  homeSpecialOffersTitleSize(18),
  homeTrendingDealTitleSize(20),
  ProfileCheckoutTitleSize(23);

  final double value;

  const TextSizeEnum(this.value);
}

//Widget Size Enum for get widget size
enum WidgetSizeEnum {
  bottomContainerWidthAndHeight(10),
  loginButtonHeight(55),
  categoryContainerHeight(110),
  homeIndicatorSize(10),
  homeCardsContainerHeight(250),
  homeCardsContainerWidth(180),
  homeDiscountStackHeight(190),
  homeDiscountStackWidth(340),
  homeSponsordHeight(300),
  newArrivalsContainerHeight(300),
  circleAvatarRadius(25),
  flatAndHeelsContainerHeight(170),
  homeSearchHeight(60),
  homeBottomNavigationBarHeight(90),
  homeTrendingProductLongCardHeight(260),
  homeTrendingProductShortCardHeight(220),
  profileCircleAvatarRadius(50),
  profileEditButtonRight(-10),
  profileEditButtonBottom(-10),
  profileEditButtonWidthAndHeight(40),
  deliveryAddressContainerHeight(140),
  couponContainerBorderWidth(1.5),
  paymentSuccessDialogWidthAndHeight(80);


  



  final double value;

  const WidgetSizeEnum(this.value);
}

enum AppbarSizeEnum {
  loginToolbarHeight(200),
  loginLeadingWidth(220),
  homeToolbarHeight(75),
  homeLeadingWidth(70);

  final double value;

  const AppbarSizeEnum(this.value);
}

enum BottomNavigationBarSizeEnum {
  homeBottomNavigationBarIconSize(30),
  homeBottomNavigationBarTextSize(13);

  final double value;

  const BottomNavigationBarSizeEnum(this.value);
}
