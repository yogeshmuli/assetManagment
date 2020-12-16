import 'package:assetManagment/components/customFlatButton.dart';
import 'package:assetManagment/models/employeeAssets.dart';
import 'package:assetManagment/pages/pageMixin.dart';
import 'package:assetManagment/pages/employee/components/EmployeeCard.dart';
import 'package:assetManagment/providers/employeeProvider.dart';
import 'package:assetManagment/services/responseHandler.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "../../../components/loadingIndicator.dart";
import "../../../components/appBar.dart";

class EmployeeHomePage extends StatefulWidget {
  final String title;
  EmployeeHomePage({this.title});
  @override
  _EmployeeHomePageState createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> with PageMixin {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getAllEmployees();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  getAllEmployees() {
    Future.delayed(Duration(seconds: 0), () async {
      try {
        await Provider.of<EmployeeProvider>(context, listen: false)
            .getAllEmployee();
      } on UnauthorisedException catch (uae) {
        this.onUnauthorisedError(context: context, e: uae, rootNavigator: true);
      } catch (e) {
        onNetworkError(scafoldKey: this._scafoldKey, e: e);
      }
    });
  }

  gotoEdit(EmployeeAssestsModel employee) {
    Navigator.of(context).pushNamed("/edit", arguments: employee).then((value) {
      if (value == "edited") {
        this.getAllEmployees();
      }
    });
  }

  deleteEmployee(String id) async {
    try {
      await Provider.of<EmployeeProvider>(context, listen: false)
          .deleteEmployee(id);
      Future.delayed(Duration(seconds: 0), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    } on UnauthorisedException catch (uae) {
      this.onUnauthorisedError(context: context, e: uae);
    } catch (e) {
      onNetworkError(scafoldKey: this._scafoldKey, e: e);
    }
  }

  openDeleteAlert(BuildContext currentContext, String id) {
    showDialog(
        context: currentContext,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            actionsPadding: EdgeInsets.all(2),
            contentPadding: EdgeInsets.all(15),
            title: Text(
              "Are You Sure",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            content: Text("you want to delete employee?"),
            actions: <Widget>[
              CustomFlatButton(
                title: "Yes",
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPress: () {
                  this.deleteEmployee(id);
                },
              ),
              CustomFlatButton(
                title: "No",
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPress: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<EmployeeProvider>(context).loading;
    List<EmployeeAssestsModel> employeeList =
        Provider.of<EmployeeProvider>(context).employeeList;
    return (Scaffold(
      key: this._scafoldKey,
      appBar: customAppBar(title: widget.title, context: context),
      body: loading && employeeList.length == 0
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
              child: SingleChildScrollView(
                  child: employeeList != null
                      ? Column(
                          children: <Widget>[
                            ...employeeList.map((emp) => EmployeeCard(
                                  edit: () => this.gotoEdit(emp),
                                  delete: () =>
                                      this.openDeleteAlert(context, emp.id),
                                  employee: emp,
                                ))
                          ],
                        )
                      : null),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.person_add,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/create').then((value) {
            if (value == "added") {
              this.getAllEmployees();
            }
          });
        },
      ),
    ));
  }
}
