import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BottomCartView extends StatelessWidget {
  final Product product;
  BottomCartView({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 15, spreadRadius: 1)],
      ),
      child: Row(children: [
        Expanded(flex: 3, child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Stack(children: [
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>CartScreen()
                  ));
                },
                child: Image.asset(Images.cart_image, color: ColorResources.getPrimary(context))),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 17,
                width: 17,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.getPrimary(context),
                ),
                child: Text(
                  Provider.of<CartProvider>(context).cartList.length.toString(),
                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color:Theme.of(context).accentColor),
                ),
              ),
            )
          ]),
        )),
        Expanded(flex: 6, child: InkWell(
          onTap: () {
            showModalBottomSheet(context: context, isScrollControlled: true, builder: (con) => CartBottomSheet(product: product, isBuy: true));
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.only(left: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: ColorResources.getPrimary(context)),
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).accentColor,
            ),
            child: Text(
              'Acheter maintenant',
              textAlign: TextAlign.center,
              style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getPrimary(context)),
            ),
          ),
        )),
        Expanded(flex: 11, child: InkWell(
          onTap: () {
            if(!Provider.of<CartProvider>(context, listen: false).isAddedInCart(product.id)) {
              showModalBottomSheet(context: context, isScrollControlled: true, builder: (con) => CartBottomSheet(product: product, isBuy: false, callback: (){
                showCustomSnackBar('${product.nom} a été ajouté au panier', context, isError: false);
              }));
            }else {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('${product.nom} déjà ajouté'), backgroundColor: ColorResources.getRed(context)));
            }
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.getPrimary(context),
            ),
            child: Text(
              Provider.of<CartProvider>(context).isAddedInCart(product.id) ? 'Déjà ajouté' : 'Ajouter au panier',
              style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).accentColor),
            ),
          ),
        )),
      ]),
    );
  }
}
