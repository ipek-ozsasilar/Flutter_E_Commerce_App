// Order Payment Details Section Widget

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

// Order Payment Details Section Widget
class OrderPaymentDetailsSection extends StatelessWidget {
  const OrderPaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        BoldOnboardingText(
          title: LocaleKeys.orderPaymentDetails.tr(),
          titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),

        // Order Amounts
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NormalText(
              text: LocaleKeys.orderAmounts.tr(),
              color: Theme.of(context).appColors.boldBlack,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
            ),
            BoldOnboardingText(
              title: "₹ 7,000.00",
              titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              titleColor: Theme.of(context).appColors.boldBlack,
            ),
          ],
        ),

        // Convenience
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                NormalText(
                  text: "Convenience",
                  color: Theme.of(context).appColors.boldBlack,
                  fontSize: TextSizeEnum.homeCardsTitleSize.value,
                ),
                SizedBox(width: 8),
                GlobalTextButton(onPressed: (){}, text: "know more", color: Theme.of(context).appColors.sizzlingRed)
              ],
            ),
            GlobalTextButton(onPressed: (){}, text: "Apply Coupon", color: Theme.of(context).appColors.sizzlingRed)
          ],
        ),

        // Delivery Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NormalText(
              text: "Delivery Fee",
              color: Theme.of(context).appColors.boldBlack,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
            ),
            NormalText(
              text: "Free",
              color: Theme.of(context).appColors.sizzlingRed,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
            ),
          ],
        ),
      ],
    );
  }
}