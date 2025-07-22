import 'dart:io';

//Platform Enum for get platform name by firebase firestore
enum PlatformEnum {
  android,
  ios;

  static String get platformName {
    if (Platform.isAndroid) {
      return PlatformEnum.android.name;
    } else {
      return PlatformEnum.ios.name;
    }
  }
}
