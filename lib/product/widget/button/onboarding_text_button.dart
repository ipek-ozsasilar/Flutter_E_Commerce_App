import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/onboarding/onboarding_view.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';

class OnboardingTextButton extends StatelessWidget {
  const OnboardingTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
         style: TextStyle(
          color: color,
          )
         ),
    );
  }
}
