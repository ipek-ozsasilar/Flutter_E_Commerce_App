import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/category_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/deal_card_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/discount_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/flat_feels.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/home_indicator.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/new_arrivals.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/sort_filter_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/special_offers.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/sponsord_widget.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/trending_deal_widget.dart';
import 'package:flutter_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/utility/firebase/base_firebase.dart';
import 'package:flutter_e_commerce_app/product/widget/appbar/home_appbar.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/home_bottom_navigation.dart';
import 'package:flutter_e_commerce_app/product/widget/search/search_widget.dart';

//Haber, ürün açıklaması, kullanıcıya özel içerik gibi backend’den gelen veriler için çeviri dosyası kullanılmaz.
//Bunun yerine veri tabanında çok dilli yapı olur.

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Future<List<ProductModel?>> products;

  @override
  void initState() {
    super.initState();
    products = BaseFirebase<ProductModel>(
      firebaseCollections: FirebaseCollections.products,
    ).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.secondaryBackgroundColor,
      appBar: HomeCustomAppbar(),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: ListView(
          children: [
            Padding(
              padding: PaddingsConstants.instance.homeSearchPadding,
              child: HomeSearchWidget(),
            ),

            TextAndSortFilterWidget(title: LocaleKeys.allFeatured.tr()),

            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: HomeCategoryWidget(),
            ),
            //% 50 off
            DiscountStackWidget(),
            //indicator
            HomeIndicatorWidget(),

            //Deal of the day
            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: TrendingDealDayViewAll(
                backgroundColor: Theme.of(context).appColors.dealOfTheDayBlue,
                text: LocaleKeys.dealOfTheDay.tr(),
                icon: IconsEnum.iconTimer.icon,
                subText: LocaleKeys.timer.tr(),
              ),
            ),

            //Deal of the day card list
            FutureBuilder<List<ProductModel?>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: WidgetSizeEnum.homeCardsContainerHeight.value,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                final productList = snapshot.data?.cast<ProductModel>() ?? [];
                return DealOfTheDayCardsWidget(products: productList);
              },
            ),

            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: HomeSpecialOffersWidget(),
            ),

            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: FlatAndHeelsWidget(),
            ),

            //Trending Products
            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: TrendingDealDayViewAll(
                backgroundColor: Theme.of(
                  context,
                ).appColors.trendingProductsPink,
                text: LocaleKeys.trendingProducts.tr(),
                icon: IconsEnum.iconCalendar.icon,
                subText: LocaleKeys.trendingProductsSubText.tr(),
              ),
            ),

            FutureBuilder<List<ProductModel?>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: WidgetSizeEnum.homeCardsContainerHeight.value,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                final productList = snapshot.data?.cast<ProductModel>() ?? [];
                return DealOfTheDayCardsWidget(products: productList);
              },
            ),

            //New Arrivals
            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: NewArrivalsWidget(),
            ),

            Padding(
              padding:
                  PaddingsConstants.instance.homeSingleChildScrollViewPadding,
              child: SponsordWidget(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: homeBottomNavigationBar(),
    );
  }
}

class HomeContainerDecoration {
  static BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
