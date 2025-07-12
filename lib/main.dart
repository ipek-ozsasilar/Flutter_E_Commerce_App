import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
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
      home: const MyHomePage(),
    );
  
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    
      );

  }
}


