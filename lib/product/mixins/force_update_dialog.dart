import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';


/// Sadece force update dialog'u ile ilgilenen mixin
mixin ForceUpdateDialogMixin on ConsumerState<SplashView> {
  void setupForceUpdateListener() {
    log("🎧 Force Update Listener kuruldu");
    ref.listen<SplashState>(splashProvider, (previous, next) {
      // Sadece force update durumunu kontrol eder
      if (next.isForceUpdate) {
        log("🚨 Force Update Dialog aciliyor!");
        _showForceUpdateDialog();
      }
      
      
    });
  }

  void _showForceUpdateDialog() {
    Future.delayed(DurationConstants.durationInstance.beforeDialogDuration, () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false, // Kullanıcı dialog'u kapatamaz
          builder: (context) => _buildForceUpdateDialog(context),
        );
      }
    });
  }

  AlertDialog _buildForceUpdateDialog(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.requiredUpdate.tr()),
      content: Text(LocaleKeys.youNeedToUpdateTheApplication.tr()),
      actions: [
        TextButton(
          onPressed: () {
            NavigatorManager.instance.closePagePop(context);
          },
          child: Text(LocaleKeys.update.tr()),
        ),
      ],
    );
  }
} 