import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/data/repository/product_repo.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;
  ProductProvider({@required this.productRepo});

  // Latest products
  List<Product> _latestProductList = [];
  bool _firstLoading = true;

  List<Product> get latestProductList => _latestProductList;
  bool get firstLoading => _firstLoading;

  void initLatestProductList() async {
    _latestProductList = [];
    var response = await http.get("https://app.akorstore.com/api/produits");
    int statusCode = response.statusCode;
    if(statusCode == 200){
      List res = json.decode(response.body)['hydra:member'];
      //debugPrint(products.toString());
      res.forEach((element) {
        //debugPrint(element['id'].toString());
        _latestProductList.add(Product(element['id'], element['stockId'], element['photo'], element['nom'], element['description'], element['stock'], element['quantite'], element['prixVente'], element['categorieId'], element['createdAt'], element['updatedAt'], element['consumerId']));
        //debugPrint(allProducts.toString());
        notifyListeners();
      });

    }else{
      debugPrint("Erreur");
    }
    //_latestProductList.addAll(productRepo.getLatestProductList());
    _firstLoading = false;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }

  // Seller products
  List<Product> _sellerAllProductList = [];
  List<Product> _sellerProductList = [];
  List<Product> get sellerProductList => _sellerProductList;

  void initSellerProductList() async {
    _firstLoading = false;
    _sellerProductList.addAll(productRepo.getSellerProductList());
    _sellerAllProductList.addAll(productRepo.getSellerProductList());
    notifyListeners();
  }

  void filterData(String newText) {
    _sellerProductList.clear();
    if(newText.isNotEmpty) {
      _sellerAllProductList.forEach((product) {
        if (product.nom.toLowerCase().contains(newText.toLowerCase())) {
          _sellerProductList.add(product);
        }
      });
    }else {
      _sellerProductList.clear();
      _sellerProductList.addAll(_sellerAllProductList);
    }
    notifyListeners();
  }

  void clearSellerData() {
    _sellerProductList = [];
    notifyListeners();
  }

  // Brand and category products
  List<Product> _brandOrCategoryProductList = [];
  bool _hasData;

  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  bool get hasData => _hasData;

  void initBrandOrCategoryProductList(bool isBrand, String id) async {
    _brandOrCategoryProductList.clear();
    _hasData = true;
    productRepo.getBrandOrCategoryProductList().forEach((product) => _brandOrCategoryProductList.add(product));
    _hasData = _brandOrCategoryProductList.length > 1;

    notifyListeners();
  }

  // Related products
  List<Product> _relatedProductList;
  List<Product> get relatedProductList => _relatedProductList;

  void initRelatedProductList() async {
    _firstLoading = false;
    _relatedProductList = [];
    productRepo.getRelatedProductList().forEach((product) => _relatedProductList.add(product));
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
    notifyListeners();
  }
}
