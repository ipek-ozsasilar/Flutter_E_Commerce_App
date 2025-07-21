enum IconSizeEnum {
  splashIconWidthAndHeight(125);

  final double value;

  const IconSizeEnum(this.value);
}

enum ImageSizeEnum {
  chooseProductWidthAndHeight(300),
  getYourOrderWidthAndHeight(350),
  makePaymentWidth(350),
  makePaymentHeight(230);
  

  final double value;

  const ImageSizeEnum(this.value);
}

enum TextSizeEnum { 
  onboardingTitleSize(24),
  onboardingSkipSize(16);

  final double value;

  const TextSizeEnum(this.value);
  }