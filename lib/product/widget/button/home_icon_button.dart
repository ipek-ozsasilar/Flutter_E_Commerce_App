

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';


class HomeIconButton extends StatelessWidget {
  const HomeIconButton({
    super.key,
    required this.icon,
    this.haveBackground = false,
    required this.color,
    required this.size,
  });
  final IconData icon;
  final bool haveBackground;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      iconSize: IconSizeEnum.homeIconSize.value,
      style: IconButton.styleFrom(
        backgroundColor: haveBackground
            ? Theme.of(context).appColors.drawerBackground
            : Colors.transparent,
      ),
      icon: GlobalIcon(icon: icon, size: size, color: color),
    );
  }
}