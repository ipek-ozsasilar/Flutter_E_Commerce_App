import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_e_commerce_app/features/login/create_account.dart';
import 'package:flutter_e_commerce_app/features/login/forgot_password.dart';
import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart'
    hide FormState;
import 'package:flutter_e_commerce_app/features/login/view_model/login_view_model.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/login_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_text_button.dart';
import 'package:flutter_e_commerce_app/product/widget/button/other_login_button.dart';
import 'package:flutter_e_commerce_app/product/widget/input/login_input.dart';
import 'package:flutter_e_commerce_app/product/widget/text/rich_text.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWelcomeBack extends ConsumerStatefulWidget {
  const LoginWelcomeBack({super.key});

  @override
  ConsumerState<LoginWelcomeBack> createState() => _LoginWelcomeBackState();
}

class _LoginWelcomeBackState extends ConsumerState<LoginWelcomeBack>
    with LoginViewModel {
  late TapGestureRecognizer _tapGestureRecognizer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        ref.read(formProvider.notifier).clearTextEmail();
        ref.read(formProvider.notifier).clearTextPassword();
        ref.read(formProvider.notifier).clearTextConfirmPassword();
        NavigatorManager.instance.navigatePage(context, CreateAccount());
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = ref.watch(formProvider.notifier).emailController;
    final passwordController = ref
        .watch(formProvider.notifier)
        .passwordController;
    return Scaffold(
      appBar:
          CustomAppbarLogin(title: LocaleKeys.welcomeBack.tr())
              as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            shrinkWrap: true,
            children: [
              loginInput(
                hintText: LocaleKeys.inputUsernameEmail.tr(),
                prefixIcon: Icons.person_rounded,
                suffixIcon: AnimatedIcons.close_menu,
                color: ColorName.loginInputIconsGrey,
                formKey: _formKey,
                controller: emailController,
              ),
              Padding(
                padding: PaddingsConstants.instance.loginWelcomeInputPadding,
                child: loginInput(
                  hintText: LocaleKeys.inputPassword.tr(),
                  prefixIcon: Icons.lock,
                  suffixIcon: AnimatedIcons.menu_home,
                  color: ColorName.loginInputIconsGrey,
                  formKey: _formKey,
                  controller: passwordController,
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
                child: GlobalElevatedButton(
                  text: LocaleKeys.login.tr(),
                  onPressed: () => loginWithEmailAndPasswordCheck(context),
                  isLoading: listenLoading(),
                  child: loadingWidgetCheck(LocaleKeys.login.tr()),
                ),
              ),

              

              Center(
                child: NormalText(
                  text: LocaleKeys.continueOtherLogin.tr(),
                  color: ColorName.loginShadowMountain,
                  fontSize: TextSizeEnum.loginInputHintTextSize.value,
                ),
              ),

              Padding(
                padding:
                    PaddingsConstants.instance.otherLoginButtonVerticalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const otherLoginButton(
                      icon: Icons.g_mobiledata,
                      color: ColorName.boldBlack,
                    ),
                    Padding(
                      padding: PaddingsConstants
                          .instance
                          .otherLoginButtonHorizontalPadding,
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
      ),
    );
  }
}
