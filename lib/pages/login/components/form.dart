import 'package:assetManagment/models/loginRequest.dart';
import "package:flutter/material.dart";
import "../../../components/customInputs.dart";
import "../../../components/fullWidthButton.dart";

class LoginForm extends StatefulWidget {
  final onLogin;
  LoginForm({this.onLogin});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingControllerUsername =
      TextEditingController();
  TextEditingController _textEditingControllerPassword =
      TextEditingController();

  void onFormSubmit() {
    if (_formKey.currentState.validate()) {
      LoginRequestModel loginmodel = new LoginRequestModel(
          email: _textEditingControllerUsername.text,
          password: _textEditingControllerPassword.text);
      widget.onLogin(loginmodel);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(LoginForm oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            CustomInput(
              controller: _textEditingControllerUsername,
              icon: Icon(
                Icons.person,
                color: Colors.green,
              ),
              placeholder: "Username",
              validator: (value) {
                if (value != "") {
                  return null;
                }
                return "invalid username";
              },
            ),
            CustomInput(
              controller: _textEditingControllerPassword,
              icon: Icon(
                Icons.lock,
                color: Colors.blue,
              ),
              placeholder: "Password",
              isObscure: true,
              validator: (value) {
                if (value != "") {
                  return null;
                }
                return "invalid password";
              },
            ),
            SizedBox(
                width: double.infinity,
                child: Text(
                  "Forgot password",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                )),
            FullWidthButton(
              title: "Login",
              onPress: () => this.onFormSubmit(),
            ),
            SizedBox(
                width: double.infinity,
                child: Text(
                  "New User?",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                )),
            FullWidthButton(
              title: "Register",
              onPress: () => this.onFormSubmit(),
            ),
          ],
        ),
      )),
    );
  }
}
