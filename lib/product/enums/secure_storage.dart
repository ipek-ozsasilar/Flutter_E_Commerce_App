import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_cache.dart';

//Secure Storage Keys Enum for get secure storage saving and reading
enum SecureStorageKeys {
  hasSeenOnboarding,
  token,
  localeLanguage;

  Future<String> readKeys() async {
    return await getItInstance<secureStorageSetUp>().storage?.read(key: name) ?? '';
  }

  Future<void> writeKeys(String value) async {
    await getItInstance<secureStorageSetUp>().storage?.write(
      key: name,
      value: value,
    );
  }

  static Future<void> setLocale(Locale locale) async {
    await getItInstance<secureStorageSetUp>().storage?.write(
      key: SecureStorageKeys.localeLanguage.name,
      value: locale.languageCode,
    );
  }


  static Future<Locale?> getSavedLocale() async {
    final String? code = await getItInstance<secureStorageSetUp>().storage
        ?.read(key: SecureStorageKeys.localeLanguage.name);
    if (code == null || code.isEmpty) return null;
    return Locale(code);
  }


}

