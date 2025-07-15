import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebaseAuthUI;
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/firebase_options.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_cache.dart';


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
    await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseAuthUI.FirebaseUIAuth.configureProviders([
      firebaseAuthUI.EmailAuthProvider(),
      GoogleProvider(clientId: ''),
      AppleProvider(),
      FacebookProvider(clientId: ''), 
      ]);
    await EasyLocalization.ensureInitialized();
    //started secure storage instance
    await getIt<secureStorageSetUp>().setUp();


  
  }
}