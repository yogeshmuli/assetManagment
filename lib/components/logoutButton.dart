import 'package:assetManagment/components/customFlatButton.dart';
import 'package:assetManagment/helpers/helpers.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  showLogoutConfirmationModal(BuildContext currentContext) {
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
            content: Text("you want to logout?"),
            actions: <Widget>[
              CustomFlatButton(
                title: "Yes",
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPress: () {
                  logout(currentContext);
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
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () => this.showLogoutConfirmationModal(context),
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
      ),
    );
  }
}
