import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';

class otherLoginButton extends StatelessWidget {
  const otherLoginButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      iconSize: 35,
      style: IconButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).appColors.sizzlingRed.withOpacity(0.8),
          ),
        ),
        minimumSize: Size(55, 55),
      ),
    );
  }
}
