import 'package:fgd_flutter/providers/search_thread_view_model.dart';
import 'package:fgd_flutter/screens/account/account_screen.dart';
import 'package:fgd_flutter/screens/follow_account/follow_account_screen.dart';
import 'package:fgd_flutter/screens/home/home_screen.dart';
import 'package:fgd_flutter/screens/onboarding/onboarding_screen.dart';
import 'package:fgd_flutter/screens/space/space_screen.dart';
import 'package:fgd_flutter/screens/thread_detail/thread_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fgd_flutter/providers/login_view_model.dart';
import 'package:fgd_flutter/providers/register_view_model.dart';
import 'package:fgd_flutter/screens/bookmark/bookmark_screen.dart';
import 'package:fgd_flutter/screens/create_thread/create_thread_screen.dart';
import 'package:fgd_flutter/screens/edit_account/edit_account_screen.dart';
import 'package:fgd_flutter/screens/main_screen/main_screen.dart';
import 'package:fgd_flutter/screens/splash/splash_screen.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/route_generator.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/shared/styles.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => SearchThreadViewModel())
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
      home: const MainScreen(),
    );
  }
}
