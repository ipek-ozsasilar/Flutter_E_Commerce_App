import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/theme_provider.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class CustomAppbarLogin extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  CustomAppbarLogin({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.clearFunction,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? clearFunction;

  @override
  ConsumerState<CustomAppbarLogin> createState() => _CustomAppbarLoginState();

  @override
  Size get preferredSize => Size.fromHeight(
    showBackButton ? 160 : AppbarSizeEnum.loginToolbarHeight.value,
  );
}

class _CustomAppbarLoginState extends ConsumerState<CustomAppbarLogin>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    // ÇÖZÜM: Başlangıçta light tema için 0.5 (güneş solda görünsün)
    // dark tema için 0.0 (ay solda görünsün) olarak ayarla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isLight = ref.read(themeStateProvider).themeMode == ThemeMode.light;
      controller.value = isLight ? 0.5 : 0.0; // Light: 0.5, Dark: 0.0
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.showBackButton
          ? 160
          : AppbarSizeEnum.loginToolbarHeight.value,
      leadingWidth: AppbarSizeEnum.loginLeadingWidth.value,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Semantics(
            identifier:  'theme_button',
            child: IconButton(
              onPressed: () async {
                if (_isAnimating) return;
                _isAnimating = true;
            
                // Mevcut tema durumuna göre animasyon yönünü belirle
                final isCurrentlyLight =
                    ref.read(themeStateProvider).themeMode == ThemeMode.light;
            
                // Tema değiştir
                ref.read(themeStateProvider.notifier).toggleTheme();
            
                // Animasyon mantığı:
                // Light -> Dark: 0.5'ten 0.0'a (güneşten aya)
                // Dark -> Light: 0.0'dan 0.5'e (aydan güneşe)
                if (isCurrentlyLight) {
                  // Light'tan Dark'a geçerken
                  await controller.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Dark'tan Light'a geçerken
                  await controller.animateTo(
                    0.5,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
            
                _isAnimating = false;
              },
              icon: AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(0, 0),
                    child: Lottie.asset(
                      'assets/animations/theme.json',
                      controller: controller,
                      repeat: false,
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
      leading: widget.showBackButton
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                    onPressed: () {
                      widget.clearFunction?.call();
                      NavigatorManager.instance.closePagePop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: BoldOnboardingText(
                    title: widget.title,
                    titleSize: TextSizeEnum.loginWelcomeSize.value,
                    titleColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            )
          : Padding(
              padding: PaddingsConstants.instance.loginAppbarPadding,
              child: BoldOnboardingText(
                title: widget.title,
                titleSize: TextSizeEnum.loginWelcomeSize.value,
                titleColor: Theme.of(context).colorScheme.onBackground,
              ),
            ),
    );
  }
}