import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/star_text_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class DealOfTheDayCardsWidget extends StatelessWidget {
  const DealOfTheDayCardsWidget({super.key, this.products});
  final List<ProductModel>? products;

  @override
  Widget build(BuildContext context) {
    // Eğer products listesi yoksa boş liste kullan
    final productList = products ?? [];

    return Container(
      height: WidgetSizeEnum.homeCardsContainerHeight.value,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productList.isNotEmpty
            ? productList.length
            : 5, // ürün sayısı
        separatorBuilder: (context, index) => SizedBox(width: 15),
        itemBuilder: (context, index) {
          // Eğer gerçek ürünler varsa onları kullan, yoksa null geç
          final product = productList.isNotEmpty && index < productList.length
              ? productList[index]
              : null;

          return Container(
            width: WidgetSizeEnum.homeCardsContainerWidth.value,
            decoration: HomeContainerDecoration.containerDecoration(),
            child: DealOfTheDayCards(product: product),
          );
        },
      ),
    );
  }
}

class DealOfTheDayCards extends StatelessWidget {
  DealOfTheDayCards({super.key, this.product});
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: product?.imageUrl != null
                ? Image.network(product!.imageUrl!,fit: BoxFit.cover,)
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
                text: product?.name ?? "",
                fontSize: TextSizeEnum.homeCardsTitleSize.value,
                color: Theme.of(context).appColors.boldBlack,
              ),

              NormalText(
                text: product?.description ?? "",
                fontSize: TextSizeEnum.homeCardsDetailSize.value,
                color: Theme.of(context).appColors.boldBlack,
              ),

              BoldOnboardingText(
                title: "  ₹${product?.price ?? 0}",
                titleSize: TextSizeEnum.homeCardsTitleSize.value,
                titleColor: Theme.of(context).appColors.boldBlack,
              ),

              StarTextWidget(product: product),
            ],
          ),
        ),
      ],
    );
  }
}
