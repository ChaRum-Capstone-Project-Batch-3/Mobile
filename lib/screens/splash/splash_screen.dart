import 'dart:async';

import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/local_storage.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void checkLogin(context) async {
    var utils = LocalStorage();

    Future<bool> isLogin = utils.getBool("isLogin");

    await isLogin.whenComplete(() async {
      await isLogin.then((value) async {
        if (!value) {
          var hasBoard = utils.getBool("hasBoard");
          await hasBoard.whenComplete(() async {
            await hasBoard.then((val) {
              if (val) {
                Navigator.pushNamedAndRemoveUntil(
                    context, login, (route) => false);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, boarding, (route) => false);
              }
            });
          });
        } else {
          Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      checkLogin(context);
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
            Text('Charum',
                style: heading4Bold.copyWith(color: AppColors.kcBaseWhite))
          ],
        ),
      ),
    );
  }
}
