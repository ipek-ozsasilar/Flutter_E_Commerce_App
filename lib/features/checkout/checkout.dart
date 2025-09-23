import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/checkout/sub_view/delivery_address.dart';
import 'package:flutter_e_commerce_app/features/checkout/sub_view/shooping_list_section.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/star_text_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/checkout_profile_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:easy_localization/easy_localization.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: ListView(
          children: [
            Divider(),
            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: DeliveryAddressAndIconMethod(context),
            ),

            // Delivery Address Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DeliveryAddressSection(),
            ),

            
            Padding(
              padding: PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: BoldOnboardingText(
                title: LocaleKeys.shoppingList.tr(),
                titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                titleColor: Theme.of(context).appColors.boldBlack,
              ),
            ),

            
            // Shopping List Section
            ShoppingListSection(),

            
          ],
        ),
      ),
    );
  }

  Row DeliveryAddressAndIconMethod(BuildContext context) {
    return Row(
      children: [
        GlobalIcon(
          icon: IconsEnum.iconLocation.icon,
          color: Theme.of(context).appColors.boldBlack,
          size: IconSizeEnum.homeSortFilterIconSize.value,
        ),

        BoldOnboardingText(
          title: LocaleKeys.deliveryAddress.tr(),
          titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),
      ],
    );
  }
}
