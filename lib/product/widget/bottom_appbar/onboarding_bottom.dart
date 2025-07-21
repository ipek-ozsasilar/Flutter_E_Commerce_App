import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/auth/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/button/onboarding_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:kartal/kartal.dart';


//forveupdate, en tr json locale keys, bottom kısmı

class OnboardingBottom extends ConsumerWidget {
   OnboardingBottom({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OnboardingTextButton(
            onPressed: () {
              ref.read(onboardingProvider.notifier).previousPage();
              _previousPage();
            },
            text: LocaleKeys.prev.tr(),
            color: ColorName.prevColor,
          ),
          Row(
            children: [
              // Sayfa 0 (ilk sayfa)
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: ref.watch(onboardingProvider).currentPage == 0
                      ? ColorName
                            .selectedPageBlue // Aktif sayfa
                      : ColorName.prevColor, // Pasif sayfa
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Sayfa 1 (ikinci sayfa)
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: ref.watch(onboardingProvider).currentPage == 1
                        ? ColorName
                              .selectedPageBlue // Aktif sayfa
                        : ColorName.prevColor, // Pasif sayfa
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Sayfa 2 (üçüncü sayfa)
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: ref.watch(onboardingProvider).currentPage == 2
                      ? ColorName
                            .selectedPageBlue // Aktif sayfa
                      : ColorName.prevColor, // Pasif sayfa
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          OnboardingTextButton(
            onPressed: () {
              if((ref.watch(onboardingProvider).currentPage == ref.watch(onboardingProvider).totalPages -1 )){
                // AuthProvider kullanarak onboarding completion'ı işaretle
                ref.read(authProvider.notifier).setOnboardingCompleted();
                NavigatorManager.instance.navigatePage(context, const LoginWelcomeBack());
              }else{
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

  void _nextPage() {
    pageController.nextPage(
      duration: DurationConstants.durationInstance.onboardingPageTransitionDuration,
      curve: Curves.easeInOut,
    );
  }
  
  void _previousPage() {
    pageController.previousPage(
      duration: DurationConstants.durationInstance.onboardingPageTransitionDuration, 
      curve: Curves.easeInOut,
    );
  }
}



