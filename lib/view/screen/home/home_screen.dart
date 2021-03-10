import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/helper/product_type.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/provider/mega_deal_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/brand/all_brand_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/category/all_category_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/banners_view.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/brand_view.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/category_view.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/flash_deals_view.dart';
import 'package:sixvalley_ui_kit/view/screen/home/widget/products_view.dart';
import 'package:sixvalley_ui_kit/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Provider.of<MegaDealProvider>(context, listen: false).initMegaDealList();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomPadding: false,

      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [

            // App Bar
            SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).accentColor,
              title: Image.asset(Images.logo_with_name_image, height: 35, color: ColorResources.getPrimary(context)),
              actions: [IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
                icon: Stack(overflow: Overflow.visible, children: [
                  Image.asset(
                    Images.cart_arrow_down_image,
                    height: Dimensions.ICON_SIZE_DEFAULT,
                    width: Dimensions.ICON_SIZE_DEFAULT,
                    color: ColorResources.getPrimary(context),
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: ColorResources.RED,
                      child: Text(Provider.of<CartProvider>(context).cartList.length.toString(), style: titilliumSemiBold.copyWith(
                        color: ColorResources.WHITE,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      )),
                    ),
                  ),
                ]),
              )],
            ),

            // Search Button
            SliverPersistentHeader(pinned: true, delegate: SliverDelegate(child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 2),
                color: ColorResources.getHomeBg(context),
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: ColorResources.getGrey(context),
                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                  ),
                  child: Row(children: [
                    Icon(Icons.search, color: ColorResources.getPrimary(context), size: Dimensions.ICON_SIZE_LARGE),
                    SizedBox(width: 5),
                    Text(getTranslated('SEARCH_HINT', context), style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
                  ]),
                ),
              ),
            ))),

            SliverToBoxAdapter(child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: BannersView(),
                ),

                // Category
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 20, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                  child: TitleRow(title: getTranslated('CATEGORY', context), onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AllCategoryScreen()));
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: CategoryView(isHomePage: true),
                ),

                // Mega Deal
                Consumer<MegaDealProvider>(
                  builder: (context, flashDeal, child) {
                    return flashDeal.megaDealList.length > 0 ? Padding(
                      padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 20, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(title: getTranslated('flash_deal', context), eventDuration: flashDeal.megaDealList.length > 0 ? flashDeal.duration : null, onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => FlashDealScreen()));
                      }),
                    ) : flashDeal.megaDealList[0].id != null ? Padding(
                      padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 20, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(title: getTranslated('flash_deal', context), eventDuration: flashDeal.megaDealList.length > 0 ? flashDeal.duration : null, onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => FlashDealScreen()));
                      }),
                    ) : SizedBox.shrink();
                  },
                ),
                Consumer<MegaDealProvider>(
                  builder: (context, megaDeal, child) {
                    return megaDeal.megaDealList.length > 0 ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: Container(height: 150, child: FlashDealsView()),
                    ) : megaDeal.megaDealList[0].id != null ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: Container(height: 150, child: FlashDealsView()),
                    ) : SizedBox.shrink();
                  },
                ),

                // Brand
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 20, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                  child: TitleRow(title: getTranslated('brand', context), onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AllBrandScreen()));
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: BrandView(isHomePage: true),
                ),

                // Latest Products
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 20, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                  child: TitleRow(title: getTranslated('latest_products', context)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: ProductView(productType: ProductType.LATEST_PRODUCT, scrollController: _scrollController),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {

  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }

}
