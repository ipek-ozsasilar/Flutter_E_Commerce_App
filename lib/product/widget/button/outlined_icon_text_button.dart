import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class outlinedButton extends StatelessWidget {
  const outlinedButton({
    Key? key,
    required this.text,
    required this.icon,
    this.backgroundColor = false,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final bool backgroundColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor
            ? Theme.of(context).appColors.sizzlingRed
            : Colors.transparent,
        side: BorderSide(color: Theme.of(context).appColors.whiteColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: PaddingsConstants.instance.homeOutlinedButtonPadding,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // buton içeriğine göre küçülür
        children: [
          Padding(
            padding: PaddingsConstants.instance.homeSortFilterPadding,
            child: NormalText(
              text: text,
              color: Theme.of(context).appColors.whiteColor,
              fontSize: TextSizeEnum.homeDescriptionSize.value,
            ),
          ),
          GlobalIcon(icon: icon, size: IconSizeEnum.homeSortFilterIconSize.value, color: Theme.of(context).appColors.whiteColor),
        ],
      ),
    );
  }
}