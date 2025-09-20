import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/outlined_icon_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class DiscountStackWidget extends StatelessWidget {
  const DiscountStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizeEnum.homeDiscountStackHeight.value,
      margin: PaddingsConstants.instance.homeSingleChildScrollViewPadding,
      child: PageView(
        children: [
          Stack(
            children: [
              Container(
                width: WidgetSizeEnum.homeDiscountStackWidth.value,
                height: WidgetSizeEnum.homeDiscountStackHeight.value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Assets.images.shopPage.image(
                    width: WidgetSizeEnum.homeDiscountStackWidth.value,
                    height: WidgetSizeEnum.homeDiscountStackHeight.value,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldOnboardingText(
                      title: LocaleKeys.offDiscount.tr(),
                      titleSize: TextSizeEnum.onboardingTitleSize.value,
                      titleColor: Theme.of(context).appColors.whiteColor,
                    ),

                    NormalText(
                      text: LocaleKeys.nowInProduct.tr(),
                      color: Theme.of(context).appColors.whiteColor,
                      fontSize: TextSizeEnum.loginButtonTextSize.value,
                    ),
                    NormalText(
                      text: LocaleKeys.allColours.tr(),
                      color: Theme.of(context).appColors.whiteColor,
                      fontSize:   TextSizeEnum.loginButtonTextSize.value,
                    ),
                    outlinedButton(
                      text: LocaleKeys.shopNow.tr(),
                      icon: IconsEnum.iconForward.icon,
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}