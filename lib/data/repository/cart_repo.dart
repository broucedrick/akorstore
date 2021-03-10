import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({@required this.sharedPreferences});

  List<CartModel> getCartList() {
    List<String> carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    List<CartModel> cartList = [];
    carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)) );
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }

}