import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/colors.gen.dart';
  

class otherLoginButton extends StatelessWidget {
  const otherLoginButton({
    super.key,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: color),
      iconSize: 35,
      style: IconButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(
            color: ColorName.sizzlingRed.withOpacity(0.8),
          ),
        ),
        minimumSize: Size(55, 55),
      ),
    );
  }
}