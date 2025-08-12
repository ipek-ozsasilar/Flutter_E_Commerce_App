// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart'
    hide FormState;
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
// import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/button/global_icon_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class loginInput extends ConsumerWidget {
  loginInput({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.color,
    required this.formKey,
    required this.controller,
    required this.inputType,
  });

  final String hintText;
  final IconData prefixIcon;
  final AnimatedIconData suffixIcon;
  final Color color;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final LoginInputType inputType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      obscureText: isPasswordInput()
          ? ref.watch(formProvider).isObscureText
          : false,
      onChanged: (value) {
        formKey.currentState!.validate();
      },
      //focus olunca kontrol yapılsın
      validator: validator,
      keyboardType: inputType == LoginInputType.email
          ? TextInputType.emailAddress
          : TextInputType.number,
      inputFormatters: inputFormatters(),

      maxLength: 30,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(
          context,
        ).appColors.splashUltimateGreyText.withOpacity(0.15),
        hintStyle: TextStyle(
          color: Theme.of(context).appColors.loginInputHintText,
          fontSize: TextSizeEnum.loginInputHintTextSize.value,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).appColors.loginInputHintText.withOpacity(0.2),
          ),
          borderRadius:
              BorderRadiusConstants.instance.circularSmallBorderRadius,
        ),
        prefixIcon: Icon(prefixIcon, color: color),
        suffixIcon: GlobalIconButton(
          icon: suffixIcon,
          color: color,
          inputType: inputType,
        ),
      ),
    );
  }

  bool isPasswordInput() {
    return inputType == LoginInputType.password ||
        inputType == LoginInputType.confirmPassword;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      if (inputType == LoginInputType.email) {
        return 'Lütfen geçerli bir e-mail adresi giriniz';
      } else {
        return 'Lütfen geçerli bir şifre giriniz';
      }
    }

    // Sadece şifre alanları için 6 karakter kontrolü
    if (isPasswordInput()) {
      if (value.length < 6) {
        return 'Şifre en az 6 karakter olmalı';
      }
    }

    return null;
  }

  List<TextInputFormatter> inputFormatters() {
    if (isPasswordInput()) {
      return [FilteringTextInputFormatter.digitsOnly];
    } else {
      return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]'))];
    }
  }
}

enum LoginInputType {
  email,
  password,
  confirmPassword,
  forgotPassword,
  resetPassword,
}
