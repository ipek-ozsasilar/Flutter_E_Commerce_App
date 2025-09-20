import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';

class HomeIndicatorWidget extends StatelessWidget {
  const HomeIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleIndicatorContainer(),
        Padding(
          padding: PaddingsConstants.instance.homeIndicatorInsidePadding,
          child: SingleIndicatorContainer(),
        ),
        SingleIndicatorContainer(),
      ],
    );
  }
}

class SingleIndicatorContainer extends StatelessWidget {
  const SingleIndicatorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WidgetSizeEnum.homeIndicatorSize.value,
      height: WidgetSizeEnum.homeIndicatorSize.value,
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.homePageDiscountIndicatorGrey,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}