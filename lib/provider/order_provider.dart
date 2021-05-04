import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/model/body/order_place_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_details.dart';
import 'package:sixvalley_ui_kit/data/model/response/order_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/shipping_method_model.dart';
import 'package:sixvalley_ui_kit/data/repository/order_repo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:nanoid/nanoid.dart';

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

  void makeOrder(List<OrderModel> orders){
    orders.forEach((order) {
      setOrder(order);
    });
  }

  void setOrder(OrderModel ords) async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String orderId = "AK"+nanoid(6).toUpperCase()+date.toString().split(" ")[0].replaceAll("-", "");
    Map data = {
      "etat": ords.orderStatus,
      "montant" : int.parse(ords.orderAmount.replaceAll(".0", "")),
      "adresse" : ords.shippingAddress,
      "paiementMethode" : ords.paymentMethod,
      "paiementstatut": ords.paymentStatus,
      "refTrans" : ords.transactionRef,
      "oderId" : orderId,
      "idUser" : ords.customerType,
      "date": date.toString(),
      "custumerid": ords.customerId,
      "livreurid": "null"
    };

    String body = json.encode(data);
    //url: "https://app.akorstore.com/api/commandes",
    // headers: {"Content-Type": "application/json"},
    var response = await http.post(
      "https://app.akorstore.com/api/commmandes",
      headers: {"Content-Type": "application/json"},
      body: body
    );

    if(response.statusCode == 201){
      debugPrint("Order ${orderId} successful Sets");
      ords.cartProductList.forEach((element) {
        setOrderProduct(element, orderId);
      });
    }else{
      debugPrint("Erreur : ${response.body}");
    }
  }

  void setOrderProduct(CartModel prods, String orderId) async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    Map data = {
      "idProduit": prods.id.toString(),
      "idCommande": orderId,
      "quantite": prods.quantity.toString(),
      "somme": prods.price.toInt(),
      "date": date.toString(),
      "image": prods.image,
      "seller": prods.seller,
      "name": prods.name
    };

    String body = json.encode(data);

    var response = await http.post(
        "https://app.akorstore.com/api/cproduits",
        headers: {"Content-Type": "application/json"},
        body: body
    );
    debugPrint(response.statusCode.toString());
    if(response.statusCode == 201){
      debugPrint("Product ${prods.id} for order ${orderId} successful sets");
    }else{
      debugPrint("Erreur : ${response.body}");
    }
  }

  void addOrder(_orderm) {
    _orderList.add(_orderm);
    notifyListeners();
  }

  void initOrderList(String id) async {
    _pendingList = [];
    _deliveredList = [];
    _canceledList = [];

    var response = await http.get("https://app.akorstore.com/api/commmandes");
    debugPrint("${response.statusCode} FETCHING ORDERS ...");
    if(response.statusCode == 200){
      List res = json.decode(response.body)['hydra:member'];
      res.forEach((element) {
        if(element['idUser'] == id){
          debugPrint("ID : ${element['oderId']}");
          OrderModel model = OrderModel(id: element['oderId'], customerId: element['custumerid'], shippingAddress: element['adresse'], orderStatus: element['etat'], paymentMethod: element['paiementMethode'], transactionRef: element['refTrans'], createdAt: element["date"], updatedAt: element["date"], orderAmount: element['montant'].toString(), paymentStatus: element['paiementstatut']);
          if (model.orderStatus == 'termine') {
            _deliveredList.add(model);
          } else if (model.orderStatus == 'annule') {
            _canceledList.add(model);
          }else{
            _pendingList.add(model);
          }
        }
      });
      notifyListeners();
    }else{
      debugPrint("Erreur : ${response.body}");
    }

    // _orderList.forEach((order) {
    //   OrderModel orderModel = order;
    //   if (orderModel.orderStatus == 'pending') {
    //     _pendingList.add(orderModel);
    //   } else if (orderModel.orderStatus == 'delivered') {
    //     _deliveredList.add(orderModel);
    //   } else if (orderModel.orderStatus == 'cancelled') {
    //     _canceledList.add(orderModel);
    //   }
    // });
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



  void getOrderDetails(String id) async {
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
