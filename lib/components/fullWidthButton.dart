import "package:flutter/material.dart";

typedef void OnPress();

class FullWidthButton extends StatelessWidget {
  final String title;
  final OnPress onPress;

  FullWidthButton({this.title, this.onPress});
  @override
  Widget build(BuildContext context) {
    return (SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            this.title,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: this.onPress,
        )));
  }
}
