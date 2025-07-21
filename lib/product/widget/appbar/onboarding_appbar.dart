import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_view.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/button/onboarding_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class OnboardingAppbar  extends ConsumerWidget implements PreferredSizeWidget {
  const OnboardingAppbar({
    super.key,
  });


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final currentPage = ref.watch(onboardingProvider).currentPage;
    print("🎯 AppBar: currentPage = $currentPage"); // Debug log
    
    return AppBar(
      leading: Padding(
        padding: PaddingsConstants.onboardingLeadingPadding,
        child: Row(children: [
          BoldOnboardingText(title: "${ref.watch(onboardingProvider).currentPage + 1}",titleSize: TextSizeEnum.onboardingSkipSize.value,titleColor: ColorName.boldBlack),
          BoldOnboardingText(title: "/${ref.watch(onboardingProvider).totalPages}",titleSize: TextSizeEnum.onboardingSkipSize.value,titleColor: ColorName.splashUltimateGreyText),

        ],)
      ),
      actions: [
        OnboardingTextButton(
          onPressed: () {
            ref.read(authProvider.notifier).setOnboardingCompleted();
            context.route.navigateToPage(const LoginWelcomeBack());
          }, 
          text: LocaleKeys.skip.tr(),
          color: ColorName.boldBlack,
        ),
        /*TextButton(
          onPressed: () {
            ref.read(authProvider.notifier).setOnboardingCompleted();
            NavigatorManager.instance.navigatePage(context, const LoginWelcomeBack());
          }, 
          child: BoldOnboardingText(title: LocaleKeys.skip.tr(),titleSize: TextSizeEnum.onboardingSkipSize.value,titleColor: ColorName.boldBlack),
        ),*/
      ],
    );
  }
}