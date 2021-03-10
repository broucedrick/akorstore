import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/banner_model.dart';
import 'package:sixvalley_ui_kit/data/repository/banner_repo.dart';

class BannerProvider extends ChangeNotifier {
  final BannerRepo bannerRepo;

  BannerProvider({@required this.bannerRepo});

  List<BannerModel> _bannerList;
  int _currentIndex;

  List<BannerModel> get bannerList => _bannerList;
  int get currentIndex => _currentIndex;

  void initBannerList() async {
    if (_bannerList == null) {
      _bannerList = [];
      bannerRepo.getBannerList().forEach((bannerModel) => _bannerList.add(bannerModel));
      _currentIndex = 0;
      notifyListeners();
    }
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
