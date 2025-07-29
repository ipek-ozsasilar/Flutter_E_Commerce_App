import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_e_commerce_app/features/login/forgot_password.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/login_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/other_login_button.dart';
import 'package:flutter_e_commerce_app/product/widget/input/login_input.dart';
import 'package:flutter_e_commerce_app/product/widget/text/rich_text.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late TapGestureRecognizer _tapGestureRecognizer;
  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () =>
          NavigatorManager.instance.navigatePage(context, LoginWelcomeBack());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarLogin(title: LocaleKeys.createAnAccount.tr()) as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: ListView(
          shrinkWrap: true,
          children: [
            // Username/email
            loginInput(
              hintText: LocaleKeys.createAccount.tr(),
              icon: Icons.person_rounded,
              color: ColorName.loginInputIconsGrey,
            ),

            // Password
            Padding(
              padding: PaddingsConstants.instance.createAccountPasswordPadding,
              child: loginInput(
                hintText: LocaleKeys.inputPassword.tr(),
                icon: Icons.lock,
                color: ColorName.loginInputIconsGrey,
              ),
            ),

            // Confirm Password
            loginInput(
              hintText: LocaleKeys.confirmPassword.tr(),
              icon: Icons.lock,
              color: ColorName.loginInputIconsGrey,
            ),

            Padding(
              padding: PaddingsConstants.instance.createAccountButtonPadding,
              child: Center(
                child: createAccountRichText(),
              ),
            ),


            // Create Account Button
            GlobalElevatedButton(text: LocaleKeys.createAccount.tr()),

            Padding(
              padding: PaddingsConstants.instance.orContinuePadding,
              child: Center(
                child: NormalText(text: LocaleKeys.continueOtherLogin.tr(), color: ColorName.loginShadowMountain, fontSize: 13),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
                otherLoginButton(icon: Icons.g_mobiledata, color: ColorName.boldBlack),
                Padding(
                  padding: PaddingsConstants.instance.otherLoginButtonHorizontalPadding,
                  child: otherLoginButton(icon: Icons.apple, color: ColorName.boldBlack),
                ),
                otherLoginButton(icon: Icons.facebook_outlined, color: ColorName.facebookBlue),
              ],
            ),
            Padding(
              padding: PaddingsConstants.instance.createAccountRichTextPadding,
              child: Center(
                child: RichTextWidget(tapGestureRecognizer: _tapGestureRecognizer, text: LocaleKeys.IHaveAnAccount.tr(), secondText: LocaleKeys.login.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RichText createAccountRichText() {
    return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: LocaleKeys.byClickingThe.tr() + " ",
                  style:  TextStyle(
                    fontSize: TextSizeEnum.loginInputHintTextSize.value,
                    color: ColorName.loginShadowMountain,
                  ),
                  children: [
                    TextSpan(
                      text: LocaleKeys.register.tr() + " ",
                      style: TextStyle(
                        color: ColorName.sizzlingRed.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: _tapGestureRecognizer,
                      
                    ),
                    TextSpan(
                      text: LocaleKeys.buttonYouAgreeToThePublicOffer.tr(),
                      style:  TextStyle(
                        fontSize: TextSizeEnum.loginInputHintTextSize.value,
                        color: ColorName.loginShadowMountain,
                      ),
                    ),
                  ],
                ),
              );
  }
}
