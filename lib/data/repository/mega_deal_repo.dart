
import 'package:sixvalley_ui_kit/data/model/response/product_model_test.dart';

class MegaDealRepo {
  List<Product> getMegaDealList() {
    List<Product> productList = [
      Product("1", 1, 'assets/images/white_car.png', "Volkswagen", "gfhgfhjgkihophpojophop", "voiture", "1", "10000000","2","01-01-01","01-01-01","AkorIT"),
      Product("2", 2, 'assets/images/lounge1.png', "Volkswagen", "gfhgfhjgkihophpojophop", "voiture", "2", "20000","2","01-01-01","01-01-01","AkorIT"),
      //Product(1, 'admin', '1', 'Lamborghini', '', [], '', '', '1', '', ['assets/images/white_car.png', 'assets/images/blue_car.png'], 'assets/images/blue_car.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.7')]),
      //Product(2, 'seller', '2', 'Special Lounge', '', [], '', '', '1', '', ['assets/images/lounge1.png', 'assets/images/Lounge.png', 'assets/images/lounge2.png'], 'assets/images/lounge.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.2')]),
    ];
    return productList;
  }
}