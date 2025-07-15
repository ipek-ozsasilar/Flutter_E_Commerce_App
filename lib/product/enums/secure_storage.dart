import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_cache.dart';


enum SecureStorageKeys {
  token;

  Future<String> readKeys() async {
    return await getIt<secureStorageSetUp>().storage?.read(key: name) ?? '';
  }

  Future<void> writeKeys(String value) async{
    await getIt<secureStorageSetUp>().storage?.write(key: name, value: value);
  }
}