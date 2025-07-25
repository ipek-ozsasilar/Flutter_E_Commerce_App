import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_cache.dart';

//Secure Storage Keys Enum for get secure storage saving and reading
enum SecureStorageKeys {
  hasSeenOnboarding,
  token;

  Future<String> readKeys() async {
    return await getIt<secureStorageSetUp>().storage?.read(key: name) ?? '';
  }

  Future<void> writeKeys(String value) async {
    await getIt<secureStorageSetUp>().storage?.write(key: name, value: value);
  }
}
