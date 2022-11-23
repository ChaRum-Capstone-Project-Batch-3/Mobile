import 'dart:async';

import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: AppColors.kcPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/logo_splash.png'),
            ),
            SizedBox(height: 5),
            Text(
              'Charum',
              style: heading4Bold.copyWith(color: AppColors.kcBaseWhite)
            )
          ],
        ),
      ),
    );
  }
}
