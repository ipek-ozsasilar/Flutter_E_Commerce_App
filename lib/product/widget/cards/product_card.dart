import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/star_text_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String description;
  final String currentPrice;
  final String? oldPrice;
  final String? discountPercent;
  final double? width;
  final bool showStars;

  const ProductCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.description,
    required this.currentPrice,
    this.oldPrice,
    this.discountPercent,
    this.width,
    this.showStars = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? WidgetSizeEnum.homeCardsContainerWidth.value,
      decoration: ProductCardDecoration.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Assets
                          .images
                          .shopPage
                          .image(width: double.infinity, fit: BoxFit.cover),
                    )
                  : Assets.images.shopPage.image(
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: PaddingsConstants.instance.homeTrendingDealInsidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: title,
                  fontSize: TextSizeEnum.homeCardsTitleSize.value,
                  color: Theme.of(context).appColors.boldBlack,
                ),

                NormalText(
                  text: description,
                  fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  color: Theme.of(context).appColors.boldBlack,
                ),

                BoldOnboardingText(
                  title: currentPrice,
                  titleSize: TextSizeEnum.homeCardsTitleSize.value,
                  titleColor: Theme.of(context).appColors.boldBlack,
                ),

                if (oldPrice != null || discountPercent != null)
                  Row(
                    children: [
                      if (oldPrice != null)
                        Padding(
                          padding:
                              PaddingsConstants.instance.homeSortFilterPadding,
                          child: NormalText(
                            text: oldPrice!,
                            color: Theme.of(
                              context,
                            ).appColors.oldPriceGreyColor,
                            fontSize: TextSizeEnum.homeCardsDetailSize.value,
                            textLine: true,
                          ),
                        ),

                      if (discountPercent != null)
                        NormalText(
                          text: discountPercent!,
                          color: Theme.of(context).appColors.offRedColor,
                          fontSize: TextSizeEnum.homeCardsDetailSize.value,
                        ),
                    ],
                  ),

                if (showStars) StarTextWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCardDecoration {
  static BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
