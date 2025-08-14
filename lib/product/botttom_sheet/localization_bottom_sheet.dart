import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_e_commerce_app/product/constants/border_radius.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:kartal/kartal.dart';

class LocalizationBottomSheet {
  static void showBottomSheetLocalization(BuildContext context) {
     showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusConstants.instance.bottomSheetBorderRadius,
      ),
      builder: (context) {
        return Padding(
          padding: PaddingsConstants.instance.bottomSheetPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                NormalText(text: 'Select Language'.tr(), color: context.general.appTheme.textTheme.bodyMedium?.color, fontSize: 18),
                
              Padding(
                padding: PaddingsConstants.instance.bottomSheetListTilePadding,
                child: _buildListTile(context, 'Türkçe', const Locale('tr')),
              ),
              _buildListTile(context, 'English', const Locale('en')),

            ],
          ),
        );
      },
    );

  }

  static Widget _buildListTile(BuildContext context, String language, Locale locale) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(language),
      onTap: () async {
        await SecureStorageKeys.setLocale(locale);
        context.setLocale(locale);
        NavigatorManager.instance.closePagePop(context);
      },
    );
  }
}