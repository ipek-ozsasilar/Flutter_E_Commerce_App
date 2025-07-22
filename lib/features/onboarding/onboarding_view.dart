import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_provider.dart';
import 'package:flutter_e_commerce_app/features/splash/splash_provider.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/onboarding_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/onboarding_bottom.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

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
          _OnboardingImageText(genImage: Assets.images.chooseProduct, title: LocaleKeys.chooseProducts.tr(), description: LocaleKeys.chooseProductsDetail.tr(),width: ImageSizeEnum.chooseProductWidthAndHeight.value,height: ImageSizeEnum.chooseProductWidthAndHeight.value),
          _OnboardingImageText(genImage: Assets.images.makePayment, title: LocaleKeys.makePayment.tr(), description: LocaleKeys.makePaymentDetail.tr(),width: ImageSizeEnum.makePaymentWidth.value,height: ImageSizeEnum.makePaymentHeight.value),
          _OnboardingImageText(genImage: Assets.images.getYourOrder, title: LocaleKeys.getYourOrder.tr(), description: LocaleKeys.getYourOrderDetail.tr(),width: ImageSizeEnum.getYourOrderWidthAndHeight.value,height: ImageSizeEnum.getYourOrderWidthAndHeight.value),

        ],
      ),
             bottomNavigationBar: OnboardingBottom(pageController: _pageController),
    );
  }
}



class _OnboardingImageText extends StatelessWidget {
  const _OnboardingImageText({
    super.key,
    required this.genImage,
    required this.title,
    required this.description,
    required this.width,
    required this.height,
  });

  final AssetGenImage genImage;
  final String title;
  final String description;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingsConstants.instance.onboardingPageHorizontalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        genImage.image(width: width, height: height),
        Padding(
          padding: PaddingsConstants.instance.onboardingTitlePadding,
          child: BoldOnboardingText(title: title,titleSize: TextSizeEnum.onboardingTitleSize.value,titleColor: ColorName.boldBlack),
        ),
        BoldOnboardingTextDetail(description: description),
      
      ] ),
    );
  }
}

