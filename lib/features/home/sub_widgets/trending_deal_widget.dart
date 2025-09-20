import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/outlined_icon_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class TrendingDealDayViewAll extends StatelessWidget {


  const TrendingDealDayViewAll({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.icon,
    required this.subText,
  });
  final Color backgroundColor;
  final String text;
  final IconData icon;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingsConstants.instance.homeTrendingDealInsidePadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(text: text, fontSize: TextSizeEnum.homeTrendingDealTitleSize.value, color: Theme.of(context).appColors.whiteColor),
              Row(
                children: [
                  Padding(
                    padding: PaddingsConstants.instance.homeSortFilterPadding,
                    child: Icon(icon, color: Theme.of(context).appColors.whiteColor),
                  ),
                  NormalText(
                    fontSize: TextSizeEnum.homeDescriptionSize.value,
                    text: subText,
                    color: Theme.of(context).appColors.whiteColor,
                  ),
                ],
              ),
            ],
          ),

          outlinedButton(
            text: LocaleKeys.viewAll.tr(),
            icon: IconsEnum.iconForward.icon,
          ),
        ],
      ),
    );
  }
}