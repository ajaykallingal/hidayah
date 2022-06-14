
import 'package:flutter/material.dart';

import '../../../constants/font_family.dart';


Color mainThemeWhiteColor = Colors.white;
Color tabBarHeaderActiveTextColor = const Color(0xFFBE0000);
Color tabBarHeaderInactiveTextColor = const Color(0xFF747474);
Color tabBarContentSubTitleColor = const Color(0xFF5C5C5C).withOpacity(1.0);

TextStyle kQuranPageHeadlineTextStyle = TextStyle(
letterSpacing: 0,
fontFamily: FontFamily.sfProDisplay,
fontSize: 27,
color: mainThemeWhiteColor,
fontWeight: FontWeight.w600,
);
TextStyle kQuranScreenTabStyle = TextStyle(
  // decoration: TextDecoration.underline,
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 19,

  color: tabBarHeaderActiveTextColor,
  fontWeight: FontWeight.w500,
);
TextStyle kQuranPageTabHeaderStyle = TextStyle(
  // decoration: TextDecoration.underline,
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 16,

  color: tabBarHeaderActiveTextColor,
  // fontWeight: FontWeight.w600,
);
TextStyle kQuranPageTabContentTitleStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 16,

  color: Colors.black.withOpacity(1),
  fontWeight: FontWeight.w600,
);
TextStyle kQuranPageTabContentSubTitleStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 13,

  color: tabBarContentSubTitleColor,
  // fontWeight: FontWeight.w600,
);

TextStyle kQuranPageBoxTitleStyle1 = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 16,

  color: mainThemeWhiteColor,
  fontWeight: FontWeight.w700,
);

TextStyle kQuranPageBoxSubTitleStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 13,

  color: mainThemeWhiteColor,
  fontWeight: FontWeight.w500,
);

TextStyle kQuranPageBoxSubTitleStyle1 = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 12,

  color: mainThemeWhiteColor,
  fontWeight: FontWeight.w500,
);

TextStyle kQuranPageArabicTabStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.helveticaNeue,
  fontSize: 20,

  color: Colors.black.withOpacity(1),
  fontWeight: FontWeight.w400,
);
