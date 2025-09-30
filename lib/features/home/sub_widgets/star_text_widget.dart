import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class StarTextWidget extends StatelessWidget {
  const StarTextWidget({super.key, this.product});
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(getStarCount(), (index) {
          return Icon(
            Icons.star,
            size: IconSizeEnum.homeStarIconSize.value,
            color: Theme.of(context).appColors.starYellowColor,
          );
        }),

        Padding(
          padding: PaddingsConstants.instance.homeStarTextPadding,
          child: NormalText(
            text: product?.reviewsCount.toString() ?? "",
            fontSize: TextSizeEnum.homeCardsDetailSize.value,
            color: Theme.of(context).appColors.starYellowColor,
          ),
        ),
      ],
    );
  }

  int getStarCount() {
    if (product?.rating != null) {
      final rating = product!.rating!;

      // Rating değeri 1-5 arasındaysa direkt kullan
      if (rating >= 1 && rating <= 5) {
        return rating;
      }
      // Rating 0-1 arasında double değer olabilir, 5'e çarp
      else if (rating >= 0 && rating <= 1) {
        return (rating * 5).round().clamp(1, 5);
      }
      // Diğer durumlar için 5 yıldız
      else {
        return 5;
      }
    } else {
      return 5; // Rating yoksa 5 yıldız göster
    }
  }
}
