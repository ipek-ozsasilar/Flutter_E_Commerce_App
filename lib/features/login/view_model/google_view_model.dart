import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin GoogleViewModel<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  void googleLoginCheck() async {
    final _logger = Logger();
    try {
      await ref.read(authProvider.notifier).signInWithGoogle();
      NavigatorManager.instance.navigatePage(context, HomeView());
    } catch (e) {
      _logger.w('Google login failed: ${e.toString()}');

      // Özel hata mesajları
      if (e.toString().contains('account-exists-with-different-credential')) {
        showSnackBar(
          context,
          'Bu e-posta adresi ile zaten Facebook hesabı oluşturulmuş. Facebook ile giriş yapın.',
        );
      } else if (e.toString().contains('user-disabled')) {
        showSnackBar(context, 'Hesabınız devre dışı bırakılmış.');
      } else if (e.toString().contains('invalid-credential')) {
        showSnackBar(context, 'Geçersiz kimlik bilgileri.');
      } else if (e.toString().contains('operation-not-allowed')) {
        showSnackBar(context, 'Google girişi etkin değil.');
      } else if (e.toString().contains('weak-password')) {
        showSnackBar(context, 'Zayıf şifre.');
      } else {
        showSnackBar(context, 'Google girişi başarısız: ${e.toString()}');
      }
    } finally {
      ref.read(authProvider.notifier).setGoogleLoading(false);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget googleLoadingWidgetCheck() {
    return ref.watch(authProvider).isLoadingGoogle
        ? CircularProgressIndicator(
            color: Theme.of(context).appColors.sizzlingRed,
          )
        : Icon(
            Icons.g_mobiledata,
            color: Theme.of(context).appColors.boldBlack,
          );
  }
}
