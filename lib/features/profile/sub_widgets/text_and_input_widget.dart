import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';


class ProfileTextAndInputWidget extends StatelessWidget {
  const ProfileTextAndInputWidget({
    super.key,
    required this.title,
    required this.hintText,
  });

  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: PaddingsConstants.instance.profileTextAndInputPadding,
          child: NormalText(
            text: title,
            color: Theme.of(context).appColors.boldBlack,
            fontSize: TextSizeEnum.homeDescriptionSize.value,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).appColors.oldPriceGreyColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Theme.of(context).appColors.whiteColor.withOpacity(0.15),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).appColors.boldBlack,
              fontSize: TextSizeEnum.homeDescriptionSize.value,
            ),
          ),
        ),
      ],
    );
  }
}