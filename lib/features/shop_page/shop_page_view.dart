import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/sub_widgets/sort_filter_widget.dart';
import 'package:flutter_e_commerce_app/gen/assets.gen.dart';
import 'package:flutter_e_commerce_app/product/constants/paddings_constants.dart';
import 'package:flutter_e_commerce_app/product/enums/icons_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/sizes_enum.dart';
import 'package:flutter_e_commerce_app/product/theme/app_colors_context.dart';
import 'package:flutter_e_commerce_app/product/widget/bottom_appbar/home_bottom_navigation.dart';
import 'package:flutter_e_commerce_app/product/widget/text/text_widget.dart';

class ShopPageView extends StatefulWidget {
  const ShopPageView({super.key});

  @override
  State<ShopPageView> createState() => _ShopPageViewState();
}

class _ShopPageViewState extends State<ShopPageView> {
  int selectedSizeIndex = 0;
  int currentImageIndex = 0;
  final PageController _pageController = PageController();

  final List<String> sizes = ["6 UK", "7 UK", "8 UK", "9 UK", "10 UK"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.secondaryBackgroundColor,
      appBar: ShopPageAppBar(),
      body: Padding(
        padding: PaddingsConstants.instance.homePagePadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Carousel
              Padding(
                padding: PaddingsConstants.instance.homeSingleChildScrollViewPadding,
                child: ProductImageCarousel(
                  pageController: _pageController,
                  currentIndex: currentImageIndex,
                  onPageChanged: (index) {
                    setState(() {
                      currentImageIndex = index;
                    });
                  },
                ),
              ),
        
              // Product Details Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      
                  // Size Selection
                  SizeSelectionSection(
                    sizes: sizes,
                    selectedIndex: selectedSizeIndex,
                    onSizeSelected: (index) {
                      setState(() {
                        selectedSizeIndex = index;
                      });
                    },
                  ),
                      
               
                      
                  // Product Info
                  Padding(
                    padding: PaddingsConstants.instance.homeSingleChildScrollViewPadding,
                    child: ProductInfoSection(),
                  ),
                      
   
                      
                  // Action Buttons gottocartand buy now
                  ActionButtonsSection(),
                      
            
                      
                  // Delivery Info
                  Padding(
                    padding: PaddingsConstants.instance.homeSingleChildScrollViewPadding,
                    child: DeliveryInfoSection(),
                  ),
                      
                  // View Similar and Add to Compare buttons
                  ShopPageViewSimilarButtonWidget(),

                  Padding(
                    padding: PaddingsConstants.instance.homeSingleChildScrollViewPadding,
                    child: ShopPageSimilarAndSortFilterWidget(),
                  ),
        
                      
                  // Similar Products
                  SimilarProductsSection(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: homeBottomNavigationBar(),
    );
  }
}

class ShopPageSimilarAndSortFilterWidget extends StatelessWidget {
  const ShopPageSimilarAndSortFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BoldOnboardingText(
                  title: "Similar To",
                  titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
                  titleColor: Theme.of(context).appColors.boldBlack,
                ),
                BoldOnboardingText(
    title: "282+ Items",
    titleColor: Theme.of(context).appColors.boldBlack,
    titleSize: TextSizeEnum.homeCardsDetailSize.value,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    SortFilterWidget(text: "Sort", icon1: IconsEnum.iconDownward.icon),
                    SizedBox(width: 10),
                    SortFilterWidget(text: "Filter", icon1: IconsEnum.iconFilter.icon)
                  ],
                ),
              ],
            );
  }
}

// Custom AppBar for Shop Page
class ShopPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appColors.whiteColor,
      elevation: 0,
      leading: Padding(
        padding: PaddingsConstants.instance.homeAppbarLeadingPadding,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).appColors.boldBlack,
            size: IconSizeEnum.homeSortFilterIconSize.value,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Padding(
          padding: PaddingsConstants.instance.homeAppbarActionsPadding,
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).appColors.boldBlack,
              size: IconSizeEnum.homeSortFilterIconSize.value,
            ),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Product Image Carousel Widget
class ProductImageCarousel extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final Function(int) onPageChanged;

  const ProductImageCarousel({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Assets.images.shopPage.image(
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Page Indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Theme.of(context).appColors.sizzlingRed
                        : Theme.of(
                            context,
                          ).appColors.starNumberGreyColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),

          // Navigation Arrows
          Positioned(
            right: 30,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (currentIndex < 4) {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).appColors.whiteColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).appColors.boldBlack,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Size Selection Section Widget
class SizeSelectionSection extends StatelessWidget {
  final List<String> sizes;
  final int selectedIndex;
  final Function(int) onSizeSelected;

  const SizeSelectionSection({
    super.key,
    required this.sizes,
    required this.selectedIndex,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldOnboardingText(
          title: "Size: 7UK",
          titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),

        SizedBox(height: 12),

        Row(
          children: sizes.asMap().entries.map((entry) {
            int index = entry.key;
            String size = entry.value;
            bool isSelected = selectedIndex == index;

            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => onSizeSelected(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(
                            context,
                          ).appColors.sizzlingRed.withOpacity(0.1)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).appColors.sizzlingRed
                          : Theme.of(
                              context,
                            ).appColors.starNumberGreyColor.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: NormalText(
                    text: size,
                    color: isSelected
                        ? Theme.of(context).appColors.sizzlingRed
                        : Theme.of(context).appColors.boldBlack,
                    fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Product Info Section Widget
class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Name
        BoldOnboardingText(
          title: "Nike Sneakers",
          titleSize: TextSizeEnum.homeTrendingDealTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),

        SizedBox(height: 8),

        // Product Subtitle
        NormalText(
          text: "Vision Alta Men's Shoes Size (All Colours)",
          color: Theme.of(context).appColors.boldBlack,
          fontSize: TextSizeEnum.homeCardsTitleSize.value,
        ),

        SizedBox(height: 12),

        // Rating and Reviews
        Row(
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < 4 ? Icons.star : Icons.star_border,
                  color: Theme.of(context).appColors.starYellowColor,
                  size: IconSizeEnum.homeStarIconSize.value,
                );
              }),
            ),
            SizedBox(width: 8),
            NormalText(
              text: "56,890",
              color: Theme.of(context).appColors.starNumberGreyColor,
              fontSize: TextSizeEnum.homeCardsDetailSize.value,
            ),
          ],
        ),

        SizedBox(height: 16),

        // Price Section
        Row(
          children: [
            NormalText(
              text: "₹2,999",
              color: Theme.of(context).appColors.oldPriceGreyColor,
              fontSize: TextSizeEnum.homeCardsTitleSize.value,
              textLine: true,
            ),
            SizedBox(width: 8),
            BoldOnboardingText(
              title: "₹1,500",
              titleSize: TextSizeEnum.homeTrendingDealTitleSize.value,
              titleColor: Theme.of(context).appColors.boldBlack,
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: NormalText(
                text: "50% Off",
                color: Theme.of(context).appColors.offRedColor,
                fontSize: TextSizeEnum.homeCardsDetailSize.value,
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Product Details
        BoldOnboardingText(
          title: "Product Details",
          titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
          titleColor: Theme.of(context).appColors.boldBlack,
        ),

        SizedBox(height: 8),

        NormalText(
          text:
              "Perhaps the most iconic sneaker of all-time, this original \"Chicago\" ? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the ...More",
          color: Theme.of(context).appColors.boldBlack,
          fontSize: TextSizeEnum.homeCardsDetailSize.value,
        ),
      ],
    );
  }
}

// Action Buttons Section Widget
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Go to cart button
        Expanded(
          child: Container(
            height: WidgetSizeEnum.loginButtonHeight.value,
            child: OutlinedButton.icon(
              onPressed: () {
                // Navigate to cart
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).appColors.shopPageBlue,
                size: 20,
              ),
              label: NormalText(
                text: "Go to cart",
                color: Theme.of(context).appColors.shopPageBlue,
                fontSize: TextSizeEnum.loginButtonTextSize.value,
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).appColors.shopPageBlue,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 12),

        // Buy Now button
        Expanded(
          child: Container(
            height: WidgetSizeEnum.loginButtonHeight.value,
            child: ElevatedButton.icon(
              onPressed: () {
                // Buy now functionality
              },
              icon: Icon(
                Icons.flash_on,
                color: Theme.of(context).appColors.whiteColor,
                size: 20,
              ),
              label: NormalText(
                text: "Buy Now",
                color: Theme.of(context).appColors.whiteColor,
                fontSize: TextSizeEnum.loginButtonTextSize.value,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).appColors.shopPageBuyGreen,
                foregroundColor: Theme.of(context).appColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Delivery Info Section Widget
class DeliveryInfoSection extends StatelessWidget {
  const DeliveryInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:  75,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.shopPagePink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldOnboardingText(
            title: "Delivery in",
            titleSize: TextSizeEnum.homeCardsTitleSize.value,
            titleColor: Theme.of(context).appColors.boldBlack,
          ),
          BoldOnboardingText(
            title: "1 within Hour",
            titleSize: TextSizeEnum.homeSpecialOffersTitleSize.value,
            titleColor: Theme.of(context).appColors.boldBlack,
          ),
        ],
      ),
    );
  }
}

// Similar Products Section Widget
class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      

        // Similar Products Grid
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return SimilarProductCard(index: index);
          },
        ),
      ],
    );
  }
}

class ShopPageViewSimilarButtonWidget extends StatelessWidget {
  const ShopPageViewSimilarButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.visibility_outlined,
              color: Theme.of(context).appColors.boldBlack,
              size: 16,
            ),
            label: NormalText(
              text: "View Similar",
              color: Theme.of(context).appColors.boldBlack,
              fontSize: TextSizeEnum.homeCardsDetailSize.value,
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(
                  context,
                ).appColors.starNumberGreyColor.withOpacity(0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.compare_arrows,
              color: Theme.of(context).appColors.boldBlack,
              size: 16,
            ),
            label: NormalText(
              text: "Add to Compare",
              color: Theme.of(context).appColors.boldBlack,
              fontSize: TextSizeEnum.homeCardsDetailSize.value,
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(
                  context,
                ).appColors.starNumberGreyColor.withOpacity(0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Similar Product Card Widget
class SimilarProductCard extends StatelessWidget {
  final int index;

  const SimilarProductCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).appColors.boldBlack.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Assets.images.shopPage.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Product Info
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldOnboardingText(
                    title: "Nike Sneakers",
                    titleSize: TextSizeEnum.homeCardsTitleSize.value,
                    titleColor: Theme.of(context).appColors.boldBlack,
                  ),

                  SizedBox(height: 4),

                  NormalText(
                    text: index % 2 == 0
                        ? "Nike Air Jordan Retro 1 Low Mystic Black"
                        : "Mid Peach Mocha Shoes For Men White Black Pink",
                    color: Theme.of(context).appColors.starNumberGreyColor,
                    fontSize: TextSizeEnum.homeCardsDetailSize.value,
                  ),

                  SizedBox(height: 8),

                  BoldOnboardingText(
                    title: index % 2 == 0 ? "₹1,900" : "₹1,900",
                    titleSize: TextSizeEnum.homeCardsTitleSize.value,
                    titleColor: Theme.of(context).appColors.boldBlack,
                  ),

                  Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < 4 ? Icons.star : Icons.star_border,
                        color: Theme.of(context).appColors.starYellowColor,
                        size: 12,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Widget
class ShopBottomNavigation extends StatelessWidget {
  const ShopBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).appColors.boldBlack.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home, "Home", false),
          _buildNavItem(context, Icons.favorite_border, "Wishlist", false),
          _buildNavItem(context, Icons.shopping_cart, "", true),
          _buildNavItem(context, Icons.search, "Search", false),
          _buildNavItem(context, Icons.settings, "Setting", false),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isSelected,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(isSelected ? 12 : 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).appColors.sizzlingRed
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected
                ? Theme.of(context).appColors.whiteColor
                : Theme.of(context).appColors.boldBlack,
            size: isSelected ? 24 : 20,
          ),
        ),
        if (label.isNotEmpty) ...[
          SizedBox(height: 4),
          NormalText(
            text: label,
            color: Theme.of(context).appColors.boldBlack,
            fontSize: 10,
          ),
        ],
      ],
    );
  }
}
