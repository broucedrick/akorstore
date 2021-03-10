import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider_test.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


class ProductTitleView extends StatelessWidget {
  final Product productModel;
  ProductTitleView({@required this.productModel});

  @override
  Widget build(BuildContext context) {

    double _startingPrice;
    double _endingPrice;
    // if(productModel.choiceOptions.length != 0) {
    //   List<double> _priceList = [];
    //   productModel.variation.forEach((variation) => _priceList.add(double.parse(variation.price)));
    //   _priceList.sort((a, b) => a.compareTo(b));
    //   _startingPrice = _priceList[0];
    //   if(_priceList[0] < _priceList[_priceList.length-1]) {
    //     _endingPrice = _priceList[_priceList.length-1];
    //   }
    // }else {
    //   _startingPrice = double.parse(productModel.unitPrice);
    // }

    return Container(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Consumer<ProductDetailsProvider>(
        builder: (context, details, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Row(children: [

              Hero(
                tag: 'price-${productModel.id}',
                child: Text(
                  "${productModel.prixVente} CFA",
                  style: titilliumBold.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
              ),
              SizedBox(width: 20),

              // double.parse(productModel.discount) >= 1 ? Container(
              //   width: 50,
              //   height: 20,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: ColorResources.getPrimary(context)),
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   child: Hero(
              //     tag: 'off-${productModel.id}',
              //     child: Text(PriceConverter.percentageCalculation(context, productModel.unitPrice, productModel.discount, productModel.discountType),
              //       style: titilliumRegular.copyWith(color: Theme.of(context).hintColor, fontSize: 8),
              //     ),
              //   ),
              // ) : SizedBox.shrink(),
              Expanded(child: SizedBox.shrink()),

              InkWell(
                onTap: () {
                  if(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink != null) {
                    Share.share(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink);
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    boxShadow: [BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.share, color: ColorResources.getPrimary(context), size: Dimensions.ICON_SIZE_SMALL),
                ),
              ),

            ]),

            // Hero(
            //   tag: 'cutted-price-${productModel.id}',
            //   child: Text(
            //     '${PriceConverter.convertPrice(context, _startingPrice)}'
            //         '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice)}' : ''}',
            //     style: titilliumRegular.copyWith(color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough),
            //   ),
            // ),

            Hero(
              tag: 'name-${productModel.id}',
              child: Text(productModel.nom ?? '', style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE), maxLines: 2),
            ),

            Row(children: [

              // Hero(
              //   tag: 'rating-${productModel.id}',
              //   child: Text(productModel.rating != null ? productModel.rating.length > 0 ? double.parse(productModel.rating[0].average).toStringAsFixed(1) : '0.0' : '0.0', style: titilliumSemiBold.copyWith(
              //     color: Theme.of(context).hintColor,
              //     fontSize: Dimensions.FONT_SIZE_LARGE,
              //   )),
              // ),
              // SizedBox(width: 5),
              //
              // RatingBar(rating: productModel.rating != null ? productModel.rating.length > 0 ? double.parse(productModel.rating[0].average) : 0.0 : 0.0),

              Expanded(child: SizedBox.shrink()),

              // Text('${details.reviewList != null ? details.reviewList.length : 0} reviews | ', style: titilliumRegular.copyWith(
              //   color: Theme.of(context).hintColor,
              //   fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
              // )),

              Text('${details.orderCount} orders | ', style: titilliumRegular.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
              )),

              Text('${details.wishCount} wish', style: titilliumRegular.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
              )),

            ]),

          ]);
        },
      ),
    );
  }
}
