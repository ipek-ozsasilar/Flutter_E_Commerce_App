import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
// import 'package:flutter_e_commerce_app/firebase_options.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
// import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin ForgotPasswordViewModel<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final Logger _logger = Logger();

  void forgotPasswordCheck() async {
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

      final emailEmptyResult = ref
          .read(formProvider.notifier)
          .checkForgotPasswordEmailEmpty();
      if (emailEmptyResult) {
        showSnackBar(context, LocaleKeys.emailFieldEmpty.tr());
        return;
      }

      // Email format kontrolü
      final email = ref
          .read(formProvider.notifier)
          .forgotPasswordController
          .text;
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        showSnackBar(context, LocaleKeys.enterValidEmail.tr());
        return;
      }
      await ref.read(authProvider.notifier).sendPasswordResetEmail();

      showSnackBar(context, LocaleKeys.passwordResetLinkSent.tr());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackBar(context, LocaleKeys.invalidEmailFormat.tr());
      } else {
        showSnackBar(context, LocaleKeys.invalidUser.tr());
      }
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

  void clearForgotPassword() {
    ref.read(formProvider.notifier).clearTextForgotPassword();
  }
}
