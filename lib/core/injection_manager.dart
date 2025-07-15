import 'package:flutter_e_commerce_app/product/initializer/app_cache.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_initiliazer.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

//called before runapp in main.dart
void setupLocator() {
  //When you use lazy, the object is created only when needed, not immediately when the application starts.
  getIt.registerLazySingleton<AppInitiliazer>(() => AppInitiliazer());
  getIt.registerLazySingleton<secureStorageSetUp>(() => secureStorageSetUp());
}