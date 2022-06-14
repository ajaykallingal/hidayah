import 'package:flutter/material.dart';

import 'font_family.dart';

class AppTheme {
AppTheme._();

static const _scaffoldColor = Color(0xffE80000);
static const _scaffoldGradientColor = Color(0xff382424);
static const _iconColor = Color(0xffD10005);
static const _iconColorGradient = Color(0xff950205);
static const _secondaryIconColor = Color(0xffAC0307);
static const _lightPrimaryColor = Colors.black;
static const _lightPrimaryVariantColor = Color(0xffE9EAFE);
static const _lightAccentColor = Color(0xff9F9F9F);


static final ThemeData lightTheme = ThemeData(
  dividerColor: Colors.transparent,
  primaryColor: _lightPrimaryVariantColor,
  scaffoldBackgroundColor: _lightPrimaryVariantColor,

  appBarTheme: const AppBarTheme(
    color: _lightPrimaryVariantColor,
    iconTheme: IconThemeData(color: _iconColor),
  ),
  iconTheme: const IconThemeData(
    color: _iconColor,


  ),
  textTheme: _lightTextTheme,
  fontFamily: FontFamily.sfProDisplay,
  textSelectionTheme: const TextSelectionThemeData(cursorColor: _iconColor),
  colorScheme: const ColorScheme.light(
    primary: _lightPrimaryColor,
    // secondary: _lightSecondaryColor,
    onPrimary: _lightAccentColor).copyWith(secondary: _lightAccentColor,),
);


 static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeading1TextStyle,
    headline2: _lightScreenHeading2TextStyle,
    headline3: _lightScreenHeading3TextStyle,
    headline4: _lightScreenHeading4TextStyle,
    headline5: _lightScreenHeading5TextStyle,
    headline6: _lightScreenHeading6TextStyle,
    subtitle1: _lightScreenSubTitle1TextStyle,
    subtitle2: _lightScreenSubTitle2TextStyle,
    bodyText1: _lightScreenBody1TextStyle,
    bodyText2: _lightScreenBody2TextStyle,
    button: _lightScreenButtonTextStyle,
    caption: _lightScreenCaptionTextStyle,
    overline: _lightScreenOverLineTextStyle);

static const TextStyle _lightScreenHeading1TextStyle = TextStyle(
    fontSize: 96.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: -1.5,
    fontWeight: FontWeight.w300);
static const TextStyle _lightScreenHeading2TextStyle = TextStyle(
    fontSize: 60.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w300);
static const TextStyle _lightScreenHeading3TextStyle = TextStyle(
    fontSize: 48.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.0,
    fontWeight: FontWeight.w700);
static const TextStyle _lightScreenHeading4TextStyle = TextStyle(
    fontSize: 34.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400);
static const TextStyle _lightScreenHeading5TextStyle = TextStyle(
    fontSize: 24.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.0,
    fontWeight: FontWeight.w400);
static const TextStyle _lightScreenHeading6TextStyle = TextStyle(
    fontSize: 20.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w500);
static const TextStyle _lightScreenSubTitle1TextStyle = TextStyle(
    fontSize: 16.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w400);
static const TextStyle _lightScreenSubTitle2TextStyle = TextStyle(
    fontSize: 14.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500);
static const TextStyle _lightScreenBody1TextStyle = TextStyle(
    fontSize: 16.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w400);
static const TextStyle _lightScreenBody2TextStyle = TextStyle(
    fontSize: 14.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400);
static const TextStyle _lightScreenButtonTextStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.white,
    letterSpacing: 1.25,
    fontWeight: FontWeight.w500);
static const TextStyle _lightScreenCaptionTextStyle = TextStyle(
    fontSize: 12.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400);
static const TextStyle _lightScreenOverLineTextStyle = TextStyle(
    fontSize: 10.0,
    color: _lightPrimaryVariantColor,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w400);



}