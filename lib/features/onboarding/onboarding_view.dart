import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_provider.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/onboarding_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/onboarding_bottom.dart';
import 'package:flutter_e_commerce_app/product/widget/button/onboarding_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

final onboardingProvider = StateNotifierProvider<OnboardingProvider, OnboardingState>((ref) {
  return OnboardingProvider();
});

//forveupdate, en tr json locale keys, bottom kısmı , get token
class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();  
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {  
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int index) {
    ref.read(onboardingProvider.notifier).setPage(index);
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnboardingAppbar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
        padEnds: true,
        children: [
          onboardingImageText(image: Assets.images.chooseProduct.path, title: LocaleKeys.chooseProducts.tr(), description: LocaleKeys.chooseProductsDetail.tr(),width: ImageSizeEnum.chooseProductWidthAndHeight.value,height: ImageSizeEnum.chooseProductWidthAndHeight.value),
          onboardingImageText(image: Assets.images.makePayment.path, title: LocaleKeys.makePayment.tr(), description: LocaleKeys.makePaymentDetail.tr(),width: ImageSizeEnum.makePaymentWidth.value,height: ImageSizeEnum.makePaymentHeight.value),
          onboardingImageText(image: Assets.images.getYourOrder.path, title: LocaleKeys.getYourOrder.tr(), description: LocaleKeys.getYourOrderDetail.tr(),width: ImageSizeEnum.getYourOrderWidthAndHeight.value,height: ImageSizeEnum.getYourOrderWidthAndHeight.value),

        ],
      ),
             bottomNavigationBar: OnboardingBottom(pageController: _pageController),
    );
  }
}



class onboardingImageText extends StatelessWidget {
  const onboardingImageText({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.width,
    required this.height,
  });

  final String image;
  final String title;
  final String description;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingsConstants.onboardingPageHorizontalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        Image.asset(image,width: width,height: height,),
        Padding(
          padding: PaddingsConstants.onboardingTitlePadding,
          child: BoldOnboardingText(title: title,titleSize: TextSizeEnum.onboardingTitleSize.value,titleColor: ColorName.boldBlack),
        ),
        BoldOnboardingTextDetail(description: description),
      
      ] ),
    );
  }
}

