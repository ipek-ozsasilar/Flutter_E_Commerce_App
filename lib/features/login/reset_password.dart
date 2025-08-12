import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart'
    hide FormState;
import 'package:flutter_e_commerce_app/features/login/view_model/reset_password_view.model.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/login_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_elevated_button.dart';
import 'package:flutter_e_commerce_app/product/widget/input/login_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPassword extends ConsumerStatefulWidget {
  final String? oobCode;
  const ResetPassword({Key? key, this.oobCode}) : super(key: key);

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPassword>
    with ResetPasswordViewModel {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resetPasswordController = ref
        .watch(formProvider.notifier)
        .passwordController;

    final ConfirmPasswordController = ref
        .watch(formProvider.notifier)
        .confirmPasswordController;

    return Scaffold(
      appBar: CustomAppbarLogin(title: LocaleKeys.resetPassword.tr()),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: PaddingsConstants.instance.loginBodyPadding,
          child: ListView(
            shrinkWrap: true,
            children: [
              loginInput(
                hintText: LocaleKeys.inputPassword.tr(),
                prefixIcon: Icons.email_rounded,
                suffixIcon: AnimatedIcons.menu_home,
                color: Theme.of(context).appColors.loginInputIconsGrey,
                formKey: _formKey,
                controller: resetPasswordController,
                inputType: LoginInputType.password,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 35),
                child: loginInput(
                  hintText: LocaleKeys.confirmPassword.tr(),
                  prefixIcon: Icons.email_rounded,
                  suffixIcon: AnimatedIcons.menu_home,
                  color: Theme.of(context).appColors.loginInputIconsGrey,
                  formKey: _formKey,
                  controller: ConfirmPasswordController,
                  inputType: LoginInputType.confirmPassword,
                ),
              ),

              GlobalElevatedButton(
                text: LocaleKeys.submit.tr(),
                onPressed: () async {
                  resetPasswordCheck();
                },
                isLoadingEmail: listenLoading(),
                child: loadingWidgetCheck(LocaleKeys.submit.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
