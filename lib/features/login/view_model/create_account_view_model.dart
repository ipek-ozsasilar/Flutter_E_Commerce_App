import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin CreateAccountViewModel<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final Logger _logger = Logger();

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

  void createAccountCheck(BuildContext context) async {
    try {
      // 1. İnternet kontrolü
      final connectionResult = await ref
          .read(connectionProvider.notifier)
          .checkInternetConnection();
      if (!connectionResult) {
        _logger.w('İnternet bağlantısı yok');
        showSnackBar(context, LocaleKeys.noInternetConnectionError.tr());
        return;
      }

      // 2. Form kontrolü
      final emptyEmailAndPasswordResult = ref
          .read(formProvider.notifier)
          .checkEmptyEmailAndPassword();
      if (emptyEmailAndPasswordResult) {
        _logger.w('Email veya password boş');
        showSnackBar(context, LocaleKeys.emailOrPasswordEmpty.tr());
        return;
      }

      final passwordsSameResult = ref
          .read(formProvider.notifier)
          .passwordsSame();
      if (!passwordsSameResult) {
        _logger.w('Şifreler eşleşmiyor');
        showSnackBar(context, LocaleKeys.passwordFieldEmpty.tr());
        return;
      }

      // 3. Firebase create account
      final user = await ref
          .read(authProvider.notifier)
          .createAccountWithEmailAndPassword();
      if (user == null) {
        _logger.w('Kullanıcı oluşturma başarısız');
        showSnackBar(context, LocaleKeys.loginFailedCheckCredentials.tr());
        return;
      } else {
        _logger.w('Kullanıcı oluşturma başarılı');
        user.sendEmailVerification();
        showSnackBar(context, LocaleKeys.emailVerificationSentToMail.tr());
        NavigatorManager.instance.navigatePage(context, LoginWelcomeBack());
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, LocaleKeys.passwordFieldEmpty.tr());
        return;
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, LocaleKeys.emailAlreadyInUse.tr());
        return;
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, LocaleKeys.invalidEmailAddress.tr());
        return;
      }
      showSnackBar(context, LocaleKeys.errorTryAgainLater.tr());
      return;
    } finally {
      ref.read(authProvider.notifier).setLoadingEmail(false);
    }
  }

  void changeObscureText() {
    ref.read(formProvider.notifier).toggleObscureText();
  }

  void clearTextEmail() {
    ref.read(formProvider.notifier).clearTextEmail();
  }

  bool listenObscureText() {
    return ref.watch(formProvider).isObscureText;
  }

  bool listenLoading() {
    return ref.watch(authProvider).isLoadingEmail;
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
