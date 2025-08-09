import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class CustomAppbarLogin extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbarLogin({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: showBackButton
          ? 160
          : AppbarSizeEnum.loginToolbarHeight.value,
      leadingWidth: AppbarSizeEnum.loginLeadingWidth.value,
      leading: showBackButton ?
      Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                      onPressed: () =>
                          NavigatorManager.instance.closePagePop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ColorName.boldBlack,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
      
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: BoldOnboardingText(
                      title: title,
                      titleSize: TextSizeEnum.loginWelcomeSize.value,
                      titleColor: ColorName.boldBlack,
                    ),
                  ),
                ],
              ): Padding(
        padding: PaddingsConstants.instance.loginAppbarPadding,
        child:  BoldOnboardingText(
                title: title,
                titleSize: TextSizeEnum.loginWelcomeSize.value,
                titleColor: ColorName.boldBlack,
              ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    showBackButton ? 160 : AppbarSizeEnum.loginToolbarHeight.value,
  );
}
