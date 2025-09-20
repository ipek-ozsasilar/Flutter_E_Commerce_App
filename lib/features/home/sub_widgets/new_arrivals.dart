import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_e_commerce_app/product/widget/button/outlined_icon_text_button.dart';



class NewArrivalsWidget extends StatelessWidget {
  const NewArrivalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizeEnum.newArrivalsContainerHeight.value,
      decoration: HomeContainerDecoration.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Assets.images.shopPage.image(
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: PaddingsConstants.instance.homeSortFilterPadding,
                    child: BoldOnboardingText(
                      title: "New Arrivals",
                      titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                      titleColor: Theme.of(context).appColors.boldBlack,
                    ),
                  ),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NormalText(
                        text: "Summer' 25 Collections",
                        fontSize: TextSizeEnum.homeCardsDetailSize.value,
                        color: Theme.of(context).appColors.boldBlack,
                      ),
                      outlinedButton(
                        backgroundColor: true,
                        text: LocaleKeys.viewAll.tr(),
                        icon: IconsEnum.iconForward.icon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}