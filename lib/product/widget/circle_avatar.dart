import 'package:flutter/material.dart';

import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CircleAvatar(
        radius: WidgetSizeEnum.circleAvatarRadius.value,
        backgroundImage: AssetImage(Assets.icons.splashIcon.path),
      ),
    );
  }
}