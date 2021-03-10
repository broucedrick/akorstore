import 'package:sixvalley_ui_kit/data/model/response/coupon_model.dart';

class CouponRepo {

  CouponModel getCoupon() {
    CouponModel couponModel = CouponModel(id: 1, title: '', code: 'ABC', minPurchase: '100', maxDiscount: '1000', discount: '60', discountType: 'percent');
    return couponModel;
  }
}