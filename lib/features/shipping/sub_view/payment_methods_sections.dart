import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shipping/shipping_view.dart';
import 'package:flutter_e_commerce_app/features/shipping/sub_view/payment_card.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/models/add_card_model.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class PaymentMethodsSection extends StatelessWidget {
  final int selectedPaymentMethod;
  final Function(int) onPaymentMethodChanged;
  final List<AddCardModel> cardsList;

  const PaymentMethodsSection({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.cardsList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment Title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: BoldOnboardingText(
            title: LocaleKeys.payment.tr(),
            titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
            titleColor: Theme.of(context).appColors.boldBlack,
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cardsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: PaymentMethodCard(
                
                isSelected: selectedPaymentMethod == index,
                onTap: () => onPaymentMethodChanged(index),
                title: cardsList[index].name ?? "",
                subtitle: cardsList[index].number.toString(),
              ),
            );
          },
        ),
      ],
    );
  }
}
