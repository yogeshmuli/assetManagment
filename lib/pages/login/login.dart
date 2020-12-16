import 'package:assetManagment/models/loginRequest.dart';
import 'package:assetManagment/pages/pageMixin.dart';
import 'package:assetManagment/providers/loginProvider.dart';
import 'package:assetManagment/services/responseHandler.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "./components/form.dart";
import "../../components/loadingIndicator.dart";

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PageMixin {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  onLogin(LoginRequestModel loginmodel) async {
    try {
      await Provider.of<LoginProvider>(context, listen: false)
          .login(loginmodel: loginmodel);
      Navigator.of(context).pushReplacementNamed("/mainapp");
    } on FbCustomException catch (e) {
      onCustomError(scafoldKey: this._scafoldKey, message: e.message);
    } catch (e) {
      onNetworkError(scafoldKey: this._scafoldKey, e: e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<LoginProvider>(context).loading;
    return Scaffold(
        key: this._scafoldKey,
        extendBodyBehindAppBar: true,
        body: Container(
          height: double.infinity,
          color: Theme.of(context).accentColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4),
                          bottomRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.4))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  color: Theme.of(context).accentColor,
                  child: Image(
                    height: 100,
                    image: AssetImage("assets/images/eteva_logo.png"),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                    ),
                    child: loading
                        ? LoadingIndicator(
                            loadingMessage: "Loading...",
                            color: Theme.of(context).primaryColor,
                          )
                        : LoginForm(
                            onLogin: onLogin,
                          )),
              ],
            ),
          ),
        ));
  }
}
