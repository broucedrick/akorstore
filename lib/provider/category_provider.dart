import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/repository/category_repo.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;

  CategoryProvider({@required this.categoryRepo});

  List<Category> _categoryList = [];
  int _categorySelectedIndex;

  List<Category> get categoryList => _categoryList;

  int get categorySelectedIndex => _categorySelectedIndex;

  void initCategoryList() async {
    if (_categoryList.length == 0) {
      _categoryList.clear();
      categoryRepo.getCategoryList().forEach((category) => _categoryList.add(category));
      _categorySelectedIndex = 0;
      notifyListeners();
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
}
