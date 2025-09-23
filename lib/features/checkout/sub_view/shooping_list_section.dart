import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/star_text_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ShoppingListSection extends StatelessWidget {
  const ShoppingListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CheckoutProductCard(
          productName: "Women's Casual Wear",
          variations: ["Black", "Red"],
          rating: 4.8,
          currentPrice: 34.00,
          originalPrice: 64.00,
          discountPercentage: 20,
          quantity: 1,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 15),
      itemCount: 2,
    );
  }
}

// Individual Product Card Widget
class CheckoutProductCard extends StatelessWidget {
  final String productName;
  final List<String> variations;
  final double rating;
  final double currentPrice;
  final double originalPrice;
  final int discountPercentage;
  final int quantity;

  const CheckoutProductCard({
    super.key,
    required this.productName,
    required this.variations,
    required this.rating,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercentage,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).appColors.boldBlack.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Assets.images.shopPage.image(
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 12),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    BoldOnboardingText(
                      title: productName,
                      titleSize: TextSizeEnum.homeCardsTitleSize.value,
                      titleColor: Theme.of(context).appColors.boldBlack,
                    ),

                    // Variations
                    Row(
                      children: [
                        NormalText(
                          text: "Variations : ",
                          color: Theme.of(
                            context,
                          ).appColors.starNumberGreyColor,
                          fontSize: TextSizeEnum.homeCardsDetailSize.value,
                        ),
                        ...variations
                            .map(
                              (variation) => Container(
                                margin: EdgeInsets.only(right: 4),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).appColors.starNumberGreyColor,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: NormalText(
                                  text: variation,
                                  color: Theme.of(context).appColors.boldBlack,
                                  fontSize:
                                      TextSizeEnum.homeCardsDetailSize.value,
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),

                    // Rating
                    Row(
                      children: [
                        NormalText(
                          text: rating.toString(),
                          color: Theme.of(context).appColors.boldBlack,
                          fontSize: TextSizeEnum.homeCardsDetailSize.value,
                        ),
                        SizedBox(width: 4),
                        StarTextWidget(),
                      ],
                    ),

                    // Price Section
                    Row(
                      children: [
                        BoldOnboardingText(
                          title: "\$ ${currentPrice.toStringAsFixed(2)}",
                          titleSize: TextSizeEnum.homeCardsTitleSize.value,
                          titleColor: Theme.of(context).appColors.boldBlack,
                        ),
                        SizedBox(width: 8),
                        NormalText(
                          text: "\$ ${originalPrice.toStringAsFixed(2)}",
                          color: Theme.of(context).appColors.oldPriceGreyColor,
                          fontSize: TextSizeEnum.homeCardsDetailSize.value,
                          textLine: true,
                        ),
                        SizedBox(width: 8),
                        NormalText(
                          text: "upto $discountPercentage% off",
                          color: Theme.of(context).appColors.offRedColor,
                          fontSize: TextSizeEnum.homeCardsDetailSize.value,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Divider(),

          Row(
            children: [
              NormalText(
                text: "Total Order ($quantity) : ",
                color: Theme.of(context).appColors.boldBlack,
                fontSize: TextSizeEnum.homeCardsDetailSize.value,
              ),
              Spacer(),
              BoldOnboardingText(
                title: "\$ ${currentPrice.toStringAsFixed(2)}",
                titleSize: TextSizeEnum.homeCardsTitleSize.value,
                titleColor: Theme.of(context).appColors.boldBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
