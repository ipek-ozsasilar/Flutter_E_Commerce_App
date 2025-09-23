import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';


class PlaceOrderBottomBar extends StatelessWidget {
  const PlaceOrderBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: PlaceOrderBottomContainerDecoration(context),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Total Amount Section
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldOnboardingText(
                    title: "₹ 7,000.00",
                    titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                    titleColor: Theme.of(context).appColors.boldBlack,
                  ),
                  GlobalTextButton(onPressed: (){}, text: "View Details", color: Theme.of(context).appColors.sizzlingRed)
                ],
              ),
            ),

          

            // Proceed to Payment Button
            Expanded(
              child: GlobalElevatedButton(
                text: "Proceed to Payment",
                 onPressed: (){}, 
                 child: NormalText(text: "Proceed to Payment",
                  color: Theme.of(context).appColors.whiteColor, fontSize: TextSizeEnum.loginButtonTextSize.value), isLoadingEmail: false)   
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration PlaceOrderBottomContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).appColors.whiteColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).appColors.boldBlack.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }
}
