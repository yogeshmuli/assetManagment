import 'package:assetManagment/components/appBar.dart';
import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/models/employeeAssets.dart';
import 'package:assetManagment/pages/pageMixin.dart';
import 'package:assetManagment/providers/employeeProvider.dart';
import 'package:assetManagment/services/responseHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllocateAssetPage extends StatefulWidget {
  final String title;
  final AssetsModel asset;

  AllocateAssetPage({Key key, this.title, this.asset}) : super(key: key);

  @override
  _AllocateAssetPageState createState() => _AllocateAssetPageState();
}

class _AllocateAssetPageState extends State<AllocateAssetPage> with PageMixin {
  final _scafoldKey = new GlobalKey<ScaffoldState>();
  allocate(EmployeeAssestsModel employee, AssetsModel asset) async {
    try {
      await Provider.of<EmployeeProvider>(context, listen: false)
          .allocateAssetToEmployee(employee, asset);
      Future.delayed(Duration(seconds: 0), () {
        Navigator.of(context).pop("allocated");
      });
    } on UnauthorisedException catch (uae) {
      this.onUnauthorisedError(context: context, e: uae);
    } catch (e) {
      onNetworkError(scafoldKey: this._scafoldKey, e: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: widget.title, context: context),
      body: Column(
        children: [
          // Container(
          //   child: Text(
          //       "Select employee to allocate ${widget.asset.companyName + " " + widget.asset.assetType}",
          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ...Provider.of<EmployeeProvider>(context).employeeList.map((e) {
                  return Card(
                      child: ListTile(
                    onTap: () {
                      this.allocate(e, widget.asset);
                    },
                    title: Text(
                      e.firstname + " " + e.lastname,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ));
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
