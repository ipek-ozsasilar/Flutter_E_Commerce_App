import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';


class RichTextWidget extends StatelessWidget {
   const RichTextWidget({
    super.key,
    required this.tapGestureRecognizer,
    required this.text,
    required this.secondText,
  });

  final TapGestureRecognizer tapGestureRecognizer;
  final String text;
  final String secondText;
  @override
Widget build(BuildContext context) {
  final TextSpan span;

  if (secondText == LocaleKeys.forgotPasswordDetail.tr()) {
    // Forgot password durumuna özel yapı
    span = TextSpan(
      text: text + "  ",
      style: TextStyle(
        fontSize: TextSizeEnum.loginInputHintTextSize.value,
        color: ColorName.sizzlingRed.withOpacity(0.8),
      ),
      children: [
        TextSpan(
          text: secondText,
          style: TextStyle(
            fontSize: TextSizeEnum.loginInputHintTextSize.value,
            color: ColorName.loginShadowMountain,
          ),
        ),
      ],
    );
  } else {
    // Register yazısı link gibi olacaksa
    span = TextSpan(
      text: text + " ",
      style: TextStyle(
        fontSize: TextSizeEnum.loginInputHintTextSize.value,
        color: ColorName.loginShadowMountain,
      ),
      children: [
        TextSpan(
          text: secondText,
          style: TextStyle(
            fontSize: TextSizeEnum.loginInputHintTextSize.value,
            color: ColorName.sizzlingRed.withOpacity(0.8),
            decoration: TextDecoration.underline,
          ),
          recognizer: tapGestureRecognizer,
        ),
      ],
    );
  }

  return RichText(text: span);
}

}

