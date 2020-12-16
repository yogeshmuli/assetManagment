import 'package:assetManagment/models/employeeAssets.dart';
import 'package:flutter/material.dart';
import '../components/EmployeeDetails.dart';

class EmployeeEditPage extends StatelessWidget {
  final String title;
  final EmployeeAssestsModel employee;
  const EmployeeEditPage({Key key, this.title, this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmployeeDetails(
      title: this.title,
      employee: this.employee,
    );
  }
}
