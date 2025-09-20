import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class TextAndSortFilterWidget extends StatelessWidget {
  const TextAndSortFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BoldOnboardingText(
            title: LocaleKeys.allFeatured.tr(),
            titleSize: TextSizeEnum.homeAppbarTitleSize.value,
            titleColor: Theme.of(context).appColors.boldBlack,
          ),
        ),

        Padding(
          padding: PaddingsConstants.instance.homeSortPadding,
          child: SortFilterWidget(
            text: LocaleKeys.sort.tr(),
                  icon1: IconsEnum.iconUpward.icon,
                  icon2: IconsEnum.iconDownward.icon,
          ),
        ),

        SortFilterWidget(text: LocaleKeys.filter.tr(), icon1: IconsEnum.iconFilter.icon),
      ],
    );
  }
}

class SortFilterWidget extends StatelessWidget {
  SortFilterWidget({
    Key? key,
    required this.text,
    required this.icon1,
    this.icon2,
  }) : super(key: key);
  final String text;
  final IconData icon1;
  final IconData? icon2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 90,
        height: 40,
        padding: PaddingsConstants.instance.homeSortInsidePadding,
        decoration: HomeContainerDecoration.containerDecoration(),
        child: Row(
          children: [
            Padding(
              padding: PaddingsConstants.instance.homeSortFilterPadding,
              child: NormalText(
                text: text,
                color: Theme.of(context).appColors.boldBlack,
                fontSize: TextSizeEnum.loginButtonTextSize.value,
              ),
            ),
            Icon(icon1, size: IconSizeEnum.homeSortFilterIconSize.value),
            if (icon2 != null) Icon(icon2!, size: IconSizeEnum.homeSortFilterIconSize.value),
          ],
        ),
      ),
    );
  }
}