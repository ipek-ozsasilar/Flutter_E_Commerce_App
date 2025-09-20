import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/star_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class DealOfTheDayCardsWidget extends StatelessWidget {
  const DealOfTheDayCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizeEnum.homeCardsContainerHeight.value,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // ürün sayısı
        separatorBuilder: (context, index) => SizedBox(width: 15),
        itemBuilder: (context, index) {
          return DealOfTheDayCards();
        },
      ),
    );
  }
}



class DealOfTheDayCards extends StatelessWidget {
  const DealOfTheDayCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WidgetSizeEnum.homeCardsContainerWidth.value,
      decoration: HomeContainerDecoration.containerDecoration(),
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Assets.images.shopPage.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: PaddingsConstants.instance.homeTrendingDealInsidePadding ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: LocaleKeys.womenPrintedKurta.tr(),
                  fontSize: TextSizeEnum.homeCardsTitleSize.value,
                  color: Theme.of(context).appColors.boldBlack,
                ),
    
                NormalText(
                  text: LocaleKeys.containerCardDetail.tr(),
                  fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  color: Theme.of(context).appColors.boldBlack,
                ),
    
                BoldOnboardingText(
                  title: "₹1500",
                  titleSize: TextSizeEnum.homeCardsTitleSize.value,
                  titleColor: Theme.of(context).appColors.boldBlack,
                ),
                Row(
                  children: [
                    Padding(
                      padding: PaddingsConstants.instance.homeSortFilterPadding,
                      child: NormalText(
                        text: "₹2400",
                        color: Theme.of(
                          context,
                        ).appColors.oldPriceGreyColor,
                        fontSize: TextSizeEnum.homeCardsDetailSize.value,
                        textLine: true,
                      ),
                    ),
                    
                    NormalText(
                      text: "40% Off",
                      color: Theme.of(context).appColors.offRedColor,
                      fontSize: TextSizeEnum.homeCardsDetailSize.value,
                    ),
                  ],
                ),
    
                StarTextWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}