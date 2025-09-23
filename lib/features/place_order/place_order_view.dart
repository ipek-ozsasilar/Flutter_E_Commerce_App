import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/place_order/sub_view/apply_coupons_section.dart';
import 'package:flutter_e_commerce_app/features/place_order/sub_view/order_payment_detail_section.dart';
import 'package:flutter_e_commerce_app/features/place_order/sub_view/order_total_section.dart';
import 'package:flutter_e_commerce_app/features/place_order/sub_view/shopping_bag_section.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/checkout_profile_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/place_order_bottom.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class PlaceOrderView extends StatefulWidget {
  const PlaceOrderView({super.key});

  @override
  State<PlaceOrderView> createState() => _PlaceOrderViewState();
}

class _PlaceOrderViewState extends State<PlaceOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.secondaryBackgroundColor,
      appBar: CheckoutAppBar(
        actionIcon: IconsEnum.iconFavorite.icon,
        title: LocaleKeys.shoppingBag.tr(),
      ),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: ListView(
          children: [
            // Shopping Bag Section
            Padding(
              padding: PaddingsConstants.instance.otherLoginButtonVerticalPadding,
              child: ShoppingBagSection(),
            ),

            // Apply Coupons Section
            ApplyCouponsSection(),
            Padding(
              padding: PaddingsConstants.instance.otherLoginButtonVerticalPadding,
              child: Divider(),
            ),

            // Order Payment Details Section
            OrderPaymentDetailsSection(),

            Padding(
              padding: PaddingsConstants.instance.otherLoginButtonVerticalPadding,
              child: Divider(),
            ),

            OrderTotalSection(),
          ],
        ),
      ),
      bottomNavigationBar: PlaceOrderBottomBar(),
    );
  }
}
