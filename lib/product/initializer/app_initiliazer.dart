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

//before app start initialize configurations
class AppInitiliazer {
  AppInitiliazer();

  Future<void> init() async {
    //Start flutter binding of app
    await WidgetsFlutterBinding.ensureInitialized();
    //Start firebase of app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //Configure firebase auth providers
    firebaseAuthUI.FirebaseUIAuth.configureProviders([
      firebaseAuthUI.EmailAuthProvider(),
      //Google gibi OAuth sağlayıcıları, hangi uygulamanın Google ile giriş yapmaya çalıştığını bilmek ister.
      GoogleProvider(
        clientId: const String.fromEnvironment(
          'GOOGLE_CLIENT_ID_ANDROID',
          defaultValue:
              '631494873953-k4oabd7l6a6fq5tm5h538i6j79tafm2g.apps.googleusercontent.com',
        ),
      ),
      // AppleProvider(),
      FacebookProvider(
        clientId: const String.fromEnvironment(
          'FACEBOOK_APP_ID',
          defaultValue: '1909138999942825',
        ),
      ),
    ]);
    //Start easy localization of app
    await EasyLocalization.ensureInitialized();
    //started secure storage instance for caching data
    await getIt<secureStorageSetUp>().setUp();
  }
}

// Environment Variables kullanımı:
// flutter run --dart-define=GOOGLE_CLIENT_ID_ANDROID=your-real-id
// flutter run --dart-define=FACEBOOK_APP_ID=your-real-id

// Default values (development için)
// android: 631494873953-k4oabd7l6a6fq5tm5h538i6j79tafm2g.apps.googleusercontent.com
// web: 631494873953-o680qu8537u4u9g8jdk2e36tjrtjibnv.apps.googleusercontent.com
//flutter build apk --dart-define=GOOGLE_CLIENT_ID_ANDROID=prod-id --dart-define=FACEBOOK_APP_ID=prod-id
