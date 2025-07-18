import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/animation/splash_text.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/mixins/force_update_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../../product/animation/splash_icon_text.dart';

//global provider
final splashProvider = StateNotifierProvider<SplashProvider, splashState>(
  (ref) => SplashProvider(),
);

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>  with ForceUpdateDialogMixin{

  @override
  void initState() {
    super.initState();
    // Listener'ları initState'te kur
    ref.read(splashProvider.notifier).checkVersion("1.0.0");

  }

  @override
  Widget build(BuildContext context) {
    // Listener'ları build methodunda kur
    setupListeners();
    return const Scaffold(
      backgroundColor: ColorName.lightBackground,
      body: Center(
        child: SplashAnimationScreen(),
      ),
    );
  }
}