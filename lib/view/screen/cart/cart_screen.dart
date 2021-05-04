import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/cart_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/guest_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/no_internet_screen.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/widget/cart_widget.dart';
import 'package:sixvalley_ui_kit/view/screen/checkout/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final bool fromCheckout;
  final List<CartModel> checkoutCartList;
  CartScreen({this.fromCheckout = false, this.checkoutCartList});

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    List<CartModel> cartList = [];
    if(fromCheckout) {
      cartList.addAll(checkoutCartList);
    }else {
      cartList.addAll(Provider.of<CartProvider>(context).cartList);
    }

    List<String> sellerList = [];
    List<List<CartModel>> cartProductList = [];
    List<List<int>> cartProductIndexList = [];
    cartList.forEach((cart) {
      if(!sellerList.contains(cart.seller)) {
        sellerList.add(cart.seller);
      }
    });
    sellerList.forEach((seller) {
      List<CartModel> cartLists = [];
      List<int> indexList = [];
      cartList.forEach((cart) {
        if(seller == cart.seller) {
          cartLists.add(cart);
          indexList.add(cartList.indexOf(cart));
        }
      });
      cartProductList.add(cartLists);
      cartProductIndexList.add(indexList);
    });
    return Scaffold(

      bottomNavigationBar: !fromCheckout ? Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: ColorResources.getPrimary(context),
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () => Provider.of<CartProvider>(context, listen: false).toggleAllSelect(),
            child: Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Theme.of(context).accentColor, width: 1)),
              child: Provider.of<CartProvider>(context).isAllSelect
                  ? Icon(Icons.done, color: Theme.of(context).accentColor, size: Dimensions.ICON_SIZE_EXTRA_SMALL)
                  : SizedBox.shrink(),
            ),
          ),
          Text('Tout', style: titilliumRegular.copyWith(color: Theme.of(context).accentColor)),
          Expanded(child: Center(child: Text(
            "${Provider.of<CartProvider>(context).amount} FCFA",
            style: titilliumSemiBold.copyWith(color: Theme.of(context).accentColor),
          ))),
          Builder(
            builder: (context) => RaisedButton(
              onPressed: () {
                if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                  List<CartModel> cartList = [];
                  for (int i = 0; i < Provider.of<CartProvider>(context, listen: false).isSelectedList.length; i++) {
                    if (Provider.of<CartProvider>(context, listen: false).isSelectedList[i]) {cartList.add(
                        Provider.of<CartProvider>(context, listen: false).cartList[i]);
                    }
                  }
                  if (cartList.length > 0) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(cartList: cartList, cartLists: cartProductList,)));
                  } else {
                    showCustomSnackBar('Sélectionnez un produit au moins', context);
                  }
                }else {
                  showAnimatedDialog(context, GuestDialog(), isFlip: true);
                }
              },
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text('Commander', style: titilliumSemiBold.copyWith(
                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                color: ColorResources.getPrimary(context),
              )),
            ),
          ),
        ]),
      ) : null,

      body: Column(children: [

        CustomAppBar(title: 'Panier'),

        Provider.of<CartProvider>(context).cartList.length != 0 ? ListView.builder(
          itemCount: sellerList.length,
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                  decoration: BoxDecoration(color: Theme.of(context).accentColor, boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 3)),
                  ]),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Vendeur', textAlign: TextAlign.start, style: titilliumRegular),
                    Text(sellerList[index], textAlign: TextAlign.end, style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.getPrimary(context),
                    )),
                  ]),
                ),
                Consumer<CartProvider>(
                  builder: (context, carProvider, child) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemCount: cartProductList[index].length,
                      itemBuilder: (context, i) => CartWidget(
                        cartModel: cartProductList[index][i],
                        index: cartProductIndexList[index][i],
                        fromCheckout: fromCheckout,
                      ),
                    );
                  },
                ),
              ]),
            );
          },
        ) : Expanded(child: NoInternetOrDataScreen(isNoInternet: false)),
      ]),
    );
  }
}
