
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/address_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.sharedPreferences});

  List<String> getAddressTypeList() {
    List<String> addressTypeList = [
      'Select Address type',
      'Home',
      'Office',
      'Other',
    ];
    return addressTypeList;
  }

  UserInfoModel getUserInfo() {
    UserInfoModel userInfoModel = UserInfoModel(id: 1, name: 'John Doe', fName: 'John', lName: 'Doe', phone: '+886737663', email: 'johndoe@gmail.com', image: 'assets/images/person.jpg');

    return userInfoModel;
  }

  List<AddressModel> getAllAddress(String id) {
    List<AddressModel> addressList = [
      AddressModel(id: 1, customerId: '1', contactPersonName: 'John Doe', addressType: 'Home', address: 'Dhaka, Bangladesh'),
    ];
    return addressList;
  }

  // for save home address
  Future<void> saveHomeAddress(String homeAddress) async {
    try {
      await sharedPreferences.setString(AppConstants.HOME_ADDRESS, homeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getHomeAddress() {
    return sharedPreferences.getString(AppConstants.HOME_ADDRESS) ?? "";
  }

  Future<bool> clearHomeAddress() async {
    return sharedPreferences.remove(AppConstants.HOME_ADDRESS);
  }

  // for save office address
  Future<void> saveOfficeAddress(String officeAddress) async {
    try {
      await sharedPreferences.setString(AppConstants.OFFICE_ADDRESS, officeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getOfficeAddress() {
    return sharedPreferences.getString(AppConstants.OFFICE_ADDRESS) ?? "";
  }

  Future<bool> clearOfficeAddress() async {
    return sharedPreferences.remove(AppConstants.OFFICE_ADDRESS);
  }
}
