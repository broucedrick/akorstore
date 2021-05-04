import 'dart:convert';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/body/login_model.dart';
import 'package:sixvalley_ui_kit/data/model/body/register_model.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({@required this.authRepo});
  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;
  bool isCorrect;

  updateSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isRemember => _isRemember;

  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  Future<bool> registration(RegisterModel register) async {

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    Map data = {
      "name": register.fName+" "+register.lName,
      "identifiant": register.email,
      "password": DBCrypt().hashpw(register.password, DBCrypt().gensalt()).toString(),
      "role": 3,
      "remember_token": null,
      "poste": null,
      "salaire": null,
      "nember": register.phone,
      "createdAt": date.toString(),
      "updatedAt": date.toString(),
      "consumerId": "1"
    };

    String body = json.encode(data);

    var response = await http.post("https://app.akorstore.com/api/utilisateurs",
        headers: {"Content-Type": "application/json"}, body: body);
    debugPrint(response.statusCode.toString());
    if(response.statusCode == 201){
      debugPrint("oui");
      // initAddressList(addressModel.customerId);
      return true;
    }else{
      debugPrint("non");
      debugPrint(json.decode(response.body)['hydra:description']);
      return false;
    }

  }

  Future<bool> login(LoginModel loginBody) async {
    bool retour;
    var response = await http.get("https://app.akorstore.com/api/utilisateurs?identifiant=${loginBody.email}");
    debugPrint(response.statusCode.toString());
    if(response.statusCode == 200){
      List res = json.decode(response.body)['hydra:member'];
      debugPrint(res.toString());
      for(var user in res){
        if(user['identifiant'] == loginBody.email && user['role'] == 3){
          isCorrect = new DBCrypt().checkpw(loginBody.password, user['password']);
          if(isCorrect){
            retour = true;
            authRepo.saveUserToken(user['id']);
            break;
          }else{
            debugPrint(json.decode(response.body).toString());
            retour = false;
            break;
          }
        }else{
          retour = false;
        }
      }
    }
    return retour;
  }

  // for user Section
  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }


  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }
}
