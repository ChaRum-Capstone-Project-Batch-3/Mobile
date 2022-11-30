import 'package:fgd_flutter/screens/register/regiester_screen.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/router.dart';

import '../screens/login/login_screen.dart';
import '../screens/splash/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case init:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case login:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case register:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      default:
        return _errorPage();
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("ERROR"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Page Not Found"),
        ),
      ),
    );
  }
}
