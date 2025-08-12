import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_extension.dart';
import 'package:flutter_e_commerce_app/product/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Custom Theme for app main theme

mixin CustomThemeViewModel<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  ThemeMode get themeMode => ref.watch(themeStateProvider).themeMode;

  ThemeData themeCheck() {
    if (themeMode == ThemeMode.light) {
      return ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: AppColors.light().lightBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        extensions: <ThemeExtension<dynamic>>[AppColors.light()],
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      );
    }

    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      scaffoldBackgroundColor: AppColors.dark().lightBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      extensions: <ThemeExtension<dynamic>>[AppColors.dark()],
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }
}
