import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/helper/price_converter.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_details_screen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  OrderWidget({this.orderModel});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        debugPrint('cart : ${orderModel.cartProductList.length.toString()}');
        List<OrderDetailsModel> ord = [];
        var response = await http.get("http://app.akorstore.com/api/cproduits?idCommande=${orderModel.id}");
        if(response.statusCode == 200){
          List res = json.decode(response.body)['hydra:member'];
          res.forEach((element) {
 /* */           CartModel cart = CartModel(element['idProduit'], element['image'], element['nom'], element['idVendeur'], element['somme'], element['quantite']);
            OrderDetailsModel odm = OrderDetailsModel(id: element['id'], orderId: element['idCommande'].toString(), sellerId: element['idVendeur'], productDetails: cart, qty: element['quantite'].toString(), price: element['somme'].toString(), deliveryStatus: orderModel.orderStatus, paymentStatus: orderModel.paymentStatus, createdAt: orderModel.createdAt);
            ord.add(odm);
          });
          debugPrint('cart n : ${ord.length.toString()}');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetails(order: orderModel, ord: ord)));
        }
        // orderModel.cartProductList.forEach((product) {
        //   OrderDetailsModel odm = OrderDetailsModel(id: 1, orderId: orderModel.id.toString(), sellerId: product.seller, productDetails: product, qty: product.quantity.toString(), price: product.price.toString(), deliveryStatus: orderModel.orderStatus, paymentStatus: orderModel.paymentStatus, createdAt: orderModel.createdAt);
        //   ord.add(odm);
        // });
        // debugPrint('cart n : ${ord.length.toString()}');
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetails(order: orderModel, ord: ord)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL, left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(5)),
        child: Row(children: [

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('ID Commande:', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(orderModel.id.toString(), style: titilliumSemiBold),
            ]),
            Row(children: [
              Text('Date:', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(orderModel.createdAt, style: titilliumRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).hintColor,
              )),
            ]),
          ]),
          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Montant:', style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              Text('${orderModel.orderAmount} CFA', style: titilliumSemiBold),
            ]),
          ),

          // Container(
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          //   decoration: BoxDecoration(
          //     color: ColorResources.getLowGreen(context),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Text(orderModel.orderStatus.toUpperCase(), style: titilliumSemiBold),
          // ),

        ]),
      ),
    );
  }
}
