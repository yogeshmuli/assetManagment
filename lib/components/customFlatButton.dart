import 'package:assetManagment/components/fullWidthButton.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final OnPress onPress;
  CustomFlatButton({
    this.icon,
    this.title,
    this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        child: Row(
          children: <Widget>[
            this.icon,
            Text(
              this.title,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      onPressed: this.onPress,
    );
  }
}
