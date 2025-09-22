import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/mixins/image_picker.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'dart:io';


class ProfileCenterCircleAvatarWidget extends StatefulWidget {
  @override
  State<ProfileCenterCircleAvatarWidget> createState() => _ProfileCenterCircleAvatarWidgetState();
}

class _ProfileCenterCircleAvatarWidgetState extends State<ProfileCenterCircleAvatarWidget> with ImagePickerMixin {


  @override
  Widget build(BuildContext context) {
    return  Center(
                    child: Stack(
                      clipBehavior: Clip.none, // 🔥 dışarı taşanı kesme
                      children: [
                        CircleAvatar(
                          radius: WidgetSizeEnum.profileCircleAvatarRadius.value,
                          backgroundImage: imageFile != null
                              ? FileImage(imageFile!)
                              : AssetImage(Assets.images.shopPage.path)
                                    as ImageProvider,
                        ),
                        Positioned(
                          right: WidgetSizeEnum.profileEditButtonRight.value,
                          bottom: WidgetSizeEnum.profileEditButtonBottom.value,
                          child: InkWell(
                            onTap: () {
                              pickImage();
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: WidgetSizeEnum.profileEditButtonWidthAndHeight.value,
                              height: WidgetSizeEnum.profileEditButtonWidthAndHeight.value,
                              decoration: BoxDecoration(
                                color: Theme.of(context).appColors.materialBlue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                IconsEnum.iconEdit.icon,
                                color: Theme.of(context).appColors.whiteColor,
                                size: IconSizeEnum.homeSortFilterIconSize.value,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }
}