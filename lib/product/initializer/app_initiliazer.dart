import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


//init services
    //init repositories
    //init usecases
    //init blocs
    //init views
    //init routes
    //init localization

class AppInitiliazer {
   AppInitiliazer();

  Future<void> init() async {
    //Start flutter binding of app
    await WidgetsFlutterBinding.ensureInitialized();
    //Start localization of app
    await EasyLocalization.ensureInitialized();
  
  }
}