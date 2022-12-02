import 'package:flutter/material.dart';

class AppColors {
//PRIMARY COLOR
  static const MaterialColor? kcPrimaryColor = const MaterialColor(
    0xff178066,
    const <int, Color>{
      50: const Color(0xffCFF8DE),
      100: const Color(0xffCFF8DE),
      200: const Color(0xffCFF8DE),
      300: const Color(0xff6ED8A9),
      400: const Color(0xff44B28C),
      500: const Color(0xff178066),
      600: const Color(0xff178066),
      700: const Color(0xff0B5C57),
      800: const Color(0xff07474A),
      900: const Color(0xff04353D),
    },
  );

//SUCCESS COLOR
  static const MaterialColor kcSuccessColor = const MaterialColor(
    0xff45A31D,
    const <int, Color>{
      50: const Color(0xffE8FAD1),
      100: const Color(0xffE8FAD1),
      200: const Color(0xffE8FAD1),
      300: const Color(0xffA3E373),
      400: const Color(0xff79C74C),
      500: const Color(0xff45A31D),
      600: const Color(0xff45A31D),
      700: const Color(0xff1F750E),
      800: const Color(0xff115E09),
      900: const Color(0xff074E05)
    },
  );

//INFO COLOR
  static const MaterialColor kcInfoColor = const MaterialColor(
    0xff0074C1,
    const <int, Color>{
      50: const Color(0xffC9F3FB),
      100: const Color(0xffC9F3FB),
      200: const Color(0xffC9F3FB),
      300: const Color(0xff5EC4EC),
      400: const Color(0xff36A2D9),
      500: const Color(0xff0074C1),
      600: const Color(0xff0074C1),
      700: const Color(0xff008EBB),
      800: const Color(0xff002F6F),
      900: const Color(0xff00215C)
    },
  );

//WARNING COLOR
  static const MaterialColor kcWarningColor = const MaterialColor(
    0xffEFB700,
    const <int, Color>{
      50: const Color(0xffFEF7CB),
      100: const Color(0xffFEF7CB),
      200: const Color(0xffFEF7CB),
      300: const Color(0xffFADE64),
      400: const Color(0xffF5CE3D),
      500: const Color(0xffEFB700),
      600: const Color(0xffEFB700),
      700: const Color(0xffAC7B00),
      800: const Color(0xff8A6000),
      900: const Color(0xff724C00)
    },
  );

//DANGER COLOR
  static const MaterialColor kcDangerColor = const MaterialColor(
    0xffD82986,
    const <int, Color>{
      50: const Color(0xffFDD4D9),
      100: const Color(0xffFDD4D9),
      200: const Color(0xffFDD4D9),
      300: const Color(0xffF37DA4),
      400: const Color(0xffE75A97),
      500: const Color(0xffD82986),
      600: const Color(0xffD82986),
      700: const Color(0xff9B1477),
      800: const Color(0xff7D0D6A),
      900: const Color(0xff670761)
    },
  );

//White
  static const Color kcBaseWhite = const Color(0xffFDFDFD);
  static const Color kcDarkWhite = const Color(0xffF4F4F4);
  static const Color kcDarkerWhite = const Color(0xffE3E3E3);
  static const Color kcDarkestWhite = const Color(0xffC7C7C7);

//BLACK
  static const Color kcBaseBlack = const Color(0xff222222);
  static const Color kcLightBlack = const Color(0xff403F3F);
  static const Color kcLighterBlack = const Color(0xff5C5C5C);
  static const Color kcLightestBlack = const Color(0xff818181);
}
