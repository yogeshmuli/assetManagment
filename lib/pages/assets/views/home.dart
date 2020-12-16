import 'package:assetManagment/components/appBar.dart';
import 'package:assetManagment/components/infoRow.dart';
import 'package:assetManagment/components/loadingIndicator.dart';
import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/pages/pageMixin.dart';
import 'package:assetManagment/providers/assetsProvider.dart';
import 'package:assetManagment/services/responseHandler.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "../../../components/appBar.dart";

class AssetsHomePage extends StatefulWidget {
  final String title;
  AssetsHomePage({Key key, this.title}) : super(key: key);

  @override
  _AssetsHomePageState createState() => _AssetsHomePageState();
}

class _AssetsHomePageState extends State<AssetsHomePage> with PageMixin {
  GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getAllAssets();
  }

  getAllAssets() {
    Future.delayed(Duration(seconds: 0), () async {
      try {
        await Provider.of<AssetsProvider>(context, listen: false)
            .getAllAssets();
      } on UnauthorisedException catch (uae) {
        this.onUnauthorisedError(context: context, e: uae, rootNavigator: true);
      } catch (e) {
        onNetworkError(scafoldKey: this._scafoldKey, e: e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<AssetsProvider>(context).loading;
    List<AssetsModel> assetslist =
        Provider.of<AssetsProvider>(context).assetsList != null
            ? Provider.of<AssetsProvider>(context).assetsList
            : [];
    return Container(
      child: Scaffold(
        appBar: customAppBar(title: widget.title, context: context),
        body: loading && assetslist.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: LoadingIndicator(
                    loadingMessage: "Fetching...",
                    color: Theme.of(context).primaryColor,
                  )),
                ],
              )
            : Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...assetslist.map((asset) => Card(
                          elevation: 2,
                          child: InkWell(
                            child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              asset.companyName +
                                                  " " +
                                                  asset.assetType,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  child: FlatButton(
                                                    padding: EdgeInsets.all(0),
                                                    child: Text(
                                                      "Edit",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed("/edit",
                                                              arguments: asset)
                                                          .then((value) {
                                                        if (value == "edited") {
                                                          this.getAllAssets();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                asset.assetStatus ==
                                                        "Not allocated"
                                                    ? SizedBox(
                                                        width: 70,
                                                        child: FlatButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Text(
                                                            "Allocate",
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    "/allocate",
                                                                    arguments:
                                                                        asset)
                                                                .then((value) {
                                                              if (value ==
                                                                  "allocated") {
                                                                this.getAllAssets();
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    : new Container(
                                                        width: 0, height: 0)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Theme.of(context).primaryColor,
                                        height: 4,
                                        thickness: 2,
                                        endIndent: 0,
                                      ),
                                      InfoRow(
                                        label: "Color",
                                        value: asset.color,
                                      ),
                                      InfoRow(
                                        label: "Price",
                                        value: asset.price.toString(),
                                      ),
                                      InfoRow(
                                        label: "Status",
                                        value: asset.assetStatus,
                                      )
                                    ],
                                  ),
                                )),
                          )))
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pushNamed(context, '/create').then((value) {
              if (value == "added") {
                this.getAllAssets();
              }
            });
          },
        ),
      ),
    );
  }
}
