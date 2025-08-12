import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';

//Deep link (uygulama dışı bağlantılar) dinleyicisini yöneten provider. Deep link, mobil uygulamada belirli bir içeriğe doğrudan
//erişmek için kullanılan özel URL’lerdir.Sadece uygulama yüklüyse açılır. Android ve iOS’ta bu scheme’lerin farklı konfigürasyonları
//gerekir. Tarayıcıdan tıklandığında bazen açılmaz veya hata verir.

//Deep Link (Custom Scheme) URL yapısı	myapp://something (özel protokol),app link https://www.siten.com/something (normal web
// URL’si) deep link Çalışma şekli	Telefon, custom scheme’i tanırsa uygulamayı açar app link	Telefon uygulama yüklüyse link
//uygulamayı açar, değilse web sayfası açılır deeplink Kullanıcı deneyimi	Eski tip, bazen link çalışmayabilir	app link Daha yeni,
// sorunsuz, hem web hem uygulama deneyimi var deeplink Kurulum gereksinimi	Cihazda uygulama yüklü olmalı, yoksa link hata verir
//applink	Aynı, ama yüklü değilse web sayfasına yönlendirme olur

//App Link (Android) ve Universal Link (iOS), HTTP/HTTPS tabanlı linklerdir. Yani, normal web linki gibi görünürler
//Ama cihazda uygulama yüklüyse, bu link doğrudan uygulamayı açar ve ilgili içeriğe yönlendirir. Eğer uygulama yüklü değilse,
//link web sayfasını açar. Kullanıcı deneyimi çok daha iyi. Web ve uygulama arasında sorunsuz geçiş sağlar. Daha güvenli ve modern bir yöntemdir.

typedef OobCodeHandler = void Function(String oobCode);

class AppLinkState extends Equatable {
  final String? oobCode;
  AppLinkState({this.oobCode});

  AppLinkState copyWith({String? oobCode}) {
    return AppLinkState(oobCode: oobCode ?? this.oobCode);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [oobCode];
}

class AppLinkNotifier extends StateNotifier<AppLinkState> {
  AppLinkNotifier() : super(AppLinkState());
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  //Bu metot uygulamada derin bağlantı (deep link) dinlemeyi başlatıyor.
  //Deep link: Kullanıcının uygulamayı özel bir linkten (örneğin bir e-posta şifre sıfırlama linki) açması demek.
  Future<void> startListening({required OobCodeHandler onOobCode}) async {
    // Handle initial uri
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleUri(initialUri, onOobCode);
      }
    } on PlatformException {
      // ignore
    } on FormatException {
      // ignore
    }

    // Listen for subsequent links
    _subscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _handleUri(uri, onOobCode);
      },
      onError: (err) {
        // ignore
      },
    );
  }

  //Uygulama, Firebase Auth API’sine oobCode + yeni şifreyi birlikte gönderir. Firebase:
  //oobCodeyu doğrular (geçerli mi, süresi doldu mu vs), Geçerliyse kullanıcının şifresini günceller.
  Future<void> PasswordReset(String oobCode, String newPassword) async {
    await FirebaseAuth.instance.confirmPasswordReset(
      code: oobCode,
      newPassword: newPassword,
    );
  }

  String? get oobCode => state.oobCode;

  String? oobCodeEmptyCheck() {
    final currentOobCode = state.oobCode;
    if (currentOobCode == null || currentOobCode.isEmpty) {
      return null;
    }
    return currentOobCode;
  }

  void _handleUri(Uri uri, OobCodeHandler onOobCode) {
    final oobCode = uri.queryParameters['oobCode'];
    if (oobCode != null && oobCode.isNotEmpty) {
      state = state.copyWith(oobCode: oobCode);
      onOobCode(oobCode);
    }
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}

final appLinkProvider = StateNotifierProvider<AppLinkNotifier, AppLinkState>(
  (ref) => AppLinkNotifier(),
);
