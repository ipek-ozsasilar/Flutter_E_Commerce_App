import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class homeBottomNavigationBar extends StatelessWidget {
  const homeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appColors.whiteColor,
      height: WidgetSizeEnum.homeBottomNavigationBarHeight.value,
      child: Padding(
        padding: PaddingsConstants.instance.homeBottomNavigationBarPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                HomeIconButton(
                  icon: IconsEnum.iconHome.icon,
                  color: Theme.of(context).appColors.boldBlack,
                  size: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarIconSize
                      .value,
                ),
                NormalText(
                  text: LocaleKeys.home.tr(),
                  color: Theme.of(context).appColors.boldBlack,
                  fontSize: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarTextSize
                      .value,
                ),
              ],
            ),
            Column(
              children: [
                HomeIconButton(
                  icon: IconsEnum.iconFavorite.icon,
                  color: Theme.of(context).appColors.boldBlack,
                  size: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarIconSize
                      .value,
                ),
                NormalText(
                  text: LocaleKeys.wishlist.tr(),
                  color: Theme.of(context).appColors.boldBlack,
                  fontSize: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarTextSize
                      .value,
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -20), // ikonu yukarı kaydırır
              child: Container(
                padding : PaddingsConstants.instance.homeBottomNavigationBarBasketInsidePadding,
                decoration: homeBottomNavigationBasketDecoration(context),
                child: HomeIconButton(
                  icon: IconsEnum.iconShoppingBasket.icon,
                  color: Theme.of(context).appColors.boldBlack,
                  size: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarIconSize
                      .value,
                ),
              ),
            ),

            Column(
              children: [
                HomeIconButton(
                  icon: IconsEnum.iconSearch.icon,
                  color: Theme.of(context).appColors.boldBlack,
                  size: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarIconSize
                      .value,
                ),
                NormalText(
                  text: LocaleKeys.search.tr(),
                  color: Theme.of(context).appColors.boldBlack,
                  fontSize: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarTextSize
                      .value,
                ),
              ],
            ),
            Column(
              children: [
                HomeIconButton(
                  icon: IconsEnum.iconSettings.icon,
                  color: Theme.of(context).appColors.boldBlack,
                  size: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarIconSize
                      .value,
                ),
                NormalText(
                  text: LocaleKeys.settings.tr(),
                  color: Theme.of(context).appColors.boldBlack,
                  fontSize: BottomNavigationBarSizeEnum
                      .homeBottomNavigationBarTextSize
                      .value,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration homeBottomNavigationBasketDecoration(BuildContext context) {
    return BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).appColors.whiteColor, // Arkaplan rengi (örneğin beyaz)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              );
  }
}
