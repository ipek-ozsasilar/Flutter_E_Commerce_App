import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class GlobalIconButton extends StatelessWidget {
  const GlobalIconButton({
    super.key,
    required this.hintText,
    required this.icon,
    required this.color,
  });

  final String hintText;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:hintText==LocaleKeys.inputUsernameEmail.tr()? () {}: null,
      icon: Icon(icon, color: color),
    );
  }
}
