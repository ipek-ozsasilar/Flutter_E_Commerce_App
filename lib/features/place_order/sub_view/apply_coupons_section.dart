import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';

// Apply Coupons Section Widget
class ApplyCouponsSection extends StatelessWidget {
  const ApplyCouponsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Coupon Icon
        Padding(
          padding: PaddingsConstants.instance.profileAppbarActionsPadding,
          child: Container(
            width: IconSizeEnum.homeCouponIconContainerSize.value,
            height: IconSizeEnum.homeCouponIconContainerSize.value,
            decoration: CouponContainerDecorationMethod(context),
            child: GlobalIcon(icon: IconsEnum.iconCoupon.icon, color: Theme.of(context).appColors.boldBlack, size: IconSizeEnum.homeCouponIconSize.value)
          ),
        ),


        // Apply Coupons Text
        Expanded(
          child: BoldOnboardingText(
            title: "Apply Coupons",
            titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
            titleColor: Theme.of(context).appColors.boldBlack,
          ),
        ),

        // Select Button
        GlobalTextButton(onPressed: (){}, text: "Select", color: Theme.of(context).appColors.sizzlingRed)
      ],
    );
  }

  BoxDecoration CouponContainerDecorationMethod(BuildContext context) {
    return BoxDecoration(
          border: Border.all(
            color: Theme.of(context).appColors.boldBlack,
            width: WidgetSizeEnum.couponContainerBorderWidth.value,
          ),
        );
  }
}