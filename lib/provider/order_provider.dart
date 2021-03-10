import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/model/body/order_place_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/shipping_method_model.dart';
import 'package:sixvalley_ui_kit/data/repository/order_repo.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo orderRepo;
  OrderProvider({@required this.orderRepo});

  List<OrderModel> _pendingList;
  List<OrderModel> _deliveredList;
  List<OrderModel> _canceledList;

  int _addressIndex;
  //int _shippingIndex;
  bool _isLoading = false;
  //List<ShippingMethodModel> _shippingList;

  List<OrderModel> get pendingList => _pendingList;
  List<OrderModel> get deliveredList => _deliveredList;
  List<OrderModel> get canceledList => _canceledList;

  int get addressIndex => _addressIndex;
  //int get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  //List<ShippingMethodModel> get shippingList => _shippingList;

  List<OrderModel> _orderList = [];
  List<OrderModel> get orderList => _orderList;

  void addOrder(_orderm) {
    _orderList.add(_orderm);
    notifyListeners();
  }

  void initOrderList() async {
    _pendingList = [];
    _deliveredList = [];
    _canceledList = [];
    _orderList.forEach((order) {
      OrderModel orderModel = order;
      if (orderModel.orderStatus == 'pending') {
        _pendingList.add(orderModel);
      } else if (orderModel.orderStatus == 'delivered') {
        _deliveredList.add(orderModel);
      } else if (orderModel.orderStatus == 'cancelled') {
        _canceledList.add(orderModel);
      }
    });
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  List<OrderDetailsModel> _orderDetails;
  List<OrderDetailsModel> get orderDetails => _orderDetails;



  void getOrderDetails(int id) async {
    _orderDetails = [];
    orderRepo.getOrderDetails(id).forEach((order) => _orderDetails.add(order));
    notifyListeners();
  }

  Future<void> placeOrder(OrderPlaceModel orderPlaceModel, Function callback, List<CartModel> cartList) async {
    _addressIndex = null;
    callback(true, 'Order placed successfully', cartList);
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }

  // void initShippingList() async {
  //   _shippingList = [];
  //   orderRepo.getShippingList().forEach((shippingMethod) => _shippingList.add(shippingMethod));
  //   notifyListeners();
  // }

  // void setSelectedShippingAddress(int index) {
  //   _shippingIndex = index;
  //   notifyListeners();
  // }
}
