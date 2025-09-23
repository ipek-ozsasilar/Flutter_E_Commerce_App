import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/shopping_bags_dropdown_button.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ShoppingBagsSizeQuantityWidget extends StatefulWidget {
  const ShoppingBagsSizeQuantityWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingBagsSizeQuantityWidget> createState() =>
      _ShoppingBagsSizeQuantityWidgetState();
}

class _ShoppingBagsSizeQuantityWidgetState
    extends State<ShoppingBagsSizeQuantityWidget> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingsConstants.instance.shoppingBagSizeAndQuantityPadding,
      decoration: ShoppingBagsSizeQuantityDecoration(context),
      child: Row(
        children: [
          NormalText(
            text: "Size: ",
            color: Theme.of(context).appColors.boldBlack,
            fontSize: TextSizeEnum.homeCardsTitleSize.value,
          ),

          // Dropdown
          ShoppinBagsDropDownButton(),
        ],
      ),
    );
  }

  BoxDecoration ShoppingBagsSizeQuantityDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        color: Theme.of(context).appColors.starNumberGreyColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }
}
