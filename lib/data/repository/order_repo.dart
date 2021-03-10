import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/shipping_method_model.dart';

class OrderRepo {

  List<OrderModel> _orderList = [];

  //OrderRepo.addOrder(OrderModel orderm);
  List<OrderModel> get orderList => _orderList;

  addOrder(_orderm) {
    OrderModel om = _orderm;
    debugPrint("ORDER 2 : $om");
    _orderList.add(om as OrderModel);
    debugPrint("ORDER : "+_orderm.toString());
  }


  List<OrderModel> getOrderList() {
    List<OrderModel> orderList = [
      OrderModel(id: 100030, customerId: '1', paymentStatus: 'pending', paymentMethod: 'Cash On Delivery', orderAmount: '10000', shippingAddress: 'Dhaka, Bangladesh', createdAt: '12-12-20', orderStatus: 'pending'),
      OrderModel(id: 100031, customerId: '1', paymentStatus: 'pending', paymentMethod: 'Ssl Ecommerce', orderAmount: '20000', shippingAddress: 'Dhaka, Bangladesh', createdAt: '12-12-20', orderStatus: 'delivered'),
    ];
    return this._orderList;
  }

  List<OrderDetailsModel> getOrderDetails(int id) {
    List<OrderDetailsModel> orderDetailsList = [
      // OrderDetailsModel(id: 1, orderId: '1', productId: '1', sellerId: '1', productDetails: Product(1, 'admin', '1', 'Lamborghini', '', [], '', '', '1', '', ['assets/images/white_car.png', 'assets/images/blue_car.png'], 'assets/images/blue_car.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.7')]), qty: '1', price: '10000', discount: '1000', deliveryStatus: 'pending', paymentStatus: 'pending', shippingMethodId: '1', createdAt: '12-12-20'),
      // OrderDetailsModel(id: 1, orderId: '1', productId: '1', sellerId: '1', productDetails: Product(1, 'admin', '1', 'Lamborghini', '', [], '', '', '1', '', ['assets/images/white_car.png', 'assets/images/blue_car.png'], 'assets/images/blue_car.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.7')]), qty: '1', price: '10000', discount: '1000', deliveryStatus: 'pending', paymentStatus: 'pending', shippingMethodId: '1', createdAt: '12-12-20'),
    ];
    _orderList.forEach((element) {
      if(element.id == id){
        element.cartProductList.forEach((product) {
          OrderDetailsModel odm = OrderDetailsModel(id: 1, orderId: element.id.toString(), sellerId: product.seller, productDetails: product, qty: product.quantity.toString(), price: product.price.toString(), deliveryStatus: element.orderStatus, paymentStatus: element.paymentStatus, createdAt: element.createdAt);
          orderDetailsList.add(odm);
        });
      }
    });
    debugPrint('Order detail list : ${orderDetailsList.length.toString()}');
    return orderDetailsList;
  }

  List<ShippingMethodModel> getShippingList() {
    List<ShippingMethodModel> shippingMethodList = [
      ShippingMethodModel(id: 1, title: 'Currier', cost: '20', duration: '2-3 days'),
      ShippingMethodModel(id: 2, title: 'Company Vehicle', cost: '10', duration: '8-10 days'),
    ];
    return shippingMethodList;
  }

}
