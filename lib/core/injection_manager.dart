import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

//called before runapp in main.dart
void setupLocator() {
  //getIt.registerLazySingleton<MyService>(() => MyServiceImpl());
}