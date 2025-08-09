import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:logger/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_e_commerce_app/features/login/view_model/google_view_model.dart';

mixin FacebookViewModel<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final _logger = Logger();

  //Eğer cihazda Facebook uygulaması yüklü ve kullanıcı giriş yapmışsa:
  //Doğrudan Facebook hesabını seçtirir (veya otomatik giriş yapar).
  //Eğer cihazda Facebook uygulaması yoksa veya giriş yapılmamışsa:
  //WebView veya tarayıcı açılır, Facebook giriş sayfası (kullanıcı adı/şifre ile) gösterilir.

  //AppEventsLogger.activateApp(application) Facebook App Events (Uygulama Etkinlikleri) sistemini etkinleştirir.
  //Facebook’a kullanıcıların uygulama içi davranışlarıyla ilgili veri gönderilmesini sağlar (örneğin: uygulama
  //açıldı, satın alma yapıldı vs.).Facebook Analytics veya reklam performans takibi yapmak istiyorsan bu önemli.

  //Flutter’da neden direkt yazamadık?	Flutter, arka planda native platformlarda (Android’de Kotlin/Java, iOS’ta
  //Swift/Obj-C) çalışır. Bazı SDK’lar (Facebook gibi) native kodlara ihtiyaç duyar.onCreate() neden kullanıldı?
  //Android uygulaması başlatıldığında ilk tetiklenen yer burasıdır. Facebook SDK başlatma işlemi uygulama başında
  //bir kez yapılmalıdır, o yüzden buraya yazılır. Flutter tarafında çağrılırsa olur mu?	Flutter tarafı tek başına
  //yeterli değildir çünkü SDK native'de çalışır. Sadece Flutter kodu yazarsan Facebook SDK etkinleşmez, veri gitmez.

  // Facebook auth cache'ini temizle
  Future<void> clearFacebookAuthCache() async {
    try {
      await ref.read(authProvider.notifier).clearFacebookAuthCache();
      _logger.i('Facebook auth cache temizlendi');
    } catch (e) {
      _logger.w('Facebook cache temizleme hatası: $e');
    }
  }

  void facebookLoginCheck() async {
    try {
      final user = await ref.read(authProvider.notifier).signInWithFacebook();
      if (user != null) {
        NavigatorManager.instance.navigatePage(context, HomeView());
      } else {
        showSnackBar(context, 'Facebook girişi iptal edildi veya başarısız.');
      }
    } on FirebaseAuthException catch (e) {
      _logger.w('Firebase hatası: ${e.code}');

      //fix me : linking işlemi ekle
      if (e.code == 'account-exists-with-different-credential') {

        showSnackBar(context, 'Bu e-posta ile kayıtlı hesap var zaten.');
        // Diğer providerlar için benzer işlemler yapılabilir
      }
      if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Geçersiz kimlik bilgisi.');
      }
      if (e.code == 'user-disabled') {
        showSnackBar(context, 'Bu hesap devre dışı bırakılmış.');
      }
    } catch (e) {
      _logger.w('Genel hata: $e');
      showSnackBar(context, 'Beklenmeyen bir hata oluştu.');
    } finally {
      ref.read(authProvider.notifier).setLoadingFacebook(false);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool listenLoading() {
    return ref.watch(authProvider).isLoadingFacebook;
  }

  Widget facebookLoadingWidgetCheck() {
    return ref.watch(authProvider).isLoadingFacebook
        ? const CircularProgressIndicator(color: ColorName.sizzlingRed)
        : Icon(Icons.facebook_outlined, color: ColorName.facebookBlue);
  }
}
