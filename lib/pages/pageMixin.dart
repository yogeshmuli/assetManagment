import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageMixin {
  checkAuthStatus({BuildContext context, bool rootNavigator = false}) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    fbAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        // Navigator.of(context).pushNamed("/login");
        Navigator.of(context, rootNavigator: rootNavigator)
            .pushNamedAndRemoveUntil("/login", (route) => false);
      } else {
        print('User is signed in!');
      }
    });
  }

  onNetworkError({GlobalKey<ScaffoldState> scafoldKey, e}) {
    Future.delayed(Duration(seconds: 0), () {
      if (scafoldKey.currentState != null) {
        scafoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Something Went Wrong"),
          backgroundColor: Colors.red,
        ));
      }
    });
    print(e);
  }

  onCustomError({GlobalKey<ScaffoldState> scafoldKey, String message}) {
    Future.delayed(Duration(seconds: 0), () {
      if (scafoldKey.currentState != null) {
        scafoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      }
    });
    print(message);
  }

  onUnauthorisedError({BuildContext context, e, bool rootNavigator = false}) {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamedAndRemoveUntil("/login", (route) => false);
    });
  }
}
