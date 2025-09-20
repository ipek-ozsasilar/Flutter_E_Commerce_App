import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/button/home_icon_button.dart';
import 'package:flutter_e_commerce_app/product/widget/icon/global_icon.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchDelegateInput());
      },
      child: Container(
        height: WidgetSizeEnum.homeSearchHeight.value,
        padding: PaddingsConstants.instance.homeSearchInsidePadding,
        decoration: HomeContainerDecoration.containerDecoration(),
        child: Row(
          children: [
            Padding(
              padding: PaddingsConstants.instance.homeSortFilterPadding,
              child: GlobalIcon(icon: IconsEnum.iconSearch.icon, size: IconSizeEnum.homeSortFilterIconSize.value, color: Theme.of(context).appColors.searchHintGrey),
            ),
            Expanded(
              child: NormalText(
                text: LocaleKeys.searchAnyProduct.tr(),
                color: Theme.of(context).appColors.searchHintGrey,
                fontSize: TextSizeEnum.homeDescriptionSize.value,
              ),
            ),
            HomeIconButton(
              icon: IconsEnum.iconVoice.icon,
              color: Theme.of(context).appColors.searchHintGrey,
              size: IconSizeEnum.homeSortFilterIconSize.value,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchDelegateInput extends SearchDelegate {
  @override 
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          'Start typing to search...',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
    );
  }
}