import 'package:sixvalley_ui_kit/data/model/response/category.dart';

class CategoryRepo {
  List<Category> getCategoryList() {
    List<Category> categoryList = [
      Category(id: 1, name: 'Accessories', icon: 'assets/images/category.jpg', subCategories: [SubCategory(name: 'Headphone', subSubCategories: [SubSubCategory(id: 1, name: 'Earphone', position: '1')])]),
      Category(id: 2, name: 'Vehicle', icon: 'assets/images/category1.png', subCategories: []),
      Category(id: 3, name: 'Electronic Devices', icon: 'assets/images/category2.png', subCategories: []),
      Category(id: 4, name: 'Electronic Accessories', icon: 'assets/images/category3.png', subCategories: []),
      Category(id: 5, name: 'TV', icon: 'assets/images/category4.png', subCategories: []),
      Category(id: 6, name: 'Health and Beauty', icon: 'assets/images/category5.png', subCategories: []),
      Category(id: 7, name: 'Babies and toys', icon: 'assets/images/category6.png', subCategories: []),
      Category(id: 8, name: 'Groceries', icon: 'assets/images/category7.png', subCategories: []),
      Category(id: 1, name: 'Accessories', icon: 'assets/images/category.jpg', subCategories: [SubCategory(name: 'Headphone', subSubCategories: [SubSubCategory(id: 1, name: 'Earphone', position: '1')])]),
      Category(id: 2, name: 'Vehicle', icon: 'assets/images/category1.png', subCategories: []),
      Category(id: 3, name: 'Electronic Devices', icon: 'assets/images/category2.png', subCategories: []),
      Category(id: 4, name: 'Electronic Accessories', icon: 'assets/images/category3.png', subCategories: []),
      Category(id: 5, name: 'TV', icon: 'assets/images/category4.png', subCategories: []),
      Category(id: 6, name: 'Health and Beauty', icon: 'assets/images/category5.png', subCategories: []),
      Category(id: 7, name: 'Babies and toys', icon: 'assets/images/category6.png', subCategories: []),
      Category(id: 8, name: 'Groceries', icon: 'assets/images/category7.png', subCategories: []),
    ];
    return categoryList;
  }
}