import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
    fontFamily: "Poppins-light",
    primaryColor: Colors.deepPurpleAccent[100],
    primarySwatch: Colors.deepPurple,
    primaryColorDark: Colors.deepPurpleAccent,
    accentColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.deepPurpleAccent[100],
        iconTheme: IconThemeData(color: Colors.white)),
    primaryColorLight: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
        headline5:
            TextStyle(fontFamily: "Poppins", fontSize: 16, color: Colors.black),
        headline6: TextStyle(
            color: Colors.white, fontSize: 22, fontFamily: "Poppins")));
