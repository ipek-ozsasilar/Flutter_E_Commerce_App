import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:kartal/kartal.dart';

//Bold Onboarding Text for onboarding page's bold text
class BoldOnboardingText extends StatelessWidget {
  const BoldOnboardingText({
    super.key,
    required this.title,
    required this.titleSize,
    required this.titleColor,
  });

  final String title;
  final double? titleSize;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.general.appTheme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: titleSize,
        color: titleColor,
      ),
    );
  }
}

class BoldOnboardingTextDetail extends StatelessWidget {
  const BoldOnboardingTextDetail({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: context.general.appTheme.textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).appColors.splashUltimateGreyText,
      ),
    );
  }
}

class NormalText extends StatelessWidget {
  const NormalText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
