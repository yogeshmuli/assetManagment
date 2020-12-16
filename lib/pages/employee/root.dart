import 'package:assetManagment/components/routeComponents.dart';
import 'package:assetManagment/pages/employee/views/create.dart';
import 'package:assetManagment/pages/employee/views/edit.dart';
import "package:flutter/material.dart";
import 'views/home.dart';

class EmployeeRoot extends StatelessWidget {
  EmployeeRoot({Key key}) : super(key: key);
  final GlobalKey<NavigatorState> _navKey = new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navKey.currentState.canPop();
        print(_navKey.currentState.canPop());
        if (_navKey.currentState.canPop()) {
          _navKey.currentState.pop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: _navKey,
        initialRoute: "/",
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case "/":
              return MaterialPageRoute(
                builder: (context) => EmployeeHomePage(
                  title: "Employees",
                ),
              );
              break;
            case "/create":
              return MaterialPageRoute(
                builder: (context) => EmployeeCreatePage(
                  title: "Add Employee",
                ),
              );
              break;
            case "/edit":
              return ScaleRoute(
                page: EmployeeEditPage(
                  title: "Edit Employee",
                  employee: settings.arguments,
                ),
              );
              break;

            default:
              return MaterialPageRoute(
                builder: (context) => EmployeeHomePage(
                  title: "Employees",
                ),
              );
          }
        },
      ),
    );
  }
}
