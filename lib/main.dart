import 'package:assetManagment/components/loadingIndicator.dart';
import 'package:assetManagment/containers/mainApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assetManagment/providers/employeeProvider.dart';
import "./providers/assetsProvider.dart";

import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./theme/default.dart";
import "./constants/constants.dart";
import "./routes/routes.dart";
import "./providers/loginProvider.dart";

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => EmployeeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AssetsProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: unused_field
  bool _initialized = false;
  // ignore: unused_field
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e);
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print("error");
      return LoadingIndicator(loadingMessage: "Loading", color: Colors.red);
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return LoadingIndicator(loadingMessage: "Loading", color: Colors.red);
    }

    return MaterialApp(
      title: Constants["appName"],
      theme: defaultTheme,
      home: MainApp(),
      onGenerateRoute: (setting) => onGeneratedRoute(setting: setting),
    );
  }
}
