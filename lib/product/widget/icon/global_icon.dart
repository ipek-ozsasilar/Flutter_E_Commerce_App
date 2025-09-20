import 'package:flutter/material.dart';
  

class GlobalIcon extends StatelessWidget {
  const GlobalIcon({super.key, required this.icon, required this.size, required this.color});
  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}