// Shopping Bag Section Widget

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/place_order/sub_view/Shopping_bags_size_quantity_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ShoppingBagSection extends StatelessWidget {
  const ShoppingBagSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Padding(
          padding: PaddingsConstants.instance.profileAppbarActionsPadding,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Assets.images.shopPage.image(
              width: ImageSizeEnum.shoppingBagImageWidth.value,
              height: ImageSizeEnum.shoppingBagImageHeight.value,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              BoldOnboardingText(
                title: "Women's Casual Wear",
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.boldBlack,
              ),

              // Product Description
              NormalText(
                text: "Checked Single-Breasted Blazer",
                color: Theme.of(context).appColors.starNumberGreyColor,
                fontSize: TextSizeEnum.homeCardsTitleSize.value,
              ),

              // Size and Quantity Row
              Row(
                children: [

                  // 
                  ShoppingBagsSizeQuantityWidget(),

                  // Size
                  SizedBox(width: 24),

                  ShoppingBagsSizeQuantityWidget(),
                ],
              ),

              SizedBox(height: 12),

              // Delivery Date
              Row(
                children: [
                  NormalText(
                    text: "Delivery by  ",
                    color: Theme.of(context).appColors.boldBlack,
                    fontSize: TextSizeEnum.homeCardsTitleSize.value,
                  ),
                  BoldOnboardingText(
                    title: "10 May 20XX",
                    titleSize: TextSizeEnum.homeCardsTitleSize.value,
                    titleColor: Theme.of(context).appColors.boldBlack,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}