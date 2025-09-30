import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/payment_dialog.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/payment_methods_sections.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/shipping_order_summary_section.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/checkout_profile_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/home_bottom_navigation.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ShippingView extends StatefulWidget {
  const ShippingView({super.key});

  @override
  State<ShippingView> createState() => _ShippingViewState();
}

class _ShippingViewState extends State<ShippingView> {
  int selectedPaymentMethod = 0; // 0: Visa, 1: PayPal, 2: Maestro, 3: Apple Pay

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(title: LocaleKeys.checkout.tr()),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: ListView(
          children: [
            Divider(),

            // Order Summary Section
            OrderSummarySection(),

            Divider(),

            // Payment Methods Section
            PaymentMethodsSection(
              selectedPaymentMethod: selectedPaymentMethod,
              onPaymentMethodChanged: (index) {
                setState(() {
                  selectedPaymentMethod = index;
                });
              },
            ),

            GlobalElevatedButton(
              text: LocaleKeys.continueButton.tr(),
              onPressed: () {
                _showSuccessModal(context);
              },
              child: NormalText(
                text: LocaleKeys.continueButton.tr(),
                color: Theme.of(context).appColors.whiteColor,
                fontSize: TextSizeEnum.loginButtonTextSize.value,
              ),
              isLoadingEmail: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: homeBottomNavigationBar(),
    );
  }

  void _showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PaymentSuccessModaDialog();
      },
    );
  }
}

