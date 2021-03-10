
import 'package:sixvalley_ui_kit/data/model/response/banner_model.dart';

class BannerRepo {

  List<BannerModel> getBannerList() {
    List<BannerModel> bannerList = [
      BannerModel(id: 1, photo: 'assets/images/banner.jpg', url: 'https://www.facebook.com'),
      // BannerModel(id: 2, photo: 'assets/images/banner1.png', url: 'https://www.facebook.com'),
      // BannerModel(id: 3, photo: 'assets/images/banner2.png', url: 'https://www.facebook.com'),
    ];
    return bannerList;
  }
}