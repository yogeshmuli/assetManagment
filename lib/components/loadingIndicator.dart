import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final String loadingMessage;
  final Color color;
  const LoadingIndicator(
      {Key key, @required this.loadingMessage, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Theme(
                data: ThemeData(accentColor: color),
                child: SpinKitRipple(
                  color: color,
                  size: 100,
                  duration: Duration(seconds: 2),
                ))),
        // Text(this.loadingMessage,style: TextStyle(color: color,))
      ],
    );
  }
}
