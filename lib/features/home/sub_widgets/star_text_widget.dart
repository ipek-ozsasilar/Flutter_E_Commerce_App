import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class StarTextWidget extends StatelessWidget {
  const StarTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            Icons.star,
            size: IconSizeEnum.homeStarIconSize.value,
            color: Theme.of(context).appColors.starYellowColor,
          );
        }),

        Padding(
          padding: PaddingsConstants.instance.homeStarTextPadding,
          child: NormalText(
            text: "(56890)",
            fontSize: TextSizeEnum.homeCardsDetailSize.value,
            color: Theme.of(context).appColors.starYellowColor,
          ),
        ),
      ],
    );
  }
}
