import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart' hide FormState;
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});
  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () =>
          NavigatorManager.instance.navigatePage(context, LoginWelcomeBack());
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = ref
        .watch(formProvider.notifier)
        .emailController;
    final passwordController = ref
        .watch(formProvider.notifier)
        .passwordController;
    final confirmPasswordController = ref
        .watch(formProvider.notifier)
        .confirmPasswordController;

    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar:
          CustomAppbarLogin(title: LocaleKeys.createAnAccount.tr())
              as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            shrinkWrap: true,
            children: [
              // Username/email
              loginInput(
                hintText: LocaleKeys.createAccount.tr(),
                prefixIcon: Icons.person_rounded,
                suffixIcon: AnimatedIcons.close_menu,
                color: ColorName.loginInputIconsGrey,
                formKey: _formKey,
                controller: emailController,
              ),

              // Password
              Padding(
                padding:
                    PaddingsConstants.instance.createAccountPasswordPadding,
                child: loginInput(
                  hintText: LocaleKeys.inputPassword.tr(),
                  prefixIcon: Icons.lock,
                  suffixIcon: AnimatedIcons.pause_play,
                  color: ColorName.loginInputIconsGrey,
                  controller: passwordController,

                  formKey: _formKey,
                ),
              ),

              // Confirm Password
              loginInput(
                hintText: LocaleKeys.confirmPassword.tr(),
                prefixIcon: Icons.lock,
                suffixIcon: AnimatedIcons.pause_play,
                color: ColorName.loginInputIconsGrey,
                formKey: _formKey,
                controller:
                    confirmPasswordController, // Confirm password controller
              ),

              Padding(
                padding: PaddingsConstants.instance.createAccountButtonPadding,
                child: Center(child: _createAccountRichText()),
              ),

              // Create Account Button
              GlobalElevatedButton(text: LocaleKeys.createAccount.tr()),

              Padding(
                padding: PaddingsConstants.instance.orContinuePadding,
                child: Center(
                  child: NormalText(
                    text: LocaleKeys.continueOtherLogin.tr(),
                    color: ColorName.loginShadowMountain,
                    fontSize: 13,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  otherLoginButton(
                    icon: Icons.g_mobiledata,
                    color: ColorName.boldBlack,
                  ),
                  Padding(
                    padding: PaddingsConstants
                        .instance
                        .otherLoginButtonHorizontalPadding,
                    child: otherLoginButton(
                      icon: Icons.apple,
                      color: ColorName.boldBlack,
                    ),
                  ),
                  otherLoginButton(
                    icon: Icons.facebook_outlined,
                    color: ColorName.facebookBlue,
                  ),
                ],
              ),
              Padding(
                padding:
                    PaddingsConstants.instance.createAccountRichTextPadding,
                child: Center(
                  child: RichTextWidget(
                    tapGestureRecognizer: _tapGestureRecognizer,
                    text: LocaleKeys.IHaveAnAccount.tr(),
                    secondText: LocaleKeys.login.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText _createAccountRichText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: LocaleKeys.byClickingThe.tr() + " ",
        style: TextStyle(
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
            style: TextStyle(
              fontSize: TextSizeEnum.loginInputHintTextSize.value,
              color: ColorName.loginShadowMountain,
            ),
          ),
        ],
      ),
    );
  }
}
