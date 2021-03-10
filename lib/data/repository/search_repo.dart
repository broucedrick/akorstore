
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchRepo with ChangeNotifier{
  final SharedPreferences sharedPreferences;
  SearchRepo({@required this.sharedPreferences});
  String hote = "http://192.168.1.7:8000/api/";

  List<Product> prod = [];

  List<Product> getSearchProductList(String query) {

    List<Product> productList = [
      //Product(1, 'admin', '1', 'Lamborghini', '', [], '', '', '1', '', ['assets/images/white_car.png', 'assets/images/blue_car.png'], 'assets/images/blue_car.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.7')]),
      //Product(2, 'seller', '2', 'Special Lounge', '', [], '', '', '1', '', ['assets/images/lounge1.png', 'assets/images/Lounge.png', 'assets/images/lounge2.png'], 'assets/images/lounge.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.2')]),
    ];



    getProducts(query).then((value) {
      prod = [];
      value.forEach((element) {

        prod.add(element);
        //debugPrint(productList.length.toString());

      });

    });

    debugPrint(prod.length.toString());
    productList = [];
    productList = prod;
    notifyListeners();
    return productList;

  }

  Future<List<Product>> getProducts(String query) async {
    List products;
    List<Product> allProducts = [];
    var response = await http.get("${hote}produits?nom=$query");
    int statusCode = response.statusCode;
    if(statusCode == 200){
      products = json.decode(response.body)['hydra:member'];
      //debugPrint(products.toString());
      products.forEach((element) {
        //debugPrint(element['id'].toString());

        allProducts.add(Product(element['id'], element['stockId'], element['photo'], element['nom'], element['description'], element['stock'], element['quantite'], element['prixVente'], element['categorieId'], element['createdAt'], element['updatedAt'], element['consumerId']));
        //debugPrint(allProducts.toString());
      });
    }else{
      debugPrint("Erreur");
    }
    //debugPrint(allProducts.length.toString());
    notifyListeners();
    return allProducts;

  }


  // for save home address
  Future<void> saveSearchAddress(String searchAddress) async {
    try {
      List<String> searchKeywordList = sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS);
      if (!searchKeywordList.contains(searchAddress)) {
        searchKeywordList.add(searchAddress);
      }
      await sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, searchKeywordList);
    } catch (e) {
      throw e;
    }
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS) ?? [];
  }

  Future<bool> clearSearchAddress() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
  }
}
