import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class GlobalElevatedButton extends StatelessWidget {
  const GlobalElevatedButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusConstants.instance.circularSmallBorderRadius,
        ),
        minimumSize: Size(double.infinity, WidgetSizeEnum.loginButtonHeight.value),
    
        backgroundColor: ColorName.sizzlingRed.withOpacity(0.8),
        padding: PaddingsConstants.instance.loginButtonPadding,
      ),
      child: NormalText(text: text, color: ColorName.whiteColor, fontSize: 15),
    );
  }
}
