import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/deal_card_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/star_text_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/home_bottom_navigation.dart';
import 'package:flutter_e_commerce_app/product/widget/cards/product_card.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/home_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/search/search_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/sort_filter_widget.dart';

class TrendingProductView extends StatelessWidget {
  const TrendingProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.secondaryBackgroundColor,
      appBar: HomeCustomAppbar(),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: Column(
          children: [
     
            Padding(
              padding: PaddingsConstants.instance.homeSearchPadding,
              child: HomeSearchWidget(),
            ),

            
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextAndSortFilterWidget(title: "52,082+ Items"),
            ),

            
            Expanded(
              child: _TrendingMasonryGridViewWidget(),
            ),
          ],
        ),
      ),

      bottomNavigationBar: homeBottomNavigationBar(),
    );
  }
}




class _TrendingMasonryGridViewWidget extends StatelessWidget {
  const _TrendingMasonryGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: 20,
      itemBuilder: (context, index) {
        int rowIndex = index ~/ 2;
        bool isLeft = index % 2 == 0;
    
        // İlk satır sol kısa başlasın
        bool isLong = (rowIndex % 2 == 0) ? !isLeft : isLeft;
    
        return Container(
          height: isLong ? WidgetSizeEnum.homeTrendingProductLongCardHeight.value : WidgetSizeEnum.homeTrendingProductShortCardHeight.value,
          decoration: TrendingCardsDecoration(context),
          child: DealOfTheDayCards(oldPrice: false),
        );
      },
    );
  }

  BoxDecoration TrendingCardsDecoration(BuildContext context) {
    return BoxDecoration(
          color: Theme.of(
            context,
          ).appColors.whiteColor, // arka plan rengi
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).appColors.boldBlack.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        );
  }
}
