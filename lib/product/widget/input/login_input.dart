import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_icon_button.dart';

class loginInput extends StatelessWidget {
  loginInput({super.key, required this.hintText, required this.icon, required this.color});

  final String hintText;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorName.splashUltimateGreyText.withOpacity(0.15),
        hintStyle: TextStyle(color: ColorName.loginInputHintText, fontSize: TextSizeEnum.loginInputHintTextSize.value),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorName.loginInputHintText.withOpacity(0.2)),
          borderRadius:
              BorderRadiusConstants.instance.circularSmallBorderRadius,
        ),
        prefixIcon: GlobalIconButton(hintText: hintText, icon: icon, color: color),
        suffixIcon: hintText==LocaleKeys.inputPassword.tr() || hintText==LocaleKeys.confirmPassword.tr()? GlobalIconButton(hintText: hintText, icon: Icons.visibility_off_outlined, color: color):null,
      ),
    );
  }
}
