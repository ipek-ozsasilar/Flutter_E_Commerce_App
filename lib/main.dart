import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/reset_password.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/product/theme/custom_theme_view_model.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/product/initializer/app_initiliazer.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_e_commerce_app/features/login/provider/deeplink_provider.dart';
import 'package:flutter_e_commerce_app/product/theme/theme_provider.dart';

Future<void> main() async {
  //Start get it injection of app
  setupLocator();
  //before starting the app, we need to initialize the app
  await getIt<AppInitiliazer>().init();
  runApp(
    ProviderScope(
      //Bu ayarları burada yapmazsan, EasyLocalization framework’ü hangi dilleri yükleyeceğini
      //ve hangi klasörden JSON dosyalarını okuyacağını bilmez.
      child: EasyLocalization(
        //ingilizce türkçe dil desteği sağlar
        supportedLocales: const [Locale('en'), Locale('tr')],
        //Çeviri dosyalarının bulunduğu klasör
        path: 'assets/translations',
        //Desteklenmeyen dilde kul    lanılacak dili belirtir.
        fallbackLocale: const Locale('en'),
        //Uygulama başlangıç dilini belirtir.
        startLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with CustomThemeViewModel{
  @override
  void initState() {
    super.initState();
    //Bu metot uygulamada derin bağlantı (deep link) dinlemeyi başlatıyor.
    ref
        .read(appLinkProvider.notifier)
        .startListening(
          //onOobCode parametresi bir callback (geri çağırma) fonksiyonu.
          //Eğer deep link içinde oobCode (örneğin Firebase'in şifre sıfırlama kodu) gelirse, bu fonksiyon tetikleniyor
          onOobCode: (oobCode) {
            //Bu satır, gelen oobCode ile kullanıcıyı şifre sıfırlama sayfasına (ResetPassword) yönlendiriyor.
            //context ile sayfa değişikliği yapıyor. ResetPassword widget’ına oobCode parametresi gönderiliyor.
            NavigatorManager.instance.navigatePage(
              context,
              ResetPassword(oobCode: oobCode),
            );
          },
        );
  }

  @override
  void dispose() {
    //Bu metot uygulamada derin bağlantı (deep link) dinlemeyi durduruyor.
    //Kullanıcı uygulamayı kapatırken veya uygulama kapatılırken bu metot çağrılır.
    //startListening() ile uygulama deep linkleri dinlemeye başlıyor (örneğin, kullanıcı bir reset password linkiyle uygulamayı
    //açarsa bunu yakalıyor). stopListening() ise tam tersine, deep link dinlemeyi durduruyor.
    ref.read(appLinkProvider.notifier).stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debug banner gösterme
      debugShowCheckedModeBanner: false,
      title: 'Flutter E-Commerce Application',
      //EasyLocalization yapılandırması burası MaterialApp’e, “Hangi çeviri ayarlarını kullanacağını” söylüyor.
      localizationsDelegates: context.localizationDelegates,
      //Burası MaterialApp’e, “Desteklenen diller” yi söylüyor.
      supportedLocales: context.supportedLocales,
      //Burası MaterialApp’e, Uygulama dilini belirtir yani hangi dili kullanacağını söylüyor.
      locale: context.locale,
      //Uygulama teması
      theme: themeCheck(),
      //Responsive design (mobile, tablet, desktop) için kullanılır.
      //Bu sayede responsive tasarım yapılır, yani uygulama her cihazda iyi görünür ve kullanışlı olur.
      builder: (context, child) => ResponsiveBreakpoints.builder(
        //Buradaki child, MaterialApp'in içindeki asıl uygulama widget’ıdır (yani senin uygulamanın geri kalan kısmı).
        child: child!,
        //breakpoint uygulamanın ekran genişliğine göre farklı davranmasını sağlar.
        breakpoints: [
          //mobile
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          //tablet
          const Breakpoint(start: 451, end: 800, name: TABLET),
          //desktop
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          //4K
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),

      //fixme : apple login ekle ve linking yap facegogole
      home: SplashView(),
      //SplashView(),
    );
  }
}
