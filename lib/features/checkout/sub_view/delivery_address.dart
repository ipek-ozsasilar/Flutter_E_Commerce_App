import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: WidgetSizeEnum.deliveryAddressContainerHeight.value,
          //ekranın %70'ini kullan
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).appColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).appColors.boldBlack.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalText(
                    text: LocaleKeys.address.tr()+" :",
                    color: Theme.of(context).appColors.boldBlack,
                    fontSize: TextSizeEnum.homeCardsTitleSize.value,
                  ),

                  HomeIconButton(
                    icon: IconsEnum.iconEdit.icon, 
                    color: Theme.of(context).appColors.boldBlack,
                     size: IconSizeEnum.homeIconSize.value)  
                ],
              ),

              NormalText(
                text: "216 St Paul's Rd, London N1 2LL, UK",
                color: Theme.of(context).appColors.boldBlack,
                fontSize: TextSizeEnum.homeCardsTitleSize.value,
              ),
              Spacer(),
              NormalText(
                text: "Contact : +44-784232",
                color: Theme.of(context).appColors.boldBlack,
                fontSize: TextSizeEnum.homeCardsTitleSize.value,
              ),
            ],
          ),
        ),

        SizedBox(width: MediaQuery.of(context).size.width * 0.05),

        Container(
          height: WidgetSizeEnum.deliveryAddressContainerHeight.value,
          //ekranın %70'ini kullan
          width: MediaQuery.of(context).size.width * 0.3,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).appColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).appColors.boldBlack.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: HomeIconButton(
            icon: Icons.add,
            color: Theme.of(context).appColors.boldBlack,
            size: IconSizeEnum.homeIconSize.value,
          ),
        ),
      ],
    );
  }
}
