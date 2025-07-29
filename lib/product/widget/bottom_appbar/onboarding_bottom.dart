import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_provider.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:kartal/kartal.dart';

//Onboarding Bottom for onboarding page's bottom
class OnboardingBottom extends ConsumerWidget {
  OnboardingBottom({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: PaddingsConstants.instance.onboardingBottomPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //previous page button
          GlobalTextButton(
            onPressed: () {
              ref.read(onboardingProvider.notifier).previousPage();
              _previousPage();
            },
            text: LocaleKeys.prev.tr(),
            color: ColorName.prevColor,
          ),
          //page indicator
          Row(
            children: [
              for (var i = 0; i < ref.watch(onboardingProvider).totalPages; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: WidgetSizeEnum.bottomContainerWidthAndHeight.value,
                    height: WidgetSizeEnum.bottomContainerWidthAndHeight.value,
                    decoration: BoxDecoration(
                      color: ref.watch(onboardingProvider).currentPage == i
                          ? ColorName.selectedPageBlue
                          : ColorName.prevColor,
                      borderRadius: BorderRadiusConstants
                          .instance
                          .circularSmallBorderRadius,
                    ),
                  ),
                ),
            ],
          ),
          //next page button
          GlobalTextButton(
            onPressed: () {
              if ((ref.watch(onboardingProvider).currentPage ==
                  ref.watch(onboardingProvider).totalPages - 1)) {
                // AuthProvider kullanarak onboarding completion'ı işaretle
                ref
                    .read(splashProvider.notifier)
                    .setOnboardingWriteHasSeenOnboarding();
                NavigatorManager.instance.navigatePage(
                  context,
                  const LoginWelcomeBack(),
                );
              } else {
                ref.read(onboardingProvider.notifier).nextPage();
                _nextPage();
              }
            },
            text: LocaleKeys.next.tr(),
            color: ColorName.sizzlingRed,
          ),
        ],
      ),
    );
  }

  //next page function
  void _nextPage() {
    pageController.nextPage(
      duration:
          DurationConstants.durationInstance.onboardingPageTransitionDuration,
      curve: Curves.easeInOut,
    );
  }

  //previous page function
  void _previousPage() {
    pageController.previousPage(
      duration:
          DurationConstants.durationInstance.onboardingPageTransitionDuration,
      curve: Curves.easeInOut,
    );
  }
}
