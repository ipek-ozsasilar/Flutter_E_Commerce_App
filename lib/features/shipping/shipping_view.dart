import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/payment_dialog.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/payment_methods_sections.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/shipping_order_summary_section.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/models/add_card_model.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/utility/firebase/base_firebase.dart';
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
  int selectedPaymentMethod = 0;
  Future<List<AddCardModel?>>? cardsList;

  @override
  void initState() {
    super.initState();
    cardsList = BaseFirebase<AddCardModel>(
      firebaseCollections: FirebaseCollections.cards,
    ).getData();
  }

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
            FutureBuilder<List<AddCardModel?>>(
              future: cardsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error loading cards'));
                }

                final cards = snapshot.data?.whereType<AddCardModel>().toList() ?? [];

                return PaymentMethodsSection(
                  cardsList: cards,
                  selectedPaymentMethod: selectedPaymentMethod,
                  onPaymentMethodChanged: (index) {
                    setState(() {
                      selectedPaymentMethod = index;
                    });
                  },
                );
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
