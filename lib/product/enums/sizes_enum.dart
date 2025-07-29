//Icon Size Enum for get icon size
enum IconSizeEnum {
  splashIconWidthAndHeight(125);

  final double value;

  const IconSizeEnum(this.value);
}

//Image Size Enum for get image size
enum ImageSizeEnum {
  chooseProductWidthAndHeight(300),
  getYourOrderWidthAndHeight(350),
  makePaymentWidth(350),
  makePaymentHeight(230);

  final double value;

  const ImageSizeEnum(this.value);
}

//Text Size Enum for get text size
enum TextSizeEnum {
  onboardingTitleSize(24),
  onboardingSkipSize(16),
  loginWelcomeSize(30),
  loginInputHintTextSize(13);

  final double value;

  const TextSizeEnum(this.value);
}

//Widget Size Enum for get widget size
enum WidgetSizeEnum {
  bottomContainerWidthAndHeight(10),
  loginButtonHeight(55);

  final double value;

  const WidgetSizeEnum(this.value);
}

enum AppbarSizeEnum {
  loginToolbarHeight(140),
  loginLeadingWidth(220);

  final double value;

  const AppbarSizeEnum(this.value);
}
