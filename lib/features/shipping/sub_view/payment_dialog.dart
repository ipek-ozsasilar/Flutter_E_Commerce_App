import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class PaymentSuccessModaDialog extends StatelessWidget {
  const PaymentSuccessModaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: PaddingsConstants.instance.paymentSuccessDialogPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).appColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon with Animation
            Padding(
              padding: PaddingsConstants.instance.paymentSuccessDialogIconPadding,
              child: Container(
                width: WidgetSizeEnum.paymentSuccessDialogWidthAndHeight.value,
                height: WidgetSizeEnum.paymentSuccessDialogWidthAndHeight.value,
                decoration: BoxDecoration(
                  color: Theme.of(context).appColors.sizzlingRed,
                  shape: BoxShape.circle,
                ),
                child: GlobalIcon(
                  icon: IconsEnum.iconCheck.icon, 
                  color: Theme.of(context).appColors.whiteColor,
                   size: IconSizeEnum.paymentSuccessDialogIconSize.value),
              ),
            ),

           

            // Success Message
            BoldOnboardingText(
              title: LocaleKeys.paymentSuccess.tr(),
              titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
              titleColor: Theme.of(context).appColors.boldBlack,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}