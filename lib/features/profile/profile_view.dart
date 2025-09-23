import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/profile/sub_widgets/center_circle_avatar.dart';
import 'package:flutter_e_commerce_app/features/profile/sub_widgets/text_and_input_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/checkout_profile_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/circle_avatar.dart';
import 'package:flutter_e_commerce_app/product/widget/text/rich_text.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(title: LocaleKeys.checkout.tr()),
      body: ListView(
        children: [
          Padding(
            padding: PaddingsConstants.instance.homePagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ProfileCenterCircleAvatarWidget(),
                ),
                BoldOnboardingText(
                  title: LocaleKeys.personalDetails.tr(),
                  titleSize: TextSizeEnum.homeTrendingDealTitleSize.value,
                  titleColor: Theme.of(context).appColors.boldBlack,
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.emailAddress.tr(),
                  hintText: LocaleKeys.emailAddressHint.tr(),
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.password.tr(),
                  hintText: LocaleKeys.password.tr(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GlobalTextButton(
                    onPressed: () {},
                    text: LocaleKeys.changePassword.tr(),
                    color: Theme.of(
                      context,
                    ).appColors.sizzlingRed.withOpacity(0.8),
                  ),
                ),

                DividerPaddingMethod(),

                BoldOnboardingText(
                  title: LocaleKeys.businessAddressDetails.tr(),
                  titleSize: TextSizeEnum.homeTrendingDealTitleSize.value,
                  titleColor: Theme.of(context).appColors.boldBlack,
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.pincode.tr(),
                  hintText: LocaleKeys.pincode.tr(),
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.address.tr(),
                  hintText: LocaleKeys.address.tr(),
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.city.tr(),
                  hintText: LocaleKeys.city.tr(),
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.state.tr(),
                  hintText: LocaleKeys.state.tr(),
                ),
                ProfileTextAndInputWidget(
                  title: LocaleKeys.country.tr(),
                  hintText: LocaleKeys.country.tr(),
                ),

                DividerPaddingMethod(),

                BoldOnboardingText(
                  title: LocaleKeys.bankAccountDetails.tr(),
                  titleSize: TextSizeEnum.homeTrendingDealTitleSize.value,
                  titleColor: Theme.of(context).appColors.boldBlack,
                ),

                ProfileTextAndInputWidget(
                  title: LocaleKeys.bankAccountNumber.tr(),
                  hintText: LocaleKeys.bankAccountNumber.tr(),
                ),

                ProfileTextAndInputWidget(
                  title: LocaleKeys.accountHolderName.tr(),
                  hintText: LocaleKeys.accountHolderName.tr(),
                ),

                ProfileTextAndInputWidget(
                  title: LocaleKeys.ifscCode.tr(),
                  hintText: LocaleKeys.ifscCode.tr(),
                ),

                Padding(
                  padding: PaddingsConstants.instance.profileSaveButtonPadding,
                  child: GlobalElevatedButton(
                    text: LocaleKeys.login.tr(),
                    onPressed: () {},
                    isLoadingEmail: false,
                    child: NormalText(
                      text: LocaleKeys.save.tr(),
                      color: Theme.of(context).appColors.whiteColor,
                      fontSize: TextSizeEnum.homeDescriptionSize.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding DividerPaddingMethod() {
    return Padding(
      padding: PaddingsConstants.instance.profileSaveButtonPadding,
      child: Divider(),
    );
  }
}
