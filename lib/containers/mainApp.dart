import 'package:flutter/material.dart';
import '../pages/home/home.dart';
import '../pages/employee/root.dart';
import "../pages/assets/root.dart";
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

List menu = [
  {
    "name": "Home",
    "icon": Icon(
      Icons.dashboard,
      color: Colors.white,
    ),
    "activeIcon": Icon(
      Icons.dashboard,
      color: Colors.deepPurpleAccent[100],
    ),
    "page": "/home",
    "component": HomePage(
      title: "Home",
    ),
  },
  {
    "name": "Employee",
    "icon": Icon(
      Icons.people,
      color: Colors.white,
    ),
    "activeIcon": Icon(
      Icons.people,
      color: Colors.deepPurpleAccent[100],
    ),
    "page": "/employee",
    "component": EmployeeRoot()
  },
  {
    "name": "Assets",
    "icon": Icon(
      Icons.important_devices,
      color: Colors.white,
    ),
    "activeIcon": Icon(
      Icons.important_devices,
      color: Colors.deepPurpleAccent[100],
    ),
    "page": "/assets",
    "component": AssetsRoot()
  }
];

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;
  final List<Widget> tabs = [...menu.map((item) => item["component"]).toList()];

  onTap(int index) {
    this.setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          items: [
            ...menu.map(
              (item) => TabItem(
                  icon: item["icon"],
                  title: item['name'],
                  activeIcon: item["activeIcon"]),
            )
          ],
          initialActiveIndex: selectedIndex,
          onTap: onTap,
          backgroundColor: Theme.of(context).primaryColor,
          activeColor: Colors.white,
        )));
  }
}
