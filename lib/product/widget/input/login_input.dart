import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app/features/login/provider/connection_provider.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart'
    hide FormState;
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
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
  });

  final String hintText;
  final IconData prefixIcon;
  final AnimatedIconData suffixIcon;
  final Color color;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      obscureText:
          hintText == LocaleKeys.inputPassword.tr() ||
              hintText == LocaleKeys.confirmPassword.tr()
          ? ref.watch(formProvider).isObscureText
          : false,
      onChanged: (value) {
        formKey.currentState!.validate();
      },
      //focus olunca kontrol yapılsın
      validator: (value) {
        if (value == null || value.isEmpty) {
          if (hintText == LocaleKeys.inputUsernameEmail.tr() ||
              hintText == LocaleKeys.enterYourEmail.tr() ||
              hintText == LocaleKeys.createAccount.tr()) {
            return 'Lütfen geçerli bir e-mail adresi giriniz';
          } else {
            return 'Lütfen geçerli bir şifre giriniz';
          }
        }

        // Sadece şifre alanları için 6 karakter kontrolü
        if (hintText == LocaleKeys.inputPassword.tr() ||
            hintText == LocaleKeys.confirmPassword.tr()) {
          if (value.length < 6) {
            return 'Şifre en az 6 karakter olmalı';
          }
        }

        return null;
      },
      keyboardType:
          hintText == LocaleKeys.inputUsernameEmail.tr() ||
              hintText == LocaleKeys.createAccount.tr()
          ? TextInputType.emailAddress
          : TextInputType.number,
      inputFormatters: [
        if (hintText == LocaleKeys.inputPassword.tr() ||
            hintText == LocaleKeys.confirmPassword.tr())
          FilteringTextInputFormatter.digitsOnly
        else
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
      ],

      maxLength: 30,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorName.splashUltimateGreyText.withOpacity(0.15),
        hintStyle: TextStyle(
          color: ColorName.loginInputHintText,
          fontSize: TextSizeEnum.loginInputHintTextSize.value,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorName.loginInputHintText.withOpacity(0.2),
          ),
          borderRadius:
              BorderRadiusConstants.instance.circularSmallBorderRadius,
        ),
        prefixIcon: Icon(prefixIcon, color: color),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlobalIconButton(icon: suffixIcon, color: color),
        ),
      ),
    );
  }
}
