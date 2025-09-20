import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';

//ThemeExtension, Flutter’da kendi özel tema verilerini
//(ThemeData’ya ek renkler, spacing, font boyutları vb.) eklemek için kullanılan bir yapıdır.
//Normalde ThemeData içinde sadece Flutter’ın sağladığı hazır alanlar var (primaryColor, colorScheme, textTheme vb.).
//Ama senin figmadan gelen boldBlack, loginInputHintText gibi özel renkler bu hazır alanlarda yok.
////İşte ThemeExtension, bu ek alanları temaya eklemene ve dark/light modda değişmelerini sağlamana yarar.
//Yani Flutter’ın kendi ThemeData’sında olmayan senin özel renk setin (AppColors) artık temanın bir parçası
//oluyor. Böylece Theme.of(context).extension<AppColors>() ile istediğin yerden çağırabiliyorsun.

//Sen ThemeExtension<AppColors> yaptığında: AppColors senin özel veri tipin oluyor. ThemeData.extensions
// listesine ekleniyor. Theme.of(context).extension<AppColors>() ile temanın içinden erişiyorsun.

class AppColors extends ThemeExtension<AppColors> {
  final Color boldBlack;
  final Color lightBackground;
  final Color loginInputHintText;
  final Color loginInputIconsGrey;
  final Color loginShadowMountain;
  final Color prevColor;
  final Color selectedPageBlue;
  final Color sizzlingRed;
  final Color splashUltimateGreyText;
  final Color whiteColor;
  final Color facebookBlue;
  final Color drawerBackground;
  final Color searchHintGrey;
  // Home Page Colors
  final Color homePageDiscountIndicatorPink;
  final Color homePageDiscountIndicatorGrey;
  final Color dealOfTheDayBlue;
  // Product Colors
  final Color offRedColor;
  final Color starNumberGreyColor;
  final Color oldPriceGreyColor;
  final Color starYellowColor;
  final Color flatAndHeelsBlack;
  final Color trendingProductsPink;
  final Color bottomAppBarSelectedColor;
  // Shop Colors
  final Color sizeButtonPink;
  final Color shopPageGrey;
  final Color shopPageBuyGreen;
  final Color shopPageBlue;
  final Color shopPagePink;
  final Color totalTextColor;
  final Color paymentTextColor;
  final Color hideCardNumberGrey;
  final Color paymentBoxFillGrey;
  final Color secondaryBackgroundColor;
  const AppColors({
    required this.boldBlack,
    required this.lightBackground,
    required this.loginInputHintText,
    required this.loginInputIconsGrey,
    required this.loginShadowMountain,
    required this.prevColor,
    required this.selectedPageBlue,
    required this.sizzlingRed,
    required this.splashUltimateGreyText,
    required this.whiteColor,
    required this.facebookBlue,
    required this.drawerBackground,
    required this.searchHintGrey,
    // Home Page Colors
    required this.homePageDiscountIndicatorPink,
    required this.homePageDiscountIndicatorGrey,
    required this.dealOfTheDayBlue,
    // Product Colors
    required this.offRedColor,
    required this.starNumberGreyColor,
    required this.oldPriceGreyColor,
    required this.starYellowColor,
    required this.flatAndHeelsBlack,
    required this.trendingProductsPink,
    required this.bottomAppBarSelectedColor,
    // Shop Colors
    required this.sizeButtonPink,
    required this.shopPageGrey,
    required this.shopPageBuyGreen,
    required this.shopPageBlue,
    required this.shopPagePink,
    required this.totalTextColor,
    required this.paymentTextColor,
    required this.hideCardNumberGrey,
    required this.paymentBoxFillGrey,
    required this.secondaryBackgroundColor,
  });

  factory AppColors.light() {
    return const AppColors(
      boldBlack: ColorName.boldBlack,
      lightBackground: ColorName.whiteColor,
      loginInputHintText: ColorName.loginInputHintText,
      loginInputIconsGrey: ColorName.loginInputIconsGrey,
      loginShadowMountain: ColorName.loginShadowMountain,
      prevColor: ColorName.prevColor,
      selectedPageBlue: ColorName.selectedPageBlue,
      sizzlingRed: ColorName.sizzlingRed,
      splashUltimateGreyText: ColorName.splashUltimateGreyText,
      whiteColor: ColorName.whiteColor,
      facebookBlue: ColorName.facebookBlue,
      drawerBackground: ColorName.drawerBackground,
      searchHintGrey: ColorName.searchHintGrey,
      // Home Page Colors
      homePageDiscountIndicatorPink: ColorName.homePageDiscountIndicatorPink,
      homePageDiscountIndicatorGrey: ColorName.homePageDiscountIndicatorGrey,
      dealOfTheDayBlue: ColorName.dealOfTheDayBlue,
      // Product Colors
      offRedColor: ColorName.offRedColor,
      starNumberGreyColor: ColorName.starNumberGreyColor,
      oldPriceGreyColor: ColorName.oldPriceGreyColor,
      starYellowColor: ColorName.starYellowColor,
      flatAndHeelsBlack: ColorName.flatAndHeelsBlack,
      trendingProductsPink: ColorName.trendingProductsPink,
      bottomAppBarSelectedColor: ColorName.bottomAppBarSelectedColor,
      // Shop Colors
      sizeButtonPink: ColorName.sizeButtonPink,
      shopPageGrey: ColorName.shopPageGrey,
      shopPageBuyGreen: ColorName.shopPageBuyGreen,
      shopPageBlue: ColorName.shopPageBlue,
      shopPagePink: ColorName.shopPagePink,
      totalTextColor: ColorName.totalTextColor,
      paymentTextColor: ColorName.paymentTextColor,
      hideCardNumberGrey: ColorName.hideCardNumberGrey,
      paymentBoxFillGrey: ColorName.paymentBoxFillGrey,
      secondaryBackgroundColor: ColorName.secondaryBackgroundColor,
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      boldBlack: ColorName.boldBlackDark,
      lightBackground: ColorName.boldBlack,
      loginInputHintText: ColorName.loginInputHintTextDark,
      loginInputIconsGrey: ColorName.loginInputIconsGreyDark,
      loginShadowMountain: ColorName.loginShadowMountainDark,
      prevColor: ColorName.prevColorDark,
      selectedPageBlue: ColorName.selectedPageBlue,
      sizzlingRed: ColorName.sizzlingRed,
      splashUltimateGreyText: ColorName.splashUltimateGreyTextDark,
      whiteColor: ColorName.whiteColor,
      facebookBlue: ColorName.facebookBlue,
      drawerBackground: ColorName.drawerBackground,
      searchHintGrey: ColorName.searchHintGrey,
      // Home Page Colors
      homePageDiscountIndicatorPink: ColorName.homePageDiscountIndicatorPink,
      homePageDiscountIndicatorGrey: ColorName.homePageDiscountIndicatorGrey,
      dealOfTheDayBlue: ColorName.dealOfTheDayBlue,
      // Product Colors
      offRedColor: ColorName.offRedColor,
      starNumberGreyColor: ColorName.starNumberGreyColor,
      oldPriceGreyColor: ColorName.oldPriceGreyColor,
      starYellowColor: ColorName.starYellowColor,
      flatAndHeelsBlack: ColorName.flatAndHeelsBlack,
      trendingProductsPink: ColorName.trendingProductsPink,
      bottomAppBarSelectedColor: ColorName.bottomAppBarSelectedColor,
      // Shop Colors
      sizeButtonPink: ColorName.sizeButtonPink,
      shopPageGrey: ColorName.shopPageGrey,
      shopPageBuyGreen: ColorName.shopPageBuyGreen,
      shopPageBlue: ColorName.shopPageBlue,
      shopPagePink: ColorName.shopPagePink,
      totalTextColor: ColorName.totalTextColor,
      paymentTextColor: ColorName.paymentTextColor,
      hideCardNumberGrey: ColorName.hideCardNumberGrey,
      paymentBoxFillGrey: ColorName.paymentBoxFillGrey,
      secondaryBackgroundColor: ColorName.secondaryBackgroundColor,
    );
  }

  @override
  AppColors copyWith({
    Color? boldBlack,
    Color? lightBackground,
    Color? loginInputHintText,
    Color? loginInputIconsGrey,
    Color? loginShadowMountain,
    Color? prevColor,
    Color? selectedPageBlue,
    Color? sizzlingRed,
    Color? splashUltimateGreyText,
    Color? whiteColor,
    Color? facebookBlue,
    Color? drawerBackground,
    Color? searchHintGrey,
    // Home Page Colors
    Color? homePageDiscountIndicatorPink,
    Color? homePageDiscountIndicatorGrey,
    Color? dealOfTheDayBlue,
    // Product Colors
    Color? offRedColor,
    Color? starNumberGreyColor,
    Color? oldPriceGreyColor,
    Color? starYellowColor,
    Color? flatAndHeelsBlack,
    Color? trendingProductsPink,
    Color? bottomAppBarSelectedColor,
    // Shop Colors
    Color? sizeButtonPink,
    Color? shopPageGrey,
    Color? shopPageBuyGreen,
    Color? shopPageBlue,
    Color? shopPagePink,
    Color? totalTextColor,
    Color? paymentTextColor,
    Color? hideCardNumberGrey,
    Color? paymentBoxFillGrey,
    Color? secondaryBackgroundColor,
  }) {
    return AppColors(
      boldBlack: boldBlack ?? this.boldBlack,
      lightBackground: lightBackground ?? this.lightBackground,
      loginInputHintText: loginInputHintText ?? this.loginInputHintText,
      loginInputIconsGrey: loginInputIconsGrey ?? this.loginInputIconsGrey,
      loginShadowMountain: loginShadowMountain ?? this.loginShadowMountain,
      prevColor: prevColor ?? this.prevColor,
      selectedPageBlue: selectedPageBlue ?? this.selectedPageBlue,
      sizzlingRed: sizzlingRed ?? this.sizzlingRed,
      splashUltimateGreyText:
          splashUltimateGreyText ?? this.splashUltimateGreyText,
      whiteColor: whiteColor ?? this.whiteColor,
      facebookBlue: facebookBlue ?? this.facebookBlue,
      drawerBackground: drawerBackground ?? this.drawerBackground,
      searchHintGrey: searchHintGrey ?? this.searchHintGrey,
      // Home Page Colors
      homePageDiscountIndicatorPink:
          homePageDiscountIndicatorPink ?? this.homePageDiscountIndicatorPink,
      homePageDiscountIndicatorGrey:
          homePageDiscountIndicatorGrey ?? this.homePageDiscountIndicatorGrey,
      dealOfTheDayBlue: dealOfTheDayBlue ?? this.dealOfTheDayBlue,
      // Product Colors
      offRedColor: offRedColor ?? this.offRedColor,
      starNumberGreyColor: starNumberGreyColor ?? this.starNumberGreyColor,
      oldPriceGreyColor: oldPriceGreyColor ?? this.oldPriceGreyColor,
      starYellowColor: starYellowColor ?? this.starYellowColor,
      flatAndHeelsBlack: flatAndHeelsBlack ?? this.flatAndHeelsBlack,
      trendingProductsPink: trendingProductsPink ?? this.trendingProductsPink,
      bottomAppBarSelectedColor:
          bottomAppBarSelectedColor ?? this.bottomAppBarSelectedColor,
      // Shop Colors
      sizeButtonPink: sizeButtonPink ?? this.sizeButtonPink,
      shopPageGrey: shopPageGrey ?? this.shopPageGrey,
      shopPageBuyGreen: shopPageBuyGreen ?? this.shopPageBuyGreen,
      shopPageBlue: shopPageBlue ?? this.shopPageBlue,
      shopPagePink: shopPagePink ?? this.shopPagePink,
      totalTextColor: totalTextColor ?? this.totalTextColor,
      paymentTextColor: paymentTextColor ?? this.paymentTextColor,
      hideCardNumberGrey: hideCardNumberGrey ?? this.hideCardNumberGrey,
      paymentBoxFillGrey: paymentBoxFillGrey ?? this.paymentBoxFillGrey,
      secondaryBackgroundColor: secondaryBackgroundColor ?? this.secondaryBackgroundColor,
    );
  }

  //lerp = Linear interpolation (doğrusal geçiş). Flutter temalar arasında geçiş yaparken (ör. Light → Dark)
  // renkleri aniden değiştirmek yerine yumuşak animasyon yapar. t parametresi 0.0 → 1.0 arası bir değerdir:
  //t = 0.0 → tamamen mevcut renk (this) t = 1.0 → tamamen diğer renk (other) Aradaki değerler → iki rengin
  //karışımı Color.lerp(color1, color2, t) iki rengi harmanlar. ThemeData geçişi sırasında Flutter otomatik
  // olarak lerp’i çağırır. Bu sayede dark/light mod geçişleri fade animasyonlu olur.

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      boldBlack: Color.lerp(boldBlack, other.boldBlack, t)!,
      lightBackground: Color.lerp(lightBackground, other.lightBackground, t)!,
      loginInputHintText: Color.lerp(
        loginInputHintText,
        other.loginInputHintText,
        t,
      )!,
      loginInputIconsGrey: Color.lerp(
        loginInputIconsGrey,
        other.loginInputIconsGrey,
        t,
      )!,
      loginShadowMountain: Color.lerp(
        loginShadowMountain,
        other.loginShadowMountain,
        t,
      )!,
      prevColor: Color.lerp(prevColor, other.prevColor, t)!,
      selectedPageBlue: Color.lerp(
        selectedPageBlue,
        other.selectedPageBlue,
        t,
      )!,
      sizzlingRed: Color.lerp(sizzlingRed, other.sizzlingRed, t)!,
      splashUltimateGreyText: Color.lerp(
        splashUltimateGreyText,
        other.splashUltimateGreyText,
        t,
      )!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      facebookBlue: Color.lerp(facebookBlue, other.facebookBlue, t)!,
      drawerBackground: Color.lerp(
        drawerBackground,
        other.drawerBackground,
        t,
      )!,
      searchHintGrey: Color.lerp(
        searchHintGrey,
        other.searchHintGrey,
        t,
      )!,
        // Home Page Colors
      homePageDiscountIndicatorPink: Color.lerp(
        homePageDiscountIndicatorPink,
        other.homePageDiscountIndicatorPink,
        t,
      )!,
      homePageDiscountIndicatorGrey: Color.lerp(
        homePageDiscountIndicatorGrey,
        other.homePageDiscountIndicatorGrey,
        t,
      )!,
      dealOfTheDayBlue: Color.lerp(
        dealOfTheDayBlue,
        other.dealOfTheDayBlue,
        t,
      )!,
      // Product Colors
      offRedColor: Color.lerp(offRedColor, other.offRedColor, t)!,
      starNumberGreyColor: Color.lerp(
        starNumberGreyColor,
        other.starNumberGreyColor,
        t,
      )!,
      oldPriceGreyColor: Color.lerp(
        oldPriceGreyColor,
        other.oldPriceGreyColor,
        t,
      )!,
      starYellowColor: Color.lerp(starYellowColor, other.starYellowColor, t)!,
      flatAndHeelsBlack: Color.lerp(
        flatAndHeelsBlack,
        other.flatAndHeelsBlack,
        t,
      )!,
      trendingProductsPink: Color.lerp(
        trendingProductsPink,
        other.trendingProductsPink,
        t,
      )!,
      bottomAppBarSelectedColor: Color.lerp(
        bottomAppBarSelectedColor,
        other.bottomAppBarSelectedColor,
        t,
      )!,
      // Shop Colors
      sizeButtonPink: Color.lerp(sizeButtonPink, other.sizeButtonPink, t)!,
      shopPageGrey: Color.lerp(shopPageGrey, other.shopPageGrey, t)!,
      shopPageBuyGreen: Color.lerp(
        shopPageBuyGreen,
        other.shopPageBuyGreen,
        t,
      )!,
      shopPageBlue: Color.lerp(shopPageBlue, other.shopPageBlue, t)!,
      shopPagePink: Color.lerp(shopPagePink, other.shopPagePink, t)!,
      totalTextColor: Color.lerp(totalTextColor, other.totalTextColor, t)!,
      paymentTextColor: Color.lerp(
        paymentTextColor,
        other.paymentTextColor,
        t,
      )!,
      hideCardNumberGrey: Color.lerp(
        hideCardNumberGrey,
        other.hideCardNumberGrey,
        t,
      )!,
      paymentBoxFillGrey: Color.lerp(
        paymentBoxFillGrey,
        other.paymentBoxFillGrey,
        t,
      )!,
      secondaryBackgroundColor: Color.lerp(
        secondaryBackgroundColor,
        other.secondaryBackgroundColor,
        t,
      )!,
    );
  }
}
