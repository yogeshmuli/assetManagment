import 'package:assetManagment/services/responseHandler.dart';

import "../models/loginRequest.dart";
import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  login(LoginRequestModel loginModel) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginModel.email, password: loginModel.password);
      print(userCredential.toString());
      return (userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        throw FbCustomException(message: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        throw FbCustomException(
            message: 'Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "success";
    } catch (e) {
      print(e);
    }
  }
}
