import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/login_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/input/login_input.dart';
import 'package:flutter_e_commerce_app/product/widget/text/rich_text.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();

  
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TapGestureRecognizer _tapGestureRecognizer;
  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () => NavigatorManager.instance.navigatePage(context, ForgotPassword());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarLogin(title: LocaleKeys.forgotPassword.tr()) as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: Column(
          children: [
            loginInput(
              hintText: LocaleKeys.enterYourEmail.tr(),
              icon: Icons.email_rounded,
              color: ColorName.loginInputIconsGrey,
            ),

            Padding(
              padding: PaddingsConstants.instance.forgotPasswordDetailPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichTextWidget(tapGestureRecognizer: _tapGestureRecognizer, text: "*", secondText: LocaleKeys.forgotPasswordDetail.tr()),
              ),
            ),

            GlobalElevatedButton(text: LocaleKeys.submit.tr()),
          ],
        ),
      ),
    );
  }
}
