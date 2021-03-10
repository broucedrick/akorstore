import 'package:sixvalley_ui_kit/data/model/response/seller_model.dart';

class SellerRepo {

  SellerModel getSeller() {
    SellerModel sellerModel = SellerModel(1, 'John', 'Doe', '+886745575', 'assets/images/brand.jpg', Shop(sellerId: '1', name: 'Daraz', image: 'assets/images/banner.jpg'));
    return sellerModel;
  }
}