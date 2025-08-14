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
  });

  factory AppColors.light() {
    return const AppColors(
      boldBlack: ColorName.boldBlack,
      lightBackground: ColorName.lightBackground,
      loginInputHintText: ColorName.loginInputHintText,
      loginInputIconsGrey: ColorName.loginInputIconsGrey,
      loginShadowMountain: ColorName.loginShadowMountain,
      prevColor: ColorName.prevColor,
      selectedPageBlue: ColorName.selectedPageBlue,
      sizzlingRed: ColorName.sizzlingRed,
      splashUltimateGreyText: ColorName.splashUltimateGreyText,
      whiteColor: ColorName.whiteColor,
      facebookBlue: ColorName.facebookBlue,
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      boldBlack: ColorName.boldBlackDark,
      lightBackground: ColorName.darkBackground,
      loginInputHintText: ColorName.loginInputHintTextDark,
      loginInputIconsGrey: ColorName.loginInputIconsGreyDark,
      loginShadowMountain: ColorName.loginShadowMountainDark,
      prevColor: ColorName.prevColorDark,
      selectedPageBlue: ColorName.selectedPageBlue,
      sizzlingRed: ColorName.sizzlingRed,
      splashUltimateGreyText: ColorName.splashUltimateGreyTextDark,
      whiteColor: ColorName.whiteColor,
      facebookBlue: ColorName.facebookBlue,
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
    );
  }
}
