import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_e_commerce_app/features/login/create_account.dart';
import 'package:flutter_e_commerce_app/features/login/forgot_password.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/login_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/other_login_button.dart';
import 'package:flutter_e_commerce_app/product/widget/input/login_input.dart';
import 'package:flutter_e_commerce_app/product/widget/text/rich_text.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class LoginWelcomeBack extends StatefulWidget {
  const LoginWelcomeBack({super.key});

  @override
  State<LoginWelcomeBack> createState() => _LoginWelcomeBackState();
}

class _LoginWelcomeBackState extends State<LoginWelcomeBack> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () =>
          NavigatorManager.instance.navigatePage(context, CreateAccount());
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppbarLogin(title: LocaleKeys.welcomeBack.tr())
              as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: ListView(
          shrinkWrap: true,
          children: [
            loginInput(
              hintText: LocaleKeys.inputUsernameEmail.tr(),
              icon: Icons.person_rounded,
              color: ColorName.loginInputIconsGrey,
            ),
            Padding(
              padding: PaddingsConstants.instance.loginWelcomeInputPadding,
              child: loginInput(
                hintText: LocaleKeys.inputPassword.tr(),
                icon: Icons.lock,
                color: ColorName.loginInputIconsGrey,
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: GlobalTextButton(
                onPressed: () => NavigatorManager.instance.navigatePage(
                  context,
                  ForgotPassword(),
                ),
                text: LocaleKeys.forgotPassword.tr(),
                color: ColorName.sizzlingRed.withOpacity(0.8),
              ),
            ),

            Padding(
              padding: PaddingsConstants.instance.welcomeLoginButtonPadding,
              child: GlobalElevatedButton(text: LocaleKeys.login.tr()),
            ),

            Center(
              child: NormalText(
                text: LocaleKeys.continueOtherLogin.tr(),
                color: ColorName.loginShadowMountain,
                fontSize: TextSizeEnum.loginInputHintTextSize.value,
              ),
            ),

            Padding(
              padding: PaddingsConstants.instance.otherLoginButtonVerticalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const otherLoginButton(
                    icon: Icons.g_mobiledata,
                    color: ColorName.boldBlack,
                  ),
                  Padding(
                    padding: PaddingsConstants.instance.otherLoginButtonHorizontalPadding,
                    child: const otherLoginButton(
                      icon: Icons.apple,
                      color: ColorName.boldBlack,
                    ),
                  ),
                  const otherLoginButton(
                    icon: Icons.facebook_outlined,
                    color: ColorName.facebookBlue,
                  ),
                ],
              ),
            ),
            Center(
              child: RichTextWidget(
                tapGestureRecognizer: _tapGestureRecognizer,
                text: LocaleKeys.createAnAccount.tr(),
                secondText: LocaleKeys.signUp.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
