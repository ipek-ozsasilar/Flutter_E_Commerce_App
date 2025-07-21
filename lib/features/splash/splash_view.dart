import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/animation/splash_text.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/mixins/force_update_dialog.dart';
import 'package:flutter_e_commerce_app/product/mixins/navigation_mixin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../../product/animation/splash_icon_text.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>  
    with ForceUpdateDialogMixin, NavigationMixin{

  @override
  void initState() {
    super.initState();
    
    // ✅ Paralel olarak version ve auth check
    _initializeApp();
  }

  void _initializeApp() async {
    // Paralel olarak her ikisini de başlat
    await Future.wait<void>([
      ref.read(splashProvider.notifier).checkVersion("1.0.0"),
      ref.read(authProvider.notifier).checkAuthStatus(),  

    ]);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Listener'ları initState'te kur
    setupForceUpdateListener();
    setupNavigationListener();
    return const Scaffold(
      body: Center(
        child: SplashAnimationScreen(),
      ),
    );
  }
}