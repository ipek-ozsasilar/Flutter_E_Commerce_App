import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

//Onboarding Text Button for onboarding page's text button
class GlobalTextButton extends StatelessWidget {
  const GlobalTextButton({
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
      child: NormalText(text: text, color: color,fontSize: 13),
    );
  }
}
