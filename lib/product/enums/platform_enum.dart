import 'dart:io';

enum PlatformEnum{
  android,
  ios;

  static String get platformName{
      if (Platform.isAndroid) {
        return PlatformEnum.android.name;
      }else{
        return PlatformEnum.ios.name;
      }
  }
}