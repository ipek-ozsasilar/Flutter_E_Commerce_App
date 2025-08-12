import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/deeplink_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin ResetPasswordViewModel<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final Logger _logger = Logger();

  void resetPasswordCheck() async {
    final oobCode = ref.read(appLinkProvider.notifier).oobCodeEmptyCheck();
    if (oobCode == null) {
      showSnackBar(context, 'Geçersiz veya eksik sıfırlama kodu.');
      return;
    }

    try {
      // 1. İnternet kontrolü
      final connectionResult = await ref
          .read(connectionProvider.notifier)
          .checkInternetConnection();
      if (!connectionResult) {
        _logger.w('İnternet bağlantısı yok');
        showSnackBar(context, 'İnternet bağlantısı yok');
        return;
      }

      final resetPasswordEmptyResult = ref
          .read(formProvider.notifier)
          .checkResetPasswordEmailEmpty();
      if (resetPasswordEmptyResult) {
        showSnackBar(context, 'Şifre alanı boş olamaz');
        return;
      }

      final passwordLengthResult = ref
          .read(formProvider.notifier)
          .checkPasswordLength();
      final confirmPasswordLengthResult = ref
          .read(formProvider.notifier)
          .checkConfirmPasswordLength();
      if (!passwordLengthResult || !confirmPasswordLengthResult) {
        showSnackBar(context, 'Şifre en az 6 karakter olmalıdır');
        return;
      }

      final passwordSameResult = ref
          .read(formProvider.notifier)
          .passwordsSame();
      if (!passwordSameResult) {
        showSnackBar(context, 'Şifreler eşleşmiyor');
        return;
      }
      //Uygulama, Firebase Auth API’sine oobCode + yeni şifreyi birlikte gönderir. Firebase:
      //oobCodeyu doğrular (geçerli mi, süresi doldu mu vs), Geçerliyse kullanıcının şifresini günceller.
      await ref
          .read(appLinkProvider.notifier)
          .PasswordReset(
            ref.watch(appLinkProvider).oobCode!,
            //yeni şifre
            ref.read(formProvider.notifier).passwordController.text,
          );

      showSnackBar(context, 'Şifre sıfırlama başarılı');
      NavigatorManager.instance.navigatePage(context, LoginWelcomeBack());
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'Bir hata oluştu');
    } finally {
      ref.read(authProvider.notifier).setLoadingEmail(false);
    }
  }

  void clearTextForgotPassword() {
    ref.read(formProvider.notifier).clearTextForgotPassword();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool listenLoading() {
    return ref.watch(authProvider).isLoadingEmail;
  }

  Widget loadingWidgetCheck(String text) {
    return ref.watch(authProvider).isLoadingEmail
        ? CircularProgressIndicator(
            color: Theme.of(context).appColors.whiteColor,
          )
        : NormalText(
            text: text,
            color: Theme.of(context).appColors.whiteColor,
            fontSize: TextSizeEnum.loginButtonTextSize.value,
          );
  }
}
