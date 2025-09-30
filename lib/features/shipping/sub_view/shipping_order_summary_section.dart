import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order
        Padding(
          padding: PaddingsConstants.instance.otherLoginButtonHorizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(
                text: "Order",
                color: Theme.of(context).appColors.starNumberGreyColor,
                fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              ),
              NormalText(
                text: "₹ 7,000",
                fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                color: Theme.of(context).appColors.starNumberGreyColor,
              ),
            ],
          ),
        ),

        // Shipping
        Padding(
          padding: PaddingsConstants.instance.otherLoginButtonHorizontalPadding,
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(
                text: "Shipping",
                color: Theme.of(context).appColors.starNumberGreyColor,
                fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              ),
              BoldOnboardingText(
                title: "₹ 30",
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.starNumberGreyColor,
              ),
            ],
          ),
        ),

        // Total
        Padding(
          padding: PaddingsConstants.instance.otherLoginButtonHorizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldOnboardingText(
                title: "Total",
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.totalTextColor,
              ),
              BoldOnboardingText(
                title: "₹ 7,030",
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.totalTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}