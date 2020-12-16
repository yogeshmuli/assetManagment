import 'package:assetManagment/components/logoutButton.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({String title, BuildContext context}) {
  return AppBar(
    actions: <Widget>[LogoutButton()],
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    ),
  );
}
