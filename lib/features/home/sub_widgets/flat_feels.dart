import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/outlined_icon_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class FlatAndHeelsWidget extends StatelessWidget {
  const FlatAndHeelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizeEnum.flatAndHeelsContainerHeight.value,
      decoration: HomeContainerDecoration.containerDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Assets.images.shopPage.image(
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: PaddingsConstants.instance.homeTrendingDealInsidePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: PaddingsConstants.instance.homeFlatAndHeelsPadding,
                    child: NormalText(
                      text: LocaleKeys.flatAndHeels.tr(),
                      fontSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                      color: Theme.of(context).appColors.boldBlack,
                    ),
                  ),
                  
                  Padding(
                    padding: PaddingsConstants.instance.homeFlatBottomPadding,
                    child: NormalText(
                      text: LocaleKeys.standAChanceToGetRewarded.tr(),
                      fontSize: TextSizeEnum.homeCardsDetailSize.value,
                      color: Theme.of(context).appColors.boldBlack,
                    ),
                  ),
                  
                    outlinedButton(
                    text: LocaleKeys.visitNow.tr(),
                    icon: IconsEnum.iconForward.icon,
                    backgroundColor: true,
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