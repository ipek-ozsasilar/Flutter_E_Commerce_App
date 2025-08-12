import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
// import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart'
    hide FormState;
import 'package:flutter_e_commerce_app/features/login/view_model/forgot_password_view_model.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
// import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/login_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/input/login_input.dart';
import 'package:flutter_e_commerce_app/product/widget/text/rich_text.dart';
// import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword>
    with ForgotPasswordViewModel {
  late TapGestureRecognizer _tapGestureRecognizer;
  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () =>
          NavigatorManager.instance.navigatePage(context, ForgotPassword());
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = ref
        .watch(formProvider.notifier)
        .forgotPasswordController;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar:
          CustomAppbarLogin(
                title: LocaleKeys.forgotPassword.tr(),
                showBackButton: true,
                clearFunction: clearForgotPassword,
              )
              as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              loginInput(
                hintText: LocaleKeys.enterYourEmail.tr(),
                prefixIcon: Icons.email_rounded,
                suffixIcon: AnimatedIcons.close_menu,
                color: Theme.of(context).appColors.loginInputIconsGrey,
                formKey: _formKey,
                controller: forgotPasswordController,
                inputType: LoginInputType.email,
              ),

              Padding(
                padding: PaddingsConstants.instance.forgotPasswordDetailPadding,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichTextWidget(
                    tapGestureRecognizer: _tapGestureRecognizer,
                    text: "*",
                    secondText: LocaleKeys.forgotPasswordDetail.tr(),
                  ),
                ),
              ),

              //SHA-256 Parmak İzi bir tür kriptografik özet fonksiyonudur (hash function).
              //Parmak izi (fingerprint) ise, bir dosya, sertifika veya anahtarın benzersiz kısa tanımlayıcısıdır.
              //Android uygulamalar ve güvenlik sistemlerinde, uygulamanın imzalanmış olduğunu doğrulamak için kullanılır.
              //Örneğin, senin Android uygulamanın .apk dosyasını imzalayan keystore (anahtar deposu) dosyasının SHA-256 özetidir.
              //Neden Önemli Google ve Facebook gibi platformlar, uygulamanın gerçek sahibi sen misin, doğrulamak için bu SHA-256
              //fingerprint’ini ister. Böylece, senin uygulamanla dışarıdan biri aynı package name ile sahte uygulama yapamaz.
              //Özellikle Facebook Login, Google Sign-In, Firebase App Check, API erişimleri gibi güvenlik hassasiyeti olan işlemlerde kullanılır.
              //Uygulama imzalanması(app signing), Android veya iOS uygulama dosyasına (APK, AAB veya IPA) benzersiz bir dijital
              //imza ekleme işlemidir. Bu imza, uygulamanın geliştiricisini doğrular ve uygulamanın değiştirilmediğini garanti eder.
              //İmza, kriptografik yöntemlerle oluşturulmuş bir kimlik belgesidir.İmzalanmış uygulama, cihaz veya mağaza tarafından
              //“bu uygulama gerçekten belirli geliştirici tarafından yapılmıştır” diye tanınır. Uygulama dosyası indirilip
              //değiştirildiğinde imza bozulur, böylece kötü amaçlı yazılımlar tespit edilir. Geliştirme aşamasında: Android’de
              //Android Studio otomatik olarak debug keystore ile imzalar (geliştirme imzası). Bu imza sadece geliştirme ve test içindir.
              //Yayın aşamasında: Yayın için kendi release keystore dosyan ile uygulamanı imzalaman gerekir.Bu imza, Google Play ve App Store’a yüklerken gereklidir.

              //App Links, Android cihazlarda çalışan özel bir derin bağlantı (deep link) türüdür.
              //Amaç: Kullanıcının bir web linkine tıkladığında, o linke bağlı mobil uygulamanın açılmasıdır.
              //Örneğin Kullanıcı https://seninapp.com/reset linkine tıkladığında, bu link tarayıcı yerine doğrudan uygulaman açılır.
              //Eğer uygulama yüklüyse, Android App Links / iOS Universal Links sayesinde doğrudan uygulaman açılacak,
              //Uygulama açılır açılmaz bu linki yakalamak gerekiyor.
              //Eğer link dinleme kodu sadece belirli bir sayfada (örneğin ResetPage) olursa, Uygulama linkle açıldığında, önce
              //o sayfaya yönlendirme yapılmadan link yakalanamaz Çünkü linki yakalayacak kod çalışmadan kullanıcı doğrudan ResetPage'e gitmez.
              GlobalElevatedButton(
                text: LocaleKeys.submit.tr(),
                onPressed: () async {
                  forgotPasswordCheck();
                },
                isLoadingEmail: listenLoading(),
                child: loadingWidgetCheck(LocaleKeys.submit.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
