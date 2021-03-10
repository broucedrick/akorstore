class ProductModelTest {
  int _totalSize;
  String _limit;
  String _offset;
  List<Product> _products;

  ProductModelTest(int totalSize, String limit, String offset, List<Product> products) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._products = products;
  }

  int get totalSize => _totalSize;
  String get limit => _limit;
  String get offset => _offset;
  List<Product> get products => _products;

  ProductModelTest.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = new List<Product>();
      json['products'].forEach((v) {
        _products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;
    if (this._products != null) {
      data['products'] = this._products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String _id;
  int _stockId;
  String _photo;
  String _nom;
  String _description;
  String _stock;
  String _quantite;
  String _prixVente;
  String _categorieId;
  String _createdAt;
  String _updatedAt;
  String _consumerId;

  Product(
      String id,
        int stockId,
        String photo,
        String nom,
        String description,
        String stock,
        String quantite,
        String prixVente,
        String categorieId,
        String createdAt,
        String updatedAt,
        String consumerId) {
    this._id = id;
    this._stockId = stockId;
    this._photo = photo;
    this._nom = nom;
    this._description = description;
    this._stock = stock;
    this._quantite = quantite;
    this._prixVente = prixVente;
    this._categorieId = categorieId;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._consumerId = consumerId;
  }

  String get id => _id;
  int get stockId => _stockId;
  String get photo => _photo;
  String get nom => _nom;
  String get description => _description;
  String get stock => _stock;
  String get quantite => _quantite;
  String get prixVente => _prixVente;
  String get categorieId => _categorieId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get consumerId => _consumerId;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _stockId = json['stockId'] as int;
    _photo = json['photo'];
    _nom = json['nom'];
    _description = json['description'];
    _stock =json['stock'];
    _quantite = json['quantite'];
    _prixVente = json['prixVente'];
    _categorieId = json['categorieId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _consumerId = json['consumerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['stockId'] = this._stockId;
    data['photo'] = this._photo;
    data['nom'] = this._nom;
    data['description'] = this._description;
    data['stock'] = this._stock;
    data['quantite'] = this._quantite;
    data['prixVente'] = this._prixVente;
    data['categorieId'] = this._categorieId;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['consumerId'] = this._consumerId;
    return data;
  }
}

// class CategoryIds {
//   String _id;
//   int _position;
//
//   CategoryIds({String id, int position}) {
//     this._id = id;
//     this._position = position;
//   }
//
//   String get id => _id;
//   int get position => _position;
//
//   CategoryIds.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _position = json['position'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['position'] = this._position;
//     return data;
//   }
// }

// class ChoiceOptions {
//   String _name;
//   String _title;
//   List<String> _options;
//
//   ChoiceOptions({String name, String title, List<String> options}) {
//     this._name = name;
//     this._title = title;
//     this._options = options;
//   }
//
//   String get name => _name;
//   String get title => _title;
//   List<String> get options => _options;
//
//   ChoiceOptions.fromJson(Map<String, dynamic> json) {
//     _name = json['name'];
//     _title = json['title'];
//     _options = json['options'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this._name;
//     data['title'] = this._title;
//     data['options'] = this._options;
//     return data;
//   }
// }

// class Variation {
//   String _type;
//   String _price;
//   String _sku;
//   String _qty;
//
//   Variation({String type, String price, String sku, String qty}) {
//     this._type = type;
//     this._price = price;
//     this._sku = sku;
//     this._qty = qty;
//   }
//
//   String get type => _type;
//   String get price => _price;
//   String get sku => _sku;
//   String get qty => _qty;
//
//   Variation.fromJson(Map<String, dynamic> json) {
//     _type = json['type'];
//     _price = json['price'];
//     _sku = json['sku'];
//     _qty = json['qty'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this._type;
//     data['price'] = this._price;
//     data['sku'] = this._sku;
//     data['qty'] = this._qty;
//     return data;
//   }
// }

// class Rating {
//   String _average;
//   String _productId;
//
//   Rating({String average, String productId}) {
//     this._average = average;
//     this._productId = productId;
//   }
//
//   String get average => _average;
//   String get productId => _productId;
//
//   Rating.fromJson(Map<String, dynamic> json) {
//     _average = json['average'];
//     _productId = json['product_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['average'] = this._average;
//     data['product_id'] = this._productId;
//     return data;
//   }
// }

// class ProductColors {
//   String _name;
//   String _code;
//
//   ProductColors({String name, String code}) {
//     this._name = name;
//     this._code = code;
//   }
//
//   String get name => _name;
//   String get code => _code;
//
//   ProductColors.fromJson(Map<String, dynamic> json) {
//     _name = json['name'];
//     _code = json['code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this._name;
//     data['code'] = this._code;
//     return data;
//   }
// }