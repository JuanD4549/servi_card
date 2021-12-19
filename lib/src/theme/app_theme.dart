import 'package:flutter/material.dart';

class AppTheme {
  //AppTheme._();

  static final Color colorHighPriority = Colors.red;
  static final Color colorMediumPriority = Colors.yellow;
  static const Color colorLowPriority = Colors.green;

  static final TextTheme _textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 =
      TextStyle(fontFamily: 'Nexa', fontWeight: FontWeight.bold);

  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 =
      _headLine5.copyWith(fontFamily: 'Akrobat');
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool lightMode) {
    return ThemeData(
        textTheme: _textTheme,
        brightness: lightMode ? Brightness.light : Brightness.dark);
  }
}
