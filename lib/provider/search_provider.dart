import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/data/repository/search_repo.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;
  SearchProvider({@required this.searchRepo});

  int _filterIndex = 0;
  List<String> _historyList = [];

  int get filterIndex => _filterIndex;
  List<String> get historyList => _historyList;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }

  void sortSearchList(double startingPrice, double endingPrice) {
    if (_filterIndex == 0) {
      _searchProductList.clear();
      _searchProductList.addAll(_filterProductList);
    } else if (_filterIndex == 1) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.prixVente)) > startingPrice && (double.parse(product.prixVente)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => a.nom.compareTo(b.nom));
    } else if (_filterIndex == 2) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.prixVente)) > startingPrice && (double.parse(product.prixVente)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => a.nom.compareTo(b.nom));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    } else if (_filterIndex == 3) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.prixVente)) > startingPrice && (double.parse(product.prixVente)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => double.parse(a.prixVente).compareTo(double.parse(b.prixVente)));
    } else if (_filterIndex == 4) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.prixVente)) > startingPrice && (double.parse(product.prixVente)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => a.prixVente.compareTo(b.prixVente));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    }

    notifyListeners();
  }

  List<Product> _searchProductList;
  List<Product> _filterProductList;
  bool _isClear = true;
  String _searchText = '';

  List<Product> get searchProductList => _searchProductList;
  List<Product> get filterProductList => _filterProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void cleanSearchProduct() {
    _searchProductList = [];
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }

  void searchProduct(String query) async {
    _searchText = query;
    _isClear = false;
    _searchProductList = null;
    _filterProductList = null;
    notifyListeners();

    if (query.isEmpty) {
      _searchProductList = [];
    } else {
      _searchProductList = [];
      _searchProductList.addAll(searchRepo.getSearchProductList(_searchText));
      //debugPrint(_searchProductList.toString());
      _filterProductList = [];
      _filterProductList.addAll(searchRepo.getSearchProductList(_searchText));
    }
    notifyListeners();
  }

  // for save home address
  void initHistoryList() {
    _historyList = searchRepo.getSearchAddress();
    notifyListeners();
  }

  void saveSearchAddress(String searchAddress) async {
    searchRepo.saveSearchAddress(searchAddress);
    if (!_historyList.contains(searchAddress)) {
      _historyList.add(searchAddress);
    }
    notifyListeners();
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchAddress();
    _historyList.clear();
    notifyListeners();
  }
}
