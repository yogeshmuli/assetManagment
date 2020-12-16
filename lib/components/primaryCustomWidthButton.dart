import 'package:assetManagment/components/fullWidthButton.dart';
import 'package:flutter/material.dart';

class PrimaryCustomWidthButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color backgroundColor;
  final Color color;
  final double width;
  final OnPress onPress;

  const PrimaryCustomWidthButton(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.backgroundColor,
      @required this.color,
      @required this.width,
      @required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: this.backgroundColor,
        child: Row(
          children: <Widget>[
            this.icon,
            Text(
              this.title,
              style: TextStyle(color: this.color),
            )
          ],
        ),
        onPressed: this.onPress,
      ),
    );
  }
}