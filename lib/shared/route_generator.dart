import 'package:fgd_flutter/screens/create_thread/create_thread_screen.dart';
import 'package:fgd_flutter/screens/detail_space/detail_space.dart';
import 'package:fgd_flutter/screens/edit_account/edit_account_screen.dart';
import 'package:fgd_flutter/screens/home/home_screen.dart';
import 'package:fgd_flutter/screens/main_screen/main_screen.dart';
import 'package:fgd_flutter/screens/notification/widget/notification_card.dart';
import 'package:fgd_flutter/screens/notification/widget/notification_empty.dart';
import 'package:fgd_flutter/screens/onboarding/onboarding_screen.dart';
import 'package:fgd_flutter/screens/register/regiester_screen.dart';
import 'package:fgd_flutter/screens/search/search_screen.dart';
import 'package:fgd_flutter/screens/thread_detail/thread_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/router.dart';

import '../screens/account/account_screen.dart';
import '../screens/following_screen.dart/following_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/thread_detail/thread_detail_screen.dart';

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
      case createThread:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => CreateThread());
      case boarding:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case home:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => MainScreen());
      case search:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case editAccount:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => EditAccountScreen());
      case notif:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => NotificationEmpty());

      case detailSpace:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => DetailSpace(topicId: args),
        );

      case detailThread:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ThreadDetailScreen(
                  id: args,
                ));

      case account:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => AccountScreen());
      case following:
        final args = settings.arguments;
        return MaterialPageRoute(builder: (context) => FollowingScreen());
     

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
