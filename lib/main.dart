import 'package:fgd_flutter/shared/route_generator.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/screens/splash_screen.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: AppColors.kcPrimaryColor,
      ),
      // home: const SplashScreen(),
      initialRoute: init,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
