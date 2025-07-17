import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_initiliazer.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
        fallbackLocale: const Locale('en'),
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
      title: 'Flutter E-Commerce Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
       builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
           const Breakpoint(start: 0, end: 450, name: MOBILE),
           const Breakpoint(start: 451, end: 800, name: TABLET),
           const Breakpoint(start: 801, end: 1920, name: DESKTOP),
           const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: const SplashView(),
    );
  
  }
}


