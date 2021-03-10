import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product productModel;
  ProductWidget({@required this.productModel});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(product: productModel),
        ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Hero(
              tag: 'image-${productModel.id}',
              child: Container(
                height: 150,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(
                  color: ColorResources.getIconBg(context),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                child: Image.network(productModel.photo),
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Hero(
                    tag: 'name-${productModel.id}',
                    child: Text(productModel.nom ?? '', style: robotoRegular, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  Row(children: [
                    Hero(
                      tag: 'price-${productModel.id}',
                      child: Text(
                        productModel.prixVente,
                        style: robotoBold.copyWith(color: ColorResources.getPrimary(context)),
                      ),
                    ),
                    // Expanded(child: SizedBox.shrink()),
                    // Hero(
                    //   tag: 'rating-${productModel.id}',
                    //   child: Text(productModel.rating != null ? productModel.rating.length != 0 ? double.parse(productModel.rating[0].average).toStringAsFixed(1) : '0.0' : '0.0',
                    //       style: robotoRegular.copyWith(
                    //         color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.orange,
                    //         fontSize: Dimensions.FONT_SIZE_SMALL,
                    //       )),
                    // ),
                    // Icon(Icons.star, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.orange, size: 15),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  // double.parse(productModel.discount) > 0 ? Text(
                  //   PriceConverter.convertPrice(context, double.parse(productModel.unitPrice)),
                  //   style: robotoBold.copyWith(
                  //     color: Theme.of(context).hintColor,
                  //     decoration: TextDecoration.lineThrough,
                  //     fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  //   ),
                  // ) : SizedBox.shrink(),

                ],
              ),
            ),
          ]),

          // Off
          // double.parse(productModel.discount) >= 1 ? Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Container(
          //     height: 20,
          //     padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          //     decoration: BoxDecoration(
          //       color: ColorResources.getPrimary(context),
          //       borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
          //     ),
          //     child: Center(
          //       child: Hero(
          //         tag: 'off-${productModel.id}',
          //         child: Text(
          //           PriceConverter.percentageCalculation(context, productModel.unitPrice, productModel.discount, productModel.discountType),
          //           style: robotoRegular.copyWith(color: Theme.of(context).accentColor, fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
          //         ),
          //       ),
          //     ),
          //   ),
          // ) : SizedBox.shrink(),
        ]),
      ),
    );
  }
}
