import 'package:assetManagment/models/assets.dart';
import 'package:flutter/material.dart';
import '../components/assetsDetails.dart';

class AssetsEditPage extends StatelessWidget {
  final String title;
  final AssetsModel assetsModel;
  const AssetsEditPage({Key key, this.title, this.assetsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AssetsDetails(
      title: this.title,
      asset: this.assetsModel,
    );
  }
}
