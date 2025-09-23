import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

// Order Total Section Widget

class OrderTotalSection extends StatelessWidget {
  const OrderTotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldOnboardingText(
              title: "Order Total",
              titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              titleColor: Theme.of(context).appColors.boldBlack,
            ),
            BoldOnboardingText(
              title: "₹ 7,000.00",
              titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              titleColor: Theme.of(context).appColors.boldBlack,
            ),
          ],
        ),

        // EMI Available
        Row(
          children: [
            NormalText(
              text: "EMI Available",
              color: Theme.of(context).appColors.boldBlack,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
            ),
            SizedBox(width: 8),
            GlobalTextButton(
              onPressed: () {},
              text: "Details",
              color: Theme.of(context).appColors.sizzlingRed,
            ),
          ],
        ),
      ],
    );
  }
}
