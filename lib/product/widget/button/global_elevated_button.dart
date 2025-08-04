import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/login_view_model.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalElevatedButton extends ConsumerWidget {
  GlobalElevatedButton({super.key, required this.text, this.onPressed, this.isLoading});

  final String text;
  VoidCallback? onPressed;
  bool? isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: isLoading == false ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadiusConstants.instance.circularSmallBorderRadius,
        ),
        minimumSize: Size(
          double.infinity,
          WidgetSizeEnum.loginButtonHeight.value,
        ),

        backgroundColor: ColorName.sizzlingRed.withOpacity(0.8),
        padding: PaddingsConstants.instance.loginButtonPadding,
      ),
      child: isLoading == true
          ? const CircularProgressIndicator(color: ColorName.whiteColor)
          : NormalText(text: text, color: ColorName.whiteColor, fontSize: TextSizeEnum.loginButtonTextSize.value),
    );
  }
}
