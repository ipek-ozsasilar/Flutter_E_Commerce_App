import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class SponsordWidget extends StatelessWidget {
  const SponsordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingsConstants.instance.homeTrendingDealInsidePadding,
      height: WidgetSizeEnum.homeSponsordHeight.value,
      decoration: HomeContainerDecoration.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PaddingsConstants.instance.homeSponsordPadding,
            child: BoldOnboardingText(
              title: "Sponsord",
              titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              titleColor: Theme.of(context).appColors.boldBlack,
            ),
          ),
          
          Expanded(
            flex: 4,
            child: Assets.images.shopPage.image(
              fit: BoxFit.cover,
               width: ImageSizeEnum.homeSponsordWidth.value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldOnboardingText(
                title: "up to 50% off",
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.boldBlack,
              ),
              IconButton(
                onPressed: () {},
                icon: GlobalIcon(icon: IconsEnum.iconForward.icon, size: IconSizeEnum.homeSortFilterIconSize.value, color: Theme.of(context).appColors.boldBlack),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

