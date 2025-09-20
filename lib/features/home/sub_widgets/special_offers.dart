import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';



class HomeSpecialOffersWidget extends StatelessWidget {
  const HomeSpecialOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: HomeContainerDecoration.containerDecoration(),
      child: Row(   
        children: [
          Assets.images.shopPage.image(width: 120, height: 120),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: LocaleKeys.specialOffers.tr(),
                  fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                  color: Theme.of(context).appColors.boldBlack,
                ),
                SizedBox(height: 4),
                NormalText(
                  text: LocaleKeys.weMakeSureYouGetTheOfferYouNeedAtBestPrices
                      .tr(),
                  fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  color: Theme.of(context).appColors.boldBlack,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}