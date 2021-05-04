import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/address_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/data/repository/profile_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;

  ProfileProvider({@required this.profileRepo});

  List<String> _addressTypeList = [];

  List<String> get addressTypeList => _addressTypeList;

  String _addressType = '';

  String get addressType => _addressType;

  UserInfoModel _userInfoModel;

  UserInfoModel get userInfoModel => _userInfoModel;

  bool _isAvailableProfile = false;

  bool get isAvailableProfile => _isAvailableProfile;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<AddressModel> _addressList;

  List<AddressModel> get addressList => _addressList;

  bool _hasData;

  bool get hasData => _hasData;

  bool _isHomeAddress = true;

  bool get isHomeAddress => _isHomeAddress;

  String _addAddressErrorText;

  String get addAddressErrorText => _addAddressErrorText;

  void setAddAddressErrorText(String errorText) {
    _addAddressErrorText = errorText;
    notifyListeners();
  }

  void updateAddressCondition(bool value) {
    _isHomeAddress = value;
    notifyListeners();
  }

  bool _checkHomeAddress = false;

  bool get checkHomeAddress => _checkHomeAddress;

  bool _checkOfficeAddress = false;

  bool get checkOfficeAddress => _checkOfficeAddress;

  void setHomeAddress() {
    _checkHomeAddress = true;
    _checkOfficeAddress = false;
    notifyListeners();
  }

  void setOfficeAddress() {
    _checkHomeAddress = false;
    _checkOfficeAddress = true;
    notifyListeners();
  }

  updateCountryCode(String value) {
    _addressType = value;
    notifyListeners();
  }

  void initAddressList(String id) {
    _addressList = [];
    profileRepo.getAllAddress(id).then((value) => value.forEach((element) {
          _addressList.add(element);
          notifyListeners();
        }));
    notifyListeners();
  }

  void removeAddressById(int id, int index) async {
    _isLoading = true;
    notifyListeners();
    _addressList.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUserInfo(String id) async {
    var response = await http.get("https://app.akorstore.com/api/utilisateurs");
    debugPrint(response.statusCode.toString());
    if(response.statusCode == 200){
      List res = json.decode(response.body)['hydra:member'];
      for(var user in res){

        if(user['id'] == id){
          _userInfoModel = UserInfoModel(id: user['id'], name: user['name'], fName: user['name'].toString().split(" ")[0], lName: user['name'].toString().split(" ")[1], phone: user['nember'], email: user['identifiant'], image: 'assets/images/person.jpg');
          debugPrint(user.toString());
          notifyListeners();
        }
      }
    }
    _isAvailableProfile = true;
    notifyListeners();
    return _userInfoModel.id.toString();
  }

  void initAddressTypeList() async {
    if (_addressTypeList.length == 0) {
      _addressTypeList.clear();
      _addressTypeList.addAll(profileRepo.getAddressTypeList());
      _addressType = profileRepo.getAddressTypeList()[0];
      notifyListeners();
    }
  }

  Future addAddress(AddressModel addressModel) async {
    _addressList.add(addressModel);
    setAdresse(addressModel);
    notifyListeners();
  }

  void setAdresse(AddressModel addressModel) async {
    Map data = {
      "iduser": addressModel.customerId.toString(),
      "adresse": addressModel.address,
      "ville": addressModel.city,
      "typeadresse": addressModel.addressType,
      "numero": addressModel.phone,
      "idCommande": ""
    };

    String body = json.encode(data);

    var response = await http.post("https://app.akorstore.com/api/adresses",
        headers: {"Content-Type": "application/json"}, body: body);

    if(response.statusCode == 201){
      debugPrint("oui");
      initAddressList(addressModel.customerId);
    }
  }

  Future updateUserInfo(UserInfoModel updateUserModel) async {
    _userInfoModel = updateUserModel;
    notifyListeners();
  }

  // save office and home address
  void saveHomeAddress(String homeAddress) {
    profileRepo.saveHomeAddress(homeAddress).then((_) {
      notifyListeners();
    });
  }

  void saveOfficeAddress(String officeAddress) {
    profileRepo.saveOfficeAddress(officeAddress).then((_) {
      notifyListeners();
    });
  }

  // for home Address Section
  String getHomeAddress() {
    return profileRepo.getHomeAddress();
  }

  Future<bool> clearHomeAddress() async {
    return await profileRepo.clearHomeAddress();
  }

  // for office Address Section
  String getOfficeAddress() {
    return profileRepo.getOfficeAddress();
  }

  Future<bool> clearOfficeAddress() async {
    return await profileRepo.clearOfficeAddress();
  }
}
