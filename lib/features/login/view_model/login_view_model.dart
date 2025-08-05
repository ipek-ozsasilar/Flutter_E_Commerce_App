import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart'
    show LoginWelcomeBack;
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin LoginViewModel<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final Logger _logger = Logger();

  Widget loadingWidgetCheck(String text) {
    return ref.watch(authProvider).isLoading
        ? const CircularProgressIndicator(color: ColorName.whiteColor)
        : NormalText(
            text: text,
            color: ColorName.whiteColor,
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
        showSnackBar(context, 'İnternet bağlantısı yok');
        return;
      }

      // 2. Form kontrolü
      final emptyEmailAndPasswordResult = ref
          .read(formProvider.notifier)
          .checkEmptyEmailAndPassword();
      if (emptyEmailAndPasswordResult) {
        _logger.w('Email veya password boş');
        showSnackBar(context, 'E-mail veya şifre boş bırakılamaz');
        return;
      }

      // 3. Firebase login
      final user = await ref
          .read(authProvider.notifier)
          .signInWithEmailAndPassword();
      if (user == null) {
        _logger.w('Kullanıcı girişi başarısız');
        showSnackBar(
          context,
          'Giriş başarısız. E-mail ve şifrenizi kontrol ediniz',
        );
        return;
      }

      // 4. Email doğrulama
      final isVerified = await ref
          .read(authProvider.notifier)
          .isEmailVerified();
      if (!isVerified) {
        showSnackBar(context, 'E-mail adresinizi doğrulayınız');
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
                        content: Text('Doğrulama maili tekrar gönderildi.'),
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
      NavigatorManager.instance.navigatePage(context, HomeView());
    } on FirebaseAuthException catch (e) {
      _logger.e(
        'FirebaseAuthException -> code: ${e.code}, message: ${e.message}',
      );

      if (e.code == 'invalid-email') {
        showSnackBar(context, 'E-mail formatı geçersiz');
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Bir hata oluştu geçersiz giriş');
      } else {
        showSnackBar(context, 'Bir hata oluştu');
      }
    } finally {
      ref.read(authProvider.notifier).setLoading(false);
    }
  }

  void changeObscureText() {
    ref.read(formProvider.notifier).toggleObscureText();
  }

  void clearTextEmail() {
    ref.read(formProvider.notifier).clearTextEmail();
  }

  bool listenLoading() {
    return ref.watch(authProvider).isLoading;
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
