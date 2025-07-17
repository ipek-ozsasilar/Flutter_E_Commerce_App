import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/product/mixins/force_update_dialog.dart';

//global provider
final splashProvider=StateNotifierProvider<SplashProvider,splashState>(
    (ref) => SplashProvider(),
  );


class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with ForceUpdateDialogMixin{

  @override
  void initState() {
    super.initState();
    // Listener'ları initState'te kur
      ref.read(splashProvider.notifier).checkVersion("0.0.0");
  
  }

  @override
  Widget build(BuildContext context) {
    // Listener'ları build methodunda kur
    setupListeners();
    return const Scaffold(
    );
  }
}