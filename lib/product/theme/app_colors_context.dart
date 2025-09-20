import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_extension.dart';

extension AppColorsThemeDataX on ThemeData {
  AppColors get appColors => extension<AppColors>() ?? AppColors.light();
}
