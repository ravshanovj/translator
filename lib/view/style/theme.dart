import 'package:flutter/material.dart';
import 'package:translate_app/view/style/style.dart';

abstract class ThemeStyle {
  ThemeStyle._();

  static ThemeData? lightTheme = ThemeData(
      primaryColor: const Color(0xffFCFCFC),
      hintColor: const Color(0xffFCFCFC),
      primaryColorDark: const Color(0xff151515),
      cardColor: const Color(0xffB5B5B5),
      secondaryHeaderColor: Style.textLightColor,
      textTheme: TextTheme(
        displayLarge: Style.textStyleBold(textColor: Style.textLightColor),
        displayMedium: Style.textStyleSemiBold(textColor: Style.textLightColor),
        displaySmall: Style.textStyleNormal(textColor: Style.textLightColor),
        headlineMedium: Style.textStyleRegular(textColor: Style.textLightColor),
        headlineSmall: Style.textStyleThin(textColor: Style.textLightColor),
      ));

  static ThemeData? darkTheme = ThemeData(
      secondaryHeaderColor: Style.whiteColor,
      hintColor: const Color(0xff272732),
      primaryColorDark: const Color(0xff5F6172),
      primaryColor: const Color(0xff1D1D27),
      cardColor: const Color(0xff5F6172),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff24243D),
          iconTheme: IconThemeData(
            color: Style.whiteColor,
          )),
      textTheme: TextTheme(
        displayLarge: Style.textStyleBold(textColor: Style.whiteColor),
        displayMedium: Style.textStyleSemiBold(textColor: Style.whiteColor),
        displaySmall: Style.textStyleNormal(textColor: Style.whiteColor),
        headlineMedium: Style.textStyleRegular(textColor: Style.whiteColor),
        headlineSmall: Style.textStyleThin(textColor: Style.whiteColor),
      ));
}
