import 'package:fgd_flutter/providers/bookmark_view_model.dart';
import 'package:fgd_flutter/providers/comment_view_model.dart';
import 'package:fgd_flutter/providers/get_alltopics_view_model.dart';
import 'package:fgd_flutter/providers/get_thread_user_view_model.dart';
import 'package:fgd_flutter/providers/create_thread_view_model.dart';
import 'package:fgd_flutter/providers/search_thread_view_model.dart';
import 'package:fgd_flutter/providers/thread_detail_view_model.dart';
import 'package:fgd_flutter/screens/thread_detail/thread_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fgd_flutter/providers/login_view_model.dart';
import 'package:fgd_flutter/providers/register_view_model.dart';
import 'package:fgd_flutter/screens/splash/splash_screen.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/route_generator.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/shared/styles.dart';

import 'providers/get_user_view_model.dart';
import 'providers/home_thread_view_model.dart';
import 'providers/update_user_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => SearchThreadViewModel()),
        ChangeNotifierProvider(create: (context) => GetUserViewModel()),
        ChangeNotifierProvider(create: (context) => UpdateUserViewModel()),
        ChangeNotifierProvider(create: (context) => CommentViewModel()),
        ChangeNotifierProvider(create: (context) => GetThreadUserViewModel()),
        ChangeNotifierProvider(create: (context) => BookmarkViewModel()),
        ChangeNotifierProvider(create: (context) => ThreadDetailViewModel()),
        ChangeNotifierProvider(create: (context) => AllTopicsViewModel()),
        ChangeNotifierProvider(create: (context) => CreateThreadViewModel()),
        ChangeNotifierProvider(create: (context) => HomeThreadViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.kcPrimaryColor;
    final whiteColor = AppColors.kcBaseWhite;
    return MaterialApp(
        title: 'Charum Apps',
        initialRoute: init,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            unselectedLabelStyle: captionBold,
            selectedLabelStyle: captionBold,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryColor,
            unselectedItemColor: Color(0xffbebebe),
          ),
          textTheme: GoogleFonts.robotoTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              elevation: MaterialStateProperty.all(0.0),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              foregroundColor: MaterialStateProperty.all(whiteColor),
            ),
          ),
          primarySwatch: primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
