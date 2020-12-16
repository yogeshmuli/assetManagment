import 'package:assetManagment/providers/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> onUnauthorisedException(une) async {
  final pref = await SharedPreferences.getInstance();
  pref.remove("token");
  pref.remove("isAuth");
  print(une);
}

logout(BuildContext context) {
  Provider.of<LoginProvider>(context, listen: false).logout();
  Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
}
