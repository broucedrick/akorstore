import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.sharedPreferences});


  // for  user token
  Future<void> saveUserToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    return sharedPreferences.remove(AppConstants.TOKEN);
  }


  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

}
