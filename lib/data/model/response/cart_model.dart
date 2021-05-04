class CartModel {
  int _id;
  String _image;
  String _name;
  String _seller;
  double _price;
  int _quantity;

  CartModel(this._id, this._image, this._name, this._seller, this._price, this._quantity);

  int get quantity => _quantity;
  set quantity(int value) {
    _quantity = value;
  }
  double get price => _price;
  String get name => _name;
  String get seller => _seller;
  String get image => _image;
  int get id => _id;

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as int;
    _name = json['name'];
    _seller = json['seller'];
    _image = json['image'];
    _price = json['price'];
    //_discountedPrice = json['discounted_price'];
    _quantity = json['quantity'];
    //_variant = json['variant'];
    //_variation = json['variation'];
    //_discount = json['discount'];
    //_discountType = json['discount_type'];
    //_tax = json['tax'];
    //_taxType = json['tax_type'];
    //_shippingMethodId = json['shipping_method_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['seller'] = this._seller;
    data['image'] = this._image;
    data['price'] = this._price;
    //data['discounted_price'] = this._discountedPrice;
    data['quantity'] = this._quantity;
    //data['variant'] = this._variant;
    //data['variation'] = this._variation;
    //data['discount'] = this._discount;
    //data['discount_type'] = this._discountType;
    //data['tax'] = this._tax;
    //data['tax_type'] = this._taxType;
    //data['shipping_method_id'] = this._shippingMethodId;
    return data;
  }
}