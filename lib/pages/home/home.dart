import 'package:assetManagment/pages/pageMixin.dart';
import 'package:flutter/material.dart';
import "../../components/appBar.dart";

class HomePage extends StatefulWidget {
  final String title;
  HomePage({this.title});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  // ignore: unused_field
  final _scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

// ignore: missing_return

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.checkAuthStatus(context: context, rootNavigator: true);
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: customAppBar(title: widget.title, context: context),
    ));
  }
}
