import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class PaymentMethodCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  const PaymentMethodCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: PaymentContainerDecoration(context),
      child: ListTile(
        onTap: onTap,
        title: BoldOnboardingText(
          title: title,
          titleSize: TextSizeEnum.homeCardsTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),
        subtitle: NormalText(
          text: subtitle,
          color: Theme.of(context).appColors.starNumberGreyColor,
          fontSize: TextSizeEnum.homeCardsDetailSize.value,
        ),
        trailing: Container(
          width: WidgetSizeEnum.profileEditButtonWidthAndHeight.value,
          height: WidgetSizeEnum.profileEditButtonWidthAndHeight.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).appColors.sizzlingRed
                  : Theme.of(context).appColors.starNumberGreyColor,
              width: 2,
            ),
            color: isSelected
                ? Theme.of(context).appColors.sizzlingRed
                : Colors.transparent,
          ),
          child: isSelected
              ? GlobalIcon(
                  icon: IconsEnum.iconCheck.icon,
                  color: Theme.of(context).appColors.whiteColor,
                  size: IconSizeEnum.homePaymentCardIconSize.value,
                )
              : null,
        ),
      ),
    );
  }

  BoxDecoration PaymentIconContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).appColors.secondaryBackgroundColor,
      borderRadius: BorderRadius.circular(8),
    );
  }

  BoxDecoration PaymentContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).appColors.hideCardNumberGrey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected
            ? Theme.of(context).appColors.sizzlingRed
            : Theme.of(context).appColors.starNumberGreyColor.withOpacity(0.3),
        width: isSelected ? 2 : 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).appColors.boldBlack.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
