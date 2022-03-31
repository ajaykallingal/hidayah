import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constants/font_family.dart';
import '../../home/textStyle/text_style.dart';
import 'package:flutter/material.dart';


Color mainThemeWhiteColor = Colors.white;
Color tabBarHeaderActiveTextColor = Color(0xFFBE0000);
Color tabBarHeaderInactiveTextColor = Color(0xFF747474);
Color tabBarContentSubTitleColor = Color(0xFF5C5C5C).withOpacity(1.0);

TextStyle kQuranPageHeadlineTextStyle = TextStyle(
letterSpacing: 0,
fontFamily: FontFamily.sfProDisplay,
fontSize: 27,
color: mainThemeWhiteColor,
fontWeight: FontWeight.w600,
);
TextStyle kQuranPageTabHeaderStyle = TextStyle(
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