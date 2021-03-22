import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/search_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_shimmer.dart';
import 'package:sixvalley_ui_kit/view/basewidget/search_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/search/widget/search_product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [

          // for tool bar
          SearchWidget(
            hintText: getTranslated('SEARCH_HINT', context),
            onSubmit: (String text) {
              Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
              Provider.of<SearchProvider>(context, listen: false).searchProduct(text);
              Provider.of<SearchProvider>(context, listen: false).saveSearchAddress(text);
            },
            onClearPressed: () {
              Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
            },
          ),

          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              return !searchProvider.isClear ? searchProvider.searchProductList != null ? searchProvider.searchProductList.length > 0
                  ? Expanded(child: SearchProductWidget(products: searchProvider.searchProductList, isViewScrollable: true))
                  : Expanded(child: NoInternetOrDataScreen(isNoInternet: false))
                  : Expanded(child: ProductShimmer(isEnabled: Provider.of<SearchProvider>(context).searchProductList == null))
                  : Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Consumer<SearchProvider>(
                        builder: (context, searchProvider, child) => StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: searchProvider.historyList.length,
                          itemBuilder: (context, index) => Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Provider.of<SearchProvider>(context, listen: false).searchProduct(searchProvider.historyList[index]);
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorResources.getGrey(context)),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      Provider.of<SearchProvider>(context, listen: false).historyList[index] ?? "",
                                      style: titilliumItalic.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ),
                                ),
                              )),
                          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                      ),
                      Positioned(
                        top: -5,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Historique', style: robotoBold),
                            InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Provider.of<SearchProvider>(context, listen: false).clearSearchAddress();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Supprimer',
                                      style: titilliumRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLUMBIA_BLUE),
                                    )))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
