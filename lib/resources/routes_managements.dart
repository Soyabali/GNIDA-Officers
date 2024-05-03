import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/homeScreen.dart';
import '../screens/loginScreen_2.dart';
import '../screens/splacescreen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/loginRoute";
  static const String homePageRoute = "/homePage";

}
class RouteGenerator
{
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => Splace());
      case Routes.loginRoute:
       // initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginScreen_2());
      case Routes.homePageRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
       // next same route should be
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text("No route Fond"),
          ),
          body: Center(child: Text("No route Found")),
        ));
  }
}

