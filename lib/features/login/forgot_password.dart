import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/login_welcome_back.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart' hide FormState;
import 'package:flutter_e_commerce_app/features/login/view_model/forgot_password_view_model.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> with ForgotPasswordViewModel {
  late TapGestureRecognizer _tapGestureRecognizer;
  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () =>
          NavigatorManager.instance.navigatePage(context, ForgotPassword());
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordController = ref
        .watch(formProvider.notifier)
        .forgotPasswordController;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar:
          CustomAppbarLogin(title: LocaleKeys.forgotPassword.tr())
              as PreferredSizeWidget,
      body: Padding(
        padding: PaddingsConstants.instance.loginBodyPadding,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              loginInput(
                hintText: LocaleKeys.enterYourEmail.tr(),
                prefixIcon: Icons.email_rounded,
                suffixIcon: AnimatedIcons.close_menu,
                color: ColorName.loginInputIconsGrey,
                formKey: _formKey,
                controller: forgotPasswordController,
              ),

              Padding(
                padding: PaddingsConstants.instance.forgotPasswordDetailPadding,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichTextWidget(
                    tapGestureRecognizer: _tapGestureRecognizer,
                    text: "*",
                    secondText: LocaleKeys.forgotPasswordDetail.tr(),
                  ),
                ),
              ),

              GlobalElevatedButton(
                text: LocaleKeys.submit.tr(), onPressed: () async {
                forgotPasswordCheck();
              }, isLoading: listenLoading(), 
              child: loadingWidgetCheck(LocaleKeys.submit.tr())
              ),
            ],
          ),
        ),
      ),
    );
  }
}
