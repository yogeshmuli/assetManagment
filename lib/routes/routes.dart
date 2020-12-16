import 'package:assetManagment/containers/mainApp.dart';
import 'package:assetManagment/pages/login/login.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGeneratedRoute({setting}) {
  switch (setting.name) {
    case "/mainapp":
      return MaterialPageRoute(builder: (context) => MainApp());
      break;
    case "/login":
      return MaterialPageRoute(
          builder: (context) => LoginPage(
                title: "login page",
              ));
      break;
    default:
      return MaterialPageRoute(
          builder: (context) => LoginPage(
                title: "login page",
              ));
  }
}
