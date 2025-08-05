import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/forgot_password.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/product/theme/custom_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_initiliazer.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';

Future<void> main() async {
  //Start get it injection of app
  setupLocator();
  //before starting the app, we need to initialize the app
  await getIt<AppInitiliazer>().init();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('tr')],
        path: 'assets/translations',
        //Default language when translations are missing or language is not supported
        fallbackLocale: const Locale('en'),
        //Support english language for beginning of app
        startLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //don't show debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter E-Commerce Application',
      //EasyLocalization configuration
      localizationsDelegates: context.localizationDelegates,

      supportedLocales: context.supportedLocales,
      locale: context.locale,
      //Custom Theme for app
      theme: CustomTheme.theme,
      //Responsive Breakpoints for app
      builder: (context, child) => ResponsiveBreakpoints.builder(
        //child
        child: child!,
        //breakpoints
        breakpoints: [
          //mobile
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          //tablet
          const Breakpoint(start: 451, end: 800, name: TABLET),
          //desktop
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          //4K
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: const LoginWelcomeBack(),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Giriş yapılmışsa ana sayfa
      return const HomeView();  // Buraya kendi Home sayfanı koy
    } else {
      // Giriş yapılmamışsa login ekranı
      return const LoginWelcomeBack();
    }
  }
}
