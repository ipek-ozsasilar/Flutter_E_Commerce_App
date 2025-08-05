import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin CreateAccountViewModel<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final Logger _logger = Logger();

  Widget loadingWidgetCheck(String text) {
    return ref.watch(authProvider).isLoading
          ? const CircularProgressIndicator(color: ColorName.whiteColor)
          : NormalText(text: text, color: ColorName.whiteColor, fontSize: TextSizeEnum.loginButtonTextSize.value); 
  }

  void createAccountCheck(BuildContext context) async {
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

    final passwordLengthResult = ref
          .read(formProvider.notifier)
          .checkPasswordLength();
      if (passwordLengthResult) {
        _logger.w('Şifre en az 6 karakter olmalıdır');
        showSnackBar(context, 'Şifre en az 6 karakter olmalıdır');
        return;
      }

      final confirmPasswordLengthResult = ref
          .read(formProvider.notifier)
          .checkConfirmPasswordLength();
      if (confirmPasswordLengthResult) {
        _logger.w('Şifre en az 6 karakter olmalıdır');
        showSnackBar(context, 'Şifre en az 6 karakter olmalıdır');
        return;
      } 

      final passwordsSameResult = ref
          .read(formProvider.notifier)
          .passwordsSame();
      if (!passwordsSameResult) {
        _logger.w('Şifreler eşleşmiyor');
        showSnackBar(context, 'Şifreler eşleşmiyor');
        return;
      }

    // 3. Firebase create account
    final user = await ref
        .read(authProvider.notifier)
        .createAccountWithEmailAndPassword();
    if (user == null) {
      _logger.w('Kullanıcı oluşturma başarısız');
      showSnackBar(
        context,
        'Giriş başarısız. E-mail ve şifrenizi kontrol ediniz',
      );
      return;
    }else{
      _logger.w('Kullanıcı oluşturma başarılı');
      user.sendEmailVerification();
      showSnackBar(context, 'Mail adresinize doğrulama linki gönderildi. Lütfen mailinizi doğrulayıp tekrar giriş yapın');
      NavigatorManager.instance.navigatePage(context, LoginWelcomeBack());
      return;
    }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'Şifre en az 6 karakter olmalıdır');
        return;
      }else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'Bu e-mail adresi zaten kullanılıyor');
        return;
      }
      showSnackBar(context, 'Kullanıcı oluşturma başarısız');
      return;
    } 
    finally{
      ref.read(authProvider.notifier).setLoading(false);
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
    return ref.watch(authProvider).isLoading;
  }

  void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
}
