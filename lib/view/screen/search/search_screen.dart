import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
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
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String hote = "https://app.akorstore.com/api/";

  List<Product> allProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).initLatestProductList();
  }

  void getProducts(String query) {
    debugPrint("Fetching ...");
    List products;
    allProducts.clear();
    Provider.of<ProductProvider>(context, listen: false).latestProductList.forEach((element) {
      if(element.nom.toLowerCase().contains(query.toLowerCase())){
        setState(() {
          allProducts.add(element);
        });
      }
    });
    // var response = await http.get("${hote}produits");
    // int statusCode = response.statusCode;
    // if(statusCode == 200){
    //   products = json.decode(response.body)['hydra:member'];
    //   //debugPrint(products.toString());
    //   products.forEach((element) {
    //     //debugPrint(element['id'].toString());
    //
    //     if (element['nom'].toString().contains(query)) {
    //       setState(() {
    //         allProducts.add(Product(element['id'], element['stockId'], element['photo'], element['nom'], element['description'], element['stock'], element['quantite'], element['prixVente'], element['categorieId'], element['createdAt'], element['updatedAt'], element['consumerId']));
    //       });
    //     }
    //     //debugPrint(allProducts.toString());
    //   });

      debugPrint(allProducts.toString());

    //debugPrint(allProducts.length.toString());
    //return allProducts;

  }

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
              //Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
              //Provider.of<SearchProvider>(context, listen: false).searchProduct(text);
              //Provider.of<SearchProvider>(context, listen: false).saveSearchAddress(text);
              getProducts(text);
            },
            onClearPressed: () {
              Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
            },
          ),

          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              debugPrint("LENGTH : "+allProducts.length.toString());
              return allProducts != null ? allProducts.length > 0
                  ? Expanded(child: SearchProductWidget(products: allProducts, isViewScrollable: true))
                  : Expanded(child: NoInternetOrDataScreen(isNoInternet: false))
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
