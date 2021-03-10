import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/helper/product_type.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_shimmer.dart';
import 'package:sixvalley_ui_kit/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView({@required this.productType, this.scrollController, this.sellerId});

  @override
  Widget build(BuildContext context) {
    if(productType == ProductType.LATEST_PRODUCT) {
      Provider.of<ProductProvider>(context, listen: false).initLatestProductList();
    }else if(productType == ProductType.SELLER_PRODUCT) {
      Provider.of<ProductProvider>(context, listen: false).clearSellerData();
      Provider.of<ProductProvider>(context, listen: false).initSellerProductList();
    }

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        if(productType == ProductType.LATEST_PRODUCT) {
          productList = prodProvider.latestProductList;
        }else if(productType == ProductType.SELLER_PRODUCT) {
          productList = prodProvider.sellerProductList;
        }

        return Column(children: [

          !prodProvider.firstLoading ? productList.length != 0 ? StaggeredGridView.countBuilder(
            itemCount: productList.length,
            crossAxisCount: 2,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(productModel: productList[index]);
            },
          ) : SizedBox.shrink() : ProductShimmer(isEnabled: prodProvider.firstLoading),

        ]);
      },
    );
  }
}

