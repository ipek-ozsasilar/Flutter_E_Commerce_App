import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: PaddingsConstants.instance.homeSingleChildScrollViewInsidePadding,
      decoration: HomeContainerDecoration.containerDecoration(),
      height: WidgetSizeEnum.categoryContainerHeight.value,
      child: ListView.separated(
        padding: PaddingsConstants.instance.homeSingleChildScrollViewInsidePadding,
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        separatorBuilder: (context, index) => SizedBox(width: 15),
        itemBuilder: (context, index) {
          return HomeSingleChildScrollViewElement(
            title: LocaleKeys.beauty.tr(),
            image: Assets.icons.splashIcon.path,
          );
        },
      ),
    );
  }
}

class HomeSingleChildScrollViewElement extends StatelessWidget {
  HomeSingleChildScrollViewElement({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: TextSizeEnum.homeAppbarTitleSize.value, backgroundImage: AssetImage(image)),
          NormalText(
            text: title,
            fontSize: TextSizeEnum.loginButtonTextSize.value,
            color: Theme.of(context).appColors.boldBlack,
          ),
        ],
      ),
    );
  }
}
