import 'package:easy_localization/easy_localization.dart' show tr, StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart' show LocaleKeys;
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart' show GlobalElevatedButton;
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart' show NormalText, BoldOnboardingText;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStartedView extends ConsumerWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Assets.images.homeBackground.image(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            color: Theme.of(context).appColors.boldBlack.withOpacity(0.3), // %30 karartma
          ),

          Padding(
            padding: PaddingsConstants.instance.getStartedPagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BoldOnboardingText(
                  title: LocaleKeys.homeTitle.tr(),
                  titleSize: TextSizeEnum.homeTitleSize.value,
                  titleColor: Theme.of(context).appColors.whiteColor,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: PaddingsConstants.instance.getStartedTitlePadding,
                  child: NormalText(
                    text: LocaleKeys.homeDescription.tr(),
                    color: Theme.of(context).appColors.whiteColor,
                    fontSize: TextSizeEnum.homeDescriptionSize.value,
                  ),
                ),
                GlobalElevatedButton(
                  text: LocaleKeys.getStarted.tr(),
                  onPressed: () {
                    NavigatorManager.instance.navigatePage(context,  HomeView());
                  },
                  child: NormalText(
                    text: LocaleKeys.getStarted.tr(),
                    color: Theme.of(context).appColors.whiteColor,
                    fontSize: TextSizeEnum.loginButtonTextSize.value,
                  ),
                  isLoadingEmail: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



/*
Navigasyon olasılığı yüksekse (kullanıcı %80+ Home’a gidecek) → prefetch yap.

Home ağırsa (çok ürün/görsel) → “üstte görünen” kısmı (above-the-fold) önden yükle, kalanları Home’da lazy-load et.

Gerçek zamanlı güncelleme gerekmiyorsa → tek seferlik get() ile ısıt, Home’da cache’ten göster.
Gerçek zamanlı gerekiyorsa Home’da snapshots() aboneliğini başlat.

Firebase/Firestore için notlar

Offline cache/persistence’ı aç: okuma sayısını ve beklemeyi azaltır.

await FirebaseFirestore.instance.setSettings(
  const Settings(persistenceEnabled: true),
);


Sayfalama kullan: limit + startAfterDocument ile.

Aynı sorguyu iki kez okuma: Pre-fetch ettikten sonra aynı veriyi state’te taşı (Provider/Riverpod/BLoC) ve Home’da yeniden okumak yerine onu kullan.

Görselleri önden ısıt (flicker’ı yok et)

Görseller için cache’li widget kullan:

CachedNetworkImage(imageUrl: url); // cached_network_image


Navigasyon öncesi precache:

for (final url in firstPageImageUrls) {
  await precacheImage(NetworkImage(url), context);
}

Uygulama akışı (örnek strateji)

Splash/Login’de başlat:

final homeWarmup = repo.fetchHomeFirstPage(); // Firestore query (limit: 10-20)


Görselleri pre-cache et (yalnızca ilk ekranda gözükecekler):

final urls = (await homeWarmup).map((p) => p.imageUrl).toList();
for (final u in urls) { await precacheImage(NetworkImage(u), context); }


State’e koy ve Home’a aktar:

Navigator.push(context, MaterialPageRoute(
  builder: (_) => HomeScreen(prefetched: await homeWarmup),
));


Riverpod kullanıyorsan: FutureProvider’ı keepAlive yapıp Splash’ta ref.read(provider.future) ile ısıt.

Home tarafı

İlk render’da prefetched veriyi göster, aynı anda arka planda kalan sayfaları çek.

UI için skeleton (placeholder) kullan; spinner yerine içerik iskeleti daha akıcı hissettirir.

Dikkat edilecekler

Navigasyonu bloklama: Prefetch’i başlat ama ekran geçişini bekletme; Home açıldığında veriyi hazır bulsun.

Çifte okuma maliyetine dikkat: Aynı sorguyu hem önceki ekranda hem Home’da yapma; ısıtılmış sonucu paylaş.

Web hedefliyorsan persistence varsayılan olmayabilir; açıkça etkinleştir.



 */