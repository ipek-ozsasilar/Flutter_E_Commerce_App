import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

  class CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CheckoutAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BoldOnboardingText(
        title: LocaleKeys.checkout.tr(),
        titleSize: TextSizeEnum.ProfileCheckoutTitleSize.value,
        titleColor: Theme.of(context).appColors.boldBlack,
      ),
      centerTitle: true,
      leadingWidth: AppbarSizeEnum.homeLeadingWidth.value,
      leading: Padding(
        padding: PaddingsConstants.instance.profileAppbarLeadingPadding,
        child: HomeIconButton(
          icon: IconsEnum.iconBack.icon,
          color: Theme.of(context).appColors.boldBlack,
          size: TextSizeEnum.ProfileCheckoutTitleSize.value,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}