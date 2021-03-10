import 'package:sixvalley_ui_kit/data/model/response/brand_model.dart';

class BrandRepo {

  List<BrandModel> getBrandList() {
    List<BrandModel> brandList = [
      BrandModel(image: 'assets/images/brand.jpg', name: 'Xiaomi'),
      BrandModel(image: 'assets/images/brand1.png', name: 'Apple'),
      BrandModel(image: 'assets/images/brand2.png', name: 'Huawei'),
      BrandModel(image: 'assets/images/brand3.png', name: 'Samsung'),
      BrandModel(image: 'assets/images/brand4.png', name: 'Toyota'),
      BrandModel(image: 'assets/images/brand.jpg', name: 'Xiaomi'),
      BrandModel(image: 'assets/images/brand1.png', name: 'Apple'),
      BrandModel(image: 'assets/images/brand2.png', name: 'Huawei'),
      BrandModel(image: 'assets/images/brand3.png', name: 'Samsung'),
      BrandModel(image: 'assets/images/brand4.jpg', name: 'Toyota'),
      BrandModel(image: 'assets/images/brand.jpg', name: 'Xiaomi'),
      BrandModel(image: 'assets/images/brand1.png', name: 'Apple'),
      BrandModel(image: 'assets/images/brand2.png', name: 'Huawei'),
      BrandModel(image: 'assets/images/brand3.png', name: 'Samsung'),
      BrandModel(image: 'assets/images/brand4.jpg', name: 'Toyota'),
    ];
    return brandList;
  }
}