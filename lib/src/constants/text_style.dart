

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/font_family.dart';


Color lightGreyShadeForText = Color(0xFF9F9F9F).withOpacity(1.0);
Color mainRedShadeForText  = Color(0xffD10005).withOpacity(0.5);
Color mainRedShadeForTitle = Color(0xffD10005).withOpacity(1.0);
Color shadeForTextFieldBorder = Color(0xffD10005).withOpacity(0.2);



 TextStyle kFormFieldsTitleTextStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 22,
   color: mainRedShadeForTitle,
   fontWeight: FontWeight.w600,
);
TextStyle kSetDailyGoalTitle2 = TextStyle(
 fontFamily: FontFamily.sfProDisplay,
 fontSize: 16,
 color: lightGreyShadeForText,
 fontWeight: FontWeight.w300,
);
TextStyle kForgotPasswordTextStyle = TextStyle(
 letterSpacing: 0,
 fontFamily: FontFamily.ralewayRegular,
 fontSize: 13,
 color: lightGreyShadeForText,
 // fontWeight: FontWeight.w600,
);

TextStyle kDontHaveTextStyle = TextStyle(
letterSpacing: 0,
 fontFamily: FontFamily.ralewayRegular,
 fontSize: 14,
 color: lightGreyShadeForText,
 // fontWeight: FontWeight.w600,
);
TextStyle kSetGoalsTextStyle = TextStyle(
 fontFamily: FontFamily.sfProDisplay,
 fontSize: 12,
 color: Colors.black.withOpacity(0.59),
 fontWeight: FontWeight.w700,
);
TextStyle kPickFavTextStyle = TextStyle(
 fontFamily: FontFamily.sfProDisplay,
 fontSize: 12,
 color: Colors.black.withOpacity(0.59),
 fontWeight: FontWeight.w500,
);
