import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/get_started_view.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';

mixin GoogleViewModel<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  void googleLoginCheck() async {
    final _logger = Logger();
    try {
      await ref.read(authProvider.notifier).signInWithGoogle();
      NavigatorManager.instance.navigatePage(context, GetStartedView());
    } catch (e) {
      _logger.w('Google login failed: ${e.toString()}');

      // Özel hata mesajları
      if (e.toString().contains('account-exists-with-different-credential')) {
        showSnackBar(context, LocaleKeys.facebookAccountExists.tr());
      } else if (e.toString().contains('user-disabled')) {
        showSnackBar(context, LocaleKeys.accountDisabled.tr());
      } else if (e.toString().contains('invalid-credential')) {
        showSnackBar(context, LocaleKeys.invalidCredentialError.tr());
      } else if (e.toString().contains('operation-not-allowed')) {
        showSnackBar(context, LocaleKeys.googleSignInNotEnabled.tr());
      } else if (e.toString().contains('weak-password')) {
        showSnackBar(context, LocaleKeys.weakPassword.tr());
      } else {
        showSnackBar(
          context,
          '${LocaleKeys.googleSignInFailedError.tr()} ${e.toString()}',
        );
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
