import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/coupon_model.dart';
import 'package:sixvalley_ui_kit/data/repository/coupon_repo.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepo couponRepo;
  CouponProvider({@required this.couponRepo});

  CouponModel _coupon;
  double _discount;
  bool _isLoading = false;
  CouponModel get coupon => _coupon;
  double get discount => _discount;
  bool get isLoading => _isLoading;

  double initCoupon() {
    _coupon = couponRepo.getCoupon();
    if (_coupon.minPurchase != null && double.parse(_coupon.minPurchase) < 1000) {
      if(_coupon.discountType == 'percentage') {
        _discount = (double.parse(_coupon.discount) * 1000 / 100) < double.parse(_coupon.maxDiscount)
            ? (double.parse(_coupon.discount) * 1000 / 100) : double.parse(_coupon.maxDiscount);
      }else {
        _discount = double.parse(_coupon.discount);
      }
    } else {
      _discount = 0;
    }
    notifyListeners();
    return _discount;
  }

  void removePrevCouponData() {
    _coupon = null;
    _isLoading = false;
    _discount = null;
  }
}
