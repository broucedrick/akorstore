import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';
import 'package:sixvalley_ui_kit/data/repository/mega_deal_repo.dart';

class MegaDealProvider extends ChangeNotifier {
  final MegaDealRepo megaDealRepo;
  MegaDealProvider({@required this.megaDealRepo});

  List<Product> _megaDealList = [];
  Duration _duration;
  List<Product> get megaDealList => _megaDealList;
  Duration get duration => _duration;

  void initMegaDealList() async {
    if (_megaDealList.length == 0) {
      // _duration = Duration(days: 730);
      // Timer.periodic(Duration(seconds: 1), (timer) {
      //   _duration = _duration - Duration(seconds: 1);
      //   notifyListeners();
      // });

      _megaDealList.clear();
      megaDealRepo.getMegaDealList().forEach((flashDeal) => _megaDealList.add(flashDeal));
      notifyListeners();
    }
  }
}
