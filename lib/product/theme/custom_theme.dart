import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';

//Custom Theme for app main theme
class CustomTheme {
  static ThemeData get theme => ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: ColorName.lightBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      );
}