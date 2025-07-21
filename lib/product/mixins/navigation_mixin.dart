import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/product/mixins/force_update_dialog.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

/// Navigation işlemlerini handle eden mixin
mixin NavigationMixin on ConsumerState<SplashView> {
  bool _hasNavigated = false;

  void setupNavigationListener() {
    log("🎧 Navigation Listener kuruldu");
  
    ref.listen<AuthState>(authProvider, (previous, next) {
      log("🔄 Auth State değişti - Login: ${next.isLoggedIn}, Onboarding: ${next.hasSeenOnboarding}");
      _checkNavigationReady();
    });

    ref.listen<SplashState>(splashProvider, (previous, next) {
      log("🔄 Splash State değişti - Redirect: ${next.isRedirectStart}");
      _checkNavigationReady();
    });
  }

  void _checkNavigationReady() {
    if (_hasNavigated) {
      log("⏭️ Navigation zaten yapılmış");
      return;
    }

    final splashState = ref.read(splashProvider);
    final authState = ref.read(authProvider);
    
    // Force update varsa dur
    if (splashState.isForceUpdate) {
      log("🔴 Force update - navigation dur");
      return;
    }

    // Splash henüz redirect yapmadıysa bekle  
    if (!splashState.isRedirectStart) {
      log("⏳ Splash henüz hazır değil");
      return;
    }

    // ✅ Her ikisi de hazır - navigation yap
    _performNavigation(authState);
  }

  void _performNavigation(AuthState authState) {
    _hasNavigated = true;

    if (authState.isLoggedIn) {
      log("🏠 → HOME");
      _navigateToHome();
    } else if (authState.hasSeenOnboarding) {
      log("🔐 → LOGIN");
      _navigateToLogin();
    } else {
      log("👋 → ONBOARDING");
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
}
