import 'package:assetManagment/components/routeComponents.dart';
import 'package:assetManagment/pages/assets/views/create.dart';
import 'package:assetManagment/pages/assets/views/edit.dart';
import 'package:assetManagment/pages/assets/views/home.dart';
import 'package:assetManagment/pages/assets/views/allocate.dart';
import 'package:flutter/material.dart';

class AssetsRoot extends StatelessWidget {
  AssetsRoot({Key key}) : super(key: key);
  final GlobalKey<NavigatorState> _navKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
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
          onGenerateRoute: (setting) {
            switch (setting.name) {
              case "/":
                return MaterialPageRoute(
                    builder: (context) => AssetsHomePage(title: "Assets"));
                break;
              case "/create":
                return MaterialPageRoute(
                    builder: (context) =>
                        AssetsCreatePage(title: "Create Asset"));
                break;
              case "/edit":
                return ScaleRoute(
                  page: AssetsEditPage(
                    title: "Edit Assets",
                    assetsModel: setting.arguments,
                  ),
                );
                break;
              case "/allocate":
                return MaterialPageRoute(
                    builder: (context) => AllocateAssetPage(
                          title: "Allocate",
                          asset: setting.arguments,
                        ));
                break;
              default:
                return MaterialPageRoute(
                    builder: (context) => AssetsHomePage(title: "Assets"));
            }
          },
        ),
      ),
    );
  }
}
