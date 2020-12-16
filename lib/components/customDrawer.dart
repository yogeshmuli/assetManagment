import 'package:assetManagment/providers/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List menu = [
  {
    "name": "Home",
    "icon": Icon(
      Icons.home,
      color: Colors.green,
    ),
    "page": "/home"
  },
  {
    "name": "Employee",
    "icon": Icon(
      Icons.people,
      color: Colors.blue,
    ),
    "page": "/employee"
  }
];

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Image(
              height: 100,
              image: AssetImage("assets/images/spash_screen.png"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              padding: EdgeInsets.all(3),
              children: [
                ...menu.map((item) {
                  return MenuItem(
                    name: item["name"],
                    icon: item["icon"],
                    onPress: () {
                      Navigator.of(context).pushNamed(item["page"]);
                    },
                  );
                }).toList(),
                MenuItem(
                  name: "Logout",
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  onPress: () {
                    Provider.of<LoginProvider>(context, listen: false).logout();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login", (route) => false);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final Icon icon;
  final onPress;
  const MenuItem({
    this.name,
    this.icon,
    this.onPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Card(
            color: Theme.of(context).accentColor,
            child: InkWell(
              onTap: this.onPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      this.name,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
