import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  getHeaders() async {
    String token = await this.getToken();
    final headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    return headers;
  }

  getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }
}
