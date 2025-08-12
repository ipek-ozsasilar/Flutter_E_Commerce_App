import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
// import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart'
    hide FormState;
import 'package:flutter_e_commerce_app/features/login/view_model/create_account_view_model.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
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
// import 'package:flutter_e_commerce_app/features/login/provider/auth_provider.dart';
import 'package:flutter_e_commerce_app/features/login/view_model/google_view_model.dart';
import 'package:flutter_e_commerce_app/features/login/view_model/facebook_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});
  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount>
    with CreateAccountViewModel, GoogleViewModel, FacebookViewModel {
  late TapGestureRecognizer _tapGestureRecognizerLogin;
  late TapGestureRecognizer _tapGestureRecognizerPrivacy;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizerLogin = TapGestureRecognizer()
      ..onTap = () =>
          NavigatorManager.instance.navigatePage(context, LoginWelcomeBack());

    _tapGestureRecognizerPrivacy = TapGestureRecognizer()
      ..onTap = () async => await _launchURL();
  }

  @override
  void dispose() {
    // gizlilik politikasını okudum lınkıne gıt
    _tapGestureRecognizerLogin.dispose();
    _tapGestureRecognizerPrivacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = ref.watch(formProvider.notifier).emailController;
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
                hintText: LocaleKeys.exampleEmail.tr(),
                prefixIcon: Icons.person_rounded,
                suffixIcon: AnimatedIcons.close_menu,
                color: Theme.of(context).appColors.loginInputIconsGrey,
                formKey: _formKey,
                controller: emailController,
                inputType: LoginInputType.email,
              ),

              // Password
              Padding(
                padding:
                    PaddingsConstants.instance.createAccountPasswordPadding,
                child: loginInput(
                  hintText: LocaleKeys.inputPassword.tr(),
                  prefixIcon: Icons.lock,
                  suffixIcon: AnimatedIcons.menu_home,
                  color: Theme.of(context).appColors.loginInputIconsGrey,
                  controller: passwordController,
                  formKey: _formKey,
                  inputType: LoginInputType.password,
                ),
              ),

              // Confirm Password
              loginInput(
                hintText: LocaleKeys.confirmPassword.tr(),
                prefixIcon: Icons.lock,
                suffixIcon: AnimatedIcons.menu_home,
                color: Theme.of(context).appColors.loginInputIconsGrey,
                formKey: _formKey,
                controller:
                    confirmPasswordController, // Confirm password controller
                inputType: LoginInputType.confirmPassword,
              ),

              Padding(
                padding: PaddingsConstants.instance.createAccountButtonPadding,
                child: Center(child: _createAccountRichText()),
              ),

              // Create Account Button
              GlobalElevatedButton(
                text: LocaleKeys.createAccount.tr(),
                onPressed: () {
                  createAccountCheck(context);
                },
                isLoadingEmail: listenLoading(),
                child: loadingWidgetCheck(LocaleKeys.createAccount.tr()),
              ),

              Padding(
                padding: PaddingsConstants.instance.orContinuePadding,
                child: Center(
                  child: NormalText(
                    text: LocaleKeys.continueOtherLogin.tr(),
                    color: Theme.of(context).appColors.loginShadowMountain,
                    fontSize: 13,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  otherLoginButton(
                    icon: googleLoadingWidgetCheck(),
                    onPressed: () {
                      googleLoginCheck(); // Aynı fonksiyon!
                    },
                  ),
                  Padding(
                    padding: PaddingsConstants
                        .instance
                        .otherLoginButtonHorizontalPadding,
                    child: otherLoginButton(
                      icon: Icon(Icons.apple),
                      onPressed: () {
                        showSnackBar(
                          context,
                          'Şuanda apple ile login yapılamamaktadır...',
                        );
                      },
                    ),
                  ),
                  otherLoginButton(
                    icon: facebookLoadingWidgetCheck(),
                    onPressed: () => facebookLoginCheck(), // Aynı fonksiyon!
                  ),
                ],
              ),
              Padding(
                padding:
                    PaddingsConstants.instance.createAccountRichTextPadding,
                child: Center(
                  child: RichTextWidget(
                    tapGestureRecognizer: _tapGestureRecognizerLogin,
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
          color: Theme.of(context).appColors.loginShadowMountain,
        ),
        children: [
          TextSpan(
            text: LocaleKeys.register.tr() + " ",
            style: TextStyle(
              color: Theme.of(context).appColors.sizzlingRed.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
            recognizer: _tapGestureRecognizerPrivacy,
          ),
          TextSpan(
            text: LocaleKeys.buttonYouAgreeToThePublicOffer.tr(),
            style: TextStyle(
              fontSize: TextSizeEnum.loginInputHintTextSize.value,
              color: Theme.of(context).appColors.loginShadowMountain,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://policies.google.com/privacy?hl=tr');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showSnackBar(context, 'Link acilamadi');
    }
  }
}
