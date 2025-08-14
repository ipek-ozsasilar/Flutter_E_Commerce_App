//dart
import 'dart:async';
//equatable
import 'package:equatable/equatable.dart';
//firebase_auth
import 'package:firebase_auth/firebase_auth.dart';
//flutter
import 'package:flutter/services.dart';
//flutter_riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
//app_links
import 'package:app_links/app_links.dart';
import 'package:logger/logger.dart';

//Deep link (uygulama dışı bağlantılar) dinleyicisini yöneten provider. Deep link, mobil uygulamada belirli bir içeriğe doğrudan
//erişmek için kullanılan özel URL’lerdir.Sadece uygulama yüklüyse açılır. Android ve iOS’ta bu scheme’lerin farklı konfigürasyonları
//gerekir. Tarayıcıdan tıklandığında bazen açılmaz veya hata verir.
//Yani Deep link URL’dir, App Link ise Android’in bunu otomatik olarak uygulama ile eşleştirme özelliğidir.
//Sen deep link kodunu App Link sayesinde otomatik olarak uygulamada yakalayabilirsin.

//Deep Link (Custom Scheme) URL yapısı	myapp://something (özel protokol),app link https://www.siten.com/something (normal web
// URL’si) deep link Çalışma şekli	Telefon, custom scheme’i tanırsa uygulamayı açar app link	Telefon uygulama yüklüyse link
//uygulamayı açar, değilse web sayfası açılır deeplink Kullanıcı deneyimi	Eski tip, bazen link çalışmayabilir	app link Daha yeni,
// sorunsuz, hem web hem uygulama deneyimi var deeplink Kurulum gereksinimi	Cihazda uygulama yüklü olmalı, yoksa link hata verir
//applink	Aynı, ama yüklü değilse web sayfasına yönlendirme olur

//App Link (Android) ve Universal Link (iOS), HTTP/HTTPS tabanlı linklerdir. Yani, normal web linki gibi görünürler
//Ama cihazda uygulama yüklüyse, bu link doğrudan uygulamayı açar ve ilgili içeriğe yönlendirir. Eğer uygulama yüklü değilse,
//link web sayfasını açar. Kullanıcı deneyimi çok daha iyi. Web ve uygulama arasında sorunsuz geçiş sağlar. Daha güvenli ve modern bir yöntemdir.
//Kullanıcı deep link’e tıkladığında her zaman reset sayfasında olmayabilir. Hatta uygulama tamamen kapalı olabilir.
//O yüzden dinleyici sadece reset sayfasında olursa, kullanıcı o sayfada değilse link yakalanmaz. Bu da linkin çalışmamasına yol açar.
//Bu yüzden dinleme en üstte olmalı ki uygulama nereden başlarsa başlasın link yakalansın.

//Buradaki oobCode Firebase’in oluşturduğu tek kullanımlık güvenlik kodudur.Kullanıcı bu linke tıkladığında:
//Web uygulamasıysa direkt Firebase ile konuşur. Mobil uygulamaysa deep link ile uygulama açılır ve oobCode uygulamaya taşınır.
//Uygulama, bu oobCode’u alır ve Firebase Auth’a: "Bu kod geçerli mi?" diye sorabilir. Geçerliyse confirmPasswordReset() ile yeni şifreyi gönderebilir
//Bu kod olmazsa Firebase kimin şifresini değiştireceğini bilemez.

//Neden stream kullanıyoruz deeplink’te? Stream, sürekli veri akışı için uygundur:
//Deep linkler birden fazla kere gelebilir (uygulama açıkken kullanıcı farklı linklere tıklayabilir).
//Bu nedenle sürekli dinlemek gerekir — Stream tam bunun için uygun.
//app_links.uriLinkStream zaten bir Stream<Uri> döndürüyor: her yeni link geldiğinde bir Uri olayı yayılıyor.
//Eğer tek seferlik, sadece uygulama açılırken ilk linki alsaydık, Stream yerine Future kullanırdık.
//Ama burada durum farklı: uygulama açıkken linkler gelebiliyor, o yüzden sürekli dinlemek lazım.

//Kullanıcı uygulamayı açtı → ilk link geldi → işledik.
//Ama uygulama açıkken kullanıcı farklı bir linke tıklayabilir.
//Bu durumda biz tekrar “dinleme” başlatmak istemiyoruz.
//Bunun yerine Stream ile sürekli gelen linkleri otomatik yakalıyoruz.

//Kullanıcı https://myapp.com/product/123 linkine tıklar.
//Android bakar: “Bu domain için bir App Link doğrulaması yapılmış mı?”
//https://myapp.com/.well-known/assetlinks.json dosyasını indirir.
//Dosyadaki fingerprint ile cihazdaki uygulamanın imzasını karşılaştırır.
//Eşleşirse → Tarayıcı yerine direkt uygulama açılır.

//Domain = internet adresi. Örnek: myapp.com , Hosting = dosyalarımızın internette durduğu sunucu.
//Bir web sitesi veya JSON dosyası göstermek için bir yere yüklemen gerekir. Bu “yer” = hosting hizmeti.
//Domain’i hosting’e yönlendirirsin (DNS ayarları ile).Böylece kullanıcı https://myapp.com yazınca hosting’deki dosyalar gösterilir.
//Örnek: Domain: myapp.com, Hosting: Firebase Hosting, DNS ayarları → myapp.com adresi Firebase’e bağlanır.
//assetlinks.json dosyasını Firebase Hosting’e koyarsın → Android buradan https://myapp.com/.well-known/assetlinks.json adresinden indirir.

//onOobCode callback’inin tipi. Bu fonksiyon bir String (oobCode) alır ve hiçbir şey döndürmez.
//(Genelde yönlendirme için kullanılır.) "OobCodeHandler adını verdiğimiz fonksiyon tipi, bir adet
// String parametre alır (oobCode) ve geri dönüş değeri yoktur (void)."
//Artık her yerde void Function(String) yazmak yerine, OobCodeHandler yazabilirsin.
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
  //AppLinks, uygulamada derin bağlantı (deep link) dinlemeyi sağlayan bir paket.
  final AppLinks _appLinks = AppLinks();
  //StreamSubscription, bir Stream’e abone olmak için kullanılan bir sınıf.
  //Stream<T>: zaman içinde birden çok değer yayımlayan asenkron bir veri kaynağıdır.
  //sıralı (veya zaman içinde oluşan) birden çok olay Bu subscription ile: Olayları dinleyebilir (onData),
  //Dinlemeyi iptal edebilir (cancel()), Duraklatıp devam ettirebilirsin.
  //Buradaki Uri aslında Stream’in yaydığı veri tipini gösteriyor Bu subscription, Uri tipinde veriler yayınlayan bir Stream’e abone olur.
  StreamSubscription<Uri>? _subscription;

  //Bu metot uygulamada derin bağlantı (deep link) dinlemeyi başlatıyor.
  //Deep link: Kullanıcının uygulamayı özel bir linkten (örneğin bir e-posta şifre sıfırlama linki) açması demek.
  Future<void> startListening({required OobCodeHandler onOobCode}) async {
    try {
      //İlk açılışta gelen linki yakalama
      //Eğer uygulama tamamen kapalıyken açıldıysa ve deep link ile tetiklendiyse burası çalışır.

      //İlk açılışta gelen linki yakalar alır Eğer uygulama zaten açıksa: “ilk açılış linki” yoktur, dolayısıyla getInitialLink() null döner.
      final initialUri = await _appLinks.getInitialLink();
      //Eğer uygulama normal şekilde açıldıysa veya link yoksa: null döner.
      if (initialUri != null) {
        _handleUri(initialUri, onOobCode);
      }
    } catch (e) {
      Logger().e("Beklenmeyen bir hata oluştu: $e");
    }

    //Uygulama açıkken linkleri dinleme
    //Eğer uygulama açıkken deep link ile tetiklendiyse burası çalışır.

    //uriLinkStream bir Stream<Uri> döner: uygulama açıkken (veya arka plandayken) gelen her yeni deep link için bir Uri olayı yayar.
    //.listen(...) ile bu stream’e abone oluyoruz; gelen her uri için _handleUri çağrılıyor.
    //app_links.uriLinkStream zaten Stream: Bu hazır API zaten yeni bir link geldiğinde Stream'e yeni bir Uri yayar.
    // Biz de ona abone olup her yeni link geldiğinde işlem yaparız.
    _subscription = _appLinks.uriLinkStream.listen(
      //Her yeni link geldiğinde (uri) { ... } callback’i tetiklenir.
      (uri) {
        //Gelen URI’yi alıp uygulama içinde uygun sayfaya yönlendirir.
        _handleUri(uri, onOobCode);
      },
      onError: (err) {
        Logger().e("Beklenmeyen bir hata oluştu: $err");
      },
    );
  }

  Future<void> PasswordReset(String oobCode, String newPassword) async {
    //Uygulama, Firebase Auth API’sine oobCode + yeni şifreyi birlikte gönderir. Firebase:
    //oobCodeyu doğrular (geçerli mi, süresi doldu mu vs), Geçerliyse kullanıcının şifresini günceller.
    //Firebase kodu doğrularsa şifreyi değiştirir.
    await FirebaseAuth.instance.confirmPasswordReset(
      code: oobCode,
      newPassword: newPassword,
    );
  }


  //basit null/empty kontrolü döndürüyor
  String? oobCodeEmptyCheck() {
    final currentOobCode = state.oobCode;
    if (currentOobCode == null || currentOobCode.isEmpty) {
      return null;
    }
    return currentOobCode;
  }

  //URI içinden oobCode çıkarma URI’nin query string’inden oobCode değerini çıkartır.
  //Linkin query parametrelerinden oobCode çekilir. State içine kaydedilir.
  //Callback fonksiyonu tetiklenir → kullanıcı reset sayfasına gider.
  //Peki neden yakalıyoruz? Çünkü mobil uygulamalarda deep link ile gelen oobCode’u bizim uygulamamızın kendisi Firebase’e göndermeli.
  void _handleUri(Uri uri, OobCodeHandler onOobCode) {
    final oobCode = uri.queryParameters['oobCode'];
    if (oobCode != null && oobCode.isNotEmpty) {
      state = state.copyWith(oobCode: oobCode);
      //Bu callback tipik olarak UI tarafında navigate işlemi yapar
      onOobCode(oobCode);
    }
  }

  //Stream aboneliğini iptal eder. Önemli: uygulama kapanırken veya notifier dispose edilirken aboneliği
  //iptal etmelisin; aksi halde memory leak veya beklenmeyen davranış olabilir.
  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}

final appLinkProvider = StateNotifierProvider<AppLinkNotifier, AppLinkState>(
  (ref) => AppLinkNotifier(),
);

/*
Kullanıcı "şifremi unuttum" →
Firebase oobCode ile link gönderir →
Kullanıcı linke tıklar →
Uygulama deep link ile açılır →
oobCode yakalanır →
Uygulama reset şifre ekranı açar →
Kullanıcı yeni şifreyi girer →
oobCode + yeni şifre Firebase’e gönderilir →
Firebase doğrular ve şifreyi günceller.
 */
