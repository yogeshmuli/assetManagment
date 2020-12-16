import 'package:assetManagment/models/loginRequest.dart';
import "package:flutter/material.dart";
import "../services/loginService.dart";
import "package:shared_preferences/shared_preferences.dart";

class LoginProvider with ChangeNotifier {
  bool loading = false;

  Future<bool> get authStatus async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool("isAuth") == null ? false : pref.getBool("isAuth");
  }

  Future<dynamic> login({LoginRequestModel loginmodel}) async {
    this.loading = true;
    notifyListeners();
    try {
      LoginService loginService = new LoginService();
      await loginService.login(loginmodel);

      this.loading = false;
      notifyListeners();
      return "ok";
      // this.loginSucessfull=false;
    } catch (e) {
      print(e);
      this.loading = false;
      notifyListeners();
      throw e;
    }
  }

  logout() async {
    // final pref = await SharedPreferences.getInstance();
    // pref.remove("token");
    // pref.setBool("isAuth", false);
    LoginService loginService = new LoginService();
    loginService.logout();
  }
}
