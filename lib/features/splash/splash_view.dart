import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';

import 'package:flutter_e_commerce_app/product/animation/splash_text.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/mixins/splash_view_model.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
part '../../product/animation/splash_icon_text.dart';

//Splash View for app splash screen
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SplashViewModelMixin {
  @override
  void initState() {
    super.initState();
    //_initializeApp() fonksiyonu içerisinde, authProvider üzerinden state değişikliği yapılmaya çalışılıyor.
    // Riverpod, widget henüz tam olarak oluşturulmadan state değişikliği yapılmasına izin vermez 
    //çünkü bu durum widget ağacının tutarsız hale gelmesine sebep olabilir.
    //initState içinde hemen state değiştirirsen → ❌ HATA
    ////Future.delayed ile biraz erteleyip değiştirirsen → ✅ GÜVENLİ
    Future.delayed(DurationConstants.durationInstance.splashDuration, () {
      _initializeApp();
    });
  } 

  void _initializeApp() async {
    //parallel process check version, auth and onboarding
    await Future.wait<void>([
      //check auth status
      ref.read(authProvider.notifier).checkAuthStatus(),
      //check version app
      ref.read(splashProvider.notifier).checkVersion("1.0.0"),
      //check onboarding has seen for navigation which screen will be shown
      ref.read(splashProvider.notifier).checkOnboardingHasSeen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //check force update with splash view model
    setupForceUpdateListener();
    return const Scaffold(body: Center(child: SplashAnimationScreen()));
  }
}
