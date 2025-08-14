import 'dart:developer';
import 'package:flutter/material.dart';
  import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/deeplink_provider.dart';
import 'package:flutter_e_commerce_app/features/login/reset_password.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

mixin SplashViewModelMixin on ConsumerState<SplashView> {
  void setupForceUpdateListener() {
    // ✅ Splash state değişikliklerini dinle
    ref.listen<SplashState>(splashProvider, (previous, next) {
      if (next.isForceUpdate) {
        _showForceUpdateDialog();
        return;
      }

      // ✅ Splash ready olduğunda, mevcut auth state ile navigation yap
      if (next.isRedirectStart) {
        final currentAuthState = ref.read(authProvider);
        _performNavigation(currentAuthState, next);
      }
    });

    // ✅ Auth state değişikliklerini dinle
    ref.listen<AuthState>(authProvider, (previous, next) {
      final currentSplashState = ref.read(splashProvider);

      // ✅ Sadece splash ready ise navigation yap
      if (currentSplashState.isRedirectStart &&
          !currentSplashState.isForceUpdate) {
        _performNavigation(next, currentSplashState);
      }
    });
  }

  void _performNavigation(AuthState authState, SplashState splashState) {
    // If there is a pending password reset deep link, prioritize it
    final pendingOobCode = ref.read(appLinkProvider).oobCode;
    if (pendingOobCode != null && pendingOobCode.isNotEmpty) {
      _navigateToReset(pendingOobCode);
      return;
    }
    if (authState.isLoggedIn) {
      log("🏠 → HOME (user logged in)");
      _navigateToHome();
    } else if (splashState.hasSeenOnboarding) {
      log("🔐 → LOGIN (onboarding seen but not logged in)");
      _navigateToLogin();
    } else {
      log("👋 → ONBOARDING (first time user)");
      _navigateToOnboarding();
    }
  }

  void _navigateToOnboarding() {
    if (mounted) {
      NavigatorManager.instance.navigatePage(context, const OnboardingView());
    }
  }

  void _navigateToHome() {
    if (mounted) {
      NavigatorManager.instance.navigatePage(context, const HomeView());
    }
  }

  void _navigateToLogin() {
    if (mounted) {
      NavigatorManager.instance.navigatePage(context, const LoginWelcomeBack());
    }
  }

  void _navigateToReset(String oobCode) {
    if (mounted) {
      // Clear the stack so later Splash redirects do not override
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ResetPassword(oobCode: oobCode)),
        (route) => false,
      );
    }
  }

  void _showForceUpdateDialog() {
    Future.delayed(DurationConstants.durationInstance.beforeDialogDuration, () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _buildForceUpdateDialog(context),
        );
      }
    });
  }

  Widget _buildForceUpdateDialog(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.requiredUpdate.tr()),
      content: Text(LocaleKeys.youNeedToUpdateTheApplication.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(LocaleKeys.ok.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            // Force update logic burada
          },
          child: Text(LocaleKeys.update.tr()),
        ),
      ],
    );
  }
}
