import 'package:flutter/material.dart';
import '../components/EmployeeDetails.dart';

class EmployeeCreatePage extends StatelessWidget {
  final String title;
  const EmployeeCreatePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmployeeDetails(title: this.title);
  }
}
