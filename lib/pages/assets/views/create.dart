import 'package:flutter/material.dart';
import '../components/assetsDetails.dart';

class AssetsCreatePage extends StatelessWidget {
  final String title;
  const AssetsCreatePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AssetsDetails(
      title: this.title,
    );
  }
}
