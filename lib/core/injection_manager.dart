//product
import 'package:flutter_e_commerce_app/product/initializer/app_cache.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_initiliazer.dart';
import 'package:flutter_e_commerce_app/product/utility/firebase/version_manager.dart';
//get_it
import 'package:get_it/get_it.dart';


//GetIt Flutter/Dart dünyasında Service Locator olarak kullanılan bir paket.
//Service Locator, yazılımda kullanılan bir dependency management (bağımlılık yönetimi) desenidir.
//Amaç: Kodun içinde “hangi sınıf nereden geliyor, nasıl üretiliyor” gibi detaylarla uğraşmak yerine,
//ihtiyacın olduğunda merkezi bir yerden o nesneyi almak. Avantajı: new ile her yerde nesne oluşturmak
//yerine tek bir örnek (singleton) oluşturup ihtiyaç olduğunda çağırmak. Singleton: Uygulama boyunca tek 
//bir örnek. Lazy Singleton: İlk ihtiyaç duyulana kadar oluşturulmaz, böylece başlangıçta gereksiz yere yük bindirmez.

//get it nesnesi oluşturuluyor Service Locator burada oluşturuluyor
final GetIt getItInstance = GetIt.instance;

//main.dart'da runApp çağrısından önce çağrılır
void setupLocator() {
  //lazy, uygulama başladığında hemen oluşturulmaz, gerektiğinde oluşturulur. sadece ilk kez çağırıldığında oluşturulur.
  //örn AppInitializer diye bir servis lazım olursa, şuradaki gibi oluştur” diye kayıt yapıyor.
  getItInstance.registerLazySingleton<AppInitiliazer>(() => AppInitiliazer());
  getItInstance.registerLazySingleton<secureStorageSetUp>(() => secureStorageSetUp());
  getItInstance.registerLazySingleton<VersionManager>(() => VersionManager());
}