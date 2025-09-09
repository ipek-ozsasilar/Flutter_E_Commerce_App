// import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app/features/home/get_started_view.dart';
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

mixin LoginViewModel<T extends ConsumerStatefulWidget> on ConsumerState<T> {
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

  void loginWithEmailAndPasswordCheck(BuildContext context) async {
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

      // 3. Firebase login
      final user = await ref
          .read(authProvider.notifier)
          .signInWithEmailAndPassword();
      if (user == null) {
        _logger.w('Kullanıcı girişi başarısız');
        showSnackBar(context, LocaleKeys.loginFailedCheckCredentials.tr());
        return;
      }

      // 4. Email doğrulama
      final isVerified = await ref
          .read(authProvider.notifier)
          .isEmailVerified();
      if (!isVerified) {
        showSnackBar(context, LocaleKeys.verifyEmailAddress.tr());
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('E-mail doğrulama gerekli'),
              content: Text('E-mail adresinizi doğrulamalısınız.'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(LocaleKeys.verificationEmailResent.tr()),
                      ),
                    );
                  },
                  child: Text('Tekrar Mail Gönder'),
                ),
              ],
            );
          },
        );
        await ref.read(authProvider.notifier).signOutAuth();
        return;
      }
      // 5. Başarılı login → yönlendirme
      _logger.w('Kullanıcı girişi başarılı ve email doğrulanmış');
      NavigatorManager.instance.navigatePage(context, GetStartedView());
    } on FirebaseAuthException catch (e) {
      _logger.e(
        'FirebaseAuthException -> code: ${e.code}, message: ${e.message}',
      );

      if (e.code == 'invalid-email') {
        showSnackBar(context, LocaleKeys.invalidEmailFormat.tr());
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, LocaleKeys.invalidCredentials.tr());
      } else {
        showSnackBar(context, LocaleKeys.anErrorOccurred.tr());
      }
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

  bool listenLoading() {
    return ref.watch(authProvider).isLoadingEmail;
  }

  bool listenObscureText() {
    return ref.watch(formProvider).isObscureText;
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
