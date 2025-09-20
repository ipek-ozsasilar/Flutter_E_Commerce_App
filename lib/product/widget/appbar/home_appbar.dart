import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
      import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/circle_avatar.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

  class HomeCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeCustomAppbar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(AppbarSizeEnum.homeToolbarHeight.value);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppbarSizeEnum.homeToolbarHeight.value,
      title: Padding(
        padding: PaddingsConstants.instance.homeAppbarPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Assets.icons.splashIcon.image(
              width: IconSizeEnum.homeAppbarIconSize.value,
              height: IconSizeEnum.homeAppbarIconSize.value,
            ),
            BoldOnboardingText(
              title: LocaleKeys.splashStylish.tr(),
              titleSize: TextSizeEnum.homeAppbarTitleSize.value,
              titleColor: Theme.of(context).appColors.dealOfTheDayBlue,
            ),
          ],
        ),
      ),
      leadingWidth: AppbarSizeEnum.homeLeadingWidth.value,
      leading: Padding(
        padding: PaddingsConstants.instance.homeAppbarLeadingPadding,
        child: HomeIconButton(
          icon: IconsEnum.iconMenu.icon,
          color: Theme.of(context).appColors.boldBlack,
          size: IconSizeEnum.homeSortFilterIconSize.value,
        ),
      ),
      actions: [
        Padding(
          padding: PaddingsConstants.instance.homeAppbarActionsPadding,
          child: CircleAvatarWidget(),
        ),
      ],
    );
  }
}