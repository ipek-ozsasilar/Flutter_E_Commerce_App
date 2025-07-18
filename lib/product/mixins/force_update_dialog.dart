import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin ForceUpdateDialogMixin on ConsumerState<SplashView> {
  void setupListeners() {
    log("🎧 Listener kuruldu");
    ref.listen(splashProvider, (previous, next) {
      log("🔄 State değişti -  ForceUpdate: ${next.isForceUpdate}, Redirect: ${next.isRedirectStart}");
      
      if (next.isForceUpdate) {
        log("🚨 ALERT DIALOG AÇILIYOR!");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(LocaleKeys.requiredUpdate.tr()),
            content: Text(LocaleKeys.youNeedToUpdateTheApplication.tr()),
            actions: [
              TextButton(
                onPressed: (){
                  context.route.pop();
                },
                child: Text(LocaleKeys.update.tr()),
              ),
            ],
          ),
        );
      }
      /*if (next.isRedirectStart) {
        log("🔄 Login sayfasina yönlendiriliyor");
        context.route.navigateToPage(const LoginView());
      }*/
    });
  }
}