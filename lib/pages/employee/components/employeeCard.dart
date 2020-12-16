import 'package:assetManagment/components/fullWidthButton.dart';
import 'package:assetManagment/components/infoRow.dart';
import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/models/employeeAssets.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeAssestsModel employee;
  final OnPress edit;
  final OnPress delete;
  const EmployeeCard({
    this.employee,
    this.edit,
    this.delete,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: InkWell(
          onTap: this.edit,
          onLongPress: this.delete,
          child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(employee.firstname + " " + employee.lastname,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 50,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Edit",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: this.edit,
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
                      label: "Email",
                      value: employee.email,
                    ),
                    InfoRow(
                      label: "Phone",
                      value: employee.mobile,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Assets",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 50,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Edit",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: this.edit,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      height: 4,
                      thickness: 2,
                      endIndent: 0,
                    ),
                    employee.assets != null
                        ? Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: [
                              ...employee.assets.map((a) => Chip(
                                  deleteIcon: Icon(Icons.close),
                                  label: Text(a.assetType + a.companyName)))
                            ],
                          )
                        : new Container(
                            child: Text("No Assets"),
                          )
                  ],
                ),
              )),
        ));
  }
}
