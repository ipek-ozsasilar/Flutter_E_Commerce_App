import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class CustomAppbarLogin extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppbarLogin({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppbarSizeEnum.loginToolbarHeight.value,
      leadingWidth: AppbarSizeEnum.loginLeadingWidth.value,
      leading: Padding(
        padding: PaddingsConstants.instance.loginAppbarPadding,
        child: BoldOnboardingText(
          title: title,
          titleSize: TextSizeEnum.loginWelcomeSize.value,
          titleColor: ColorName.boldBlack,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppbarSizeEnum.loginToolbarHeight.value);
}


