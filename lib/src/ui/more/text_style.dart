import 'package:flutter/material.dart';

import '../../constants/font_family.dart';


Color mainThemeWhiteColor = Colors.white;
Color tabBarHeaderActiveTextColor = Color(0xFFBE0000);
Color dividerColor = Color(0xFF707070);
Color moreListTileImageColor = Color(0xFF810000).withOpacity(1.0);



TextStyle kMoreScreenHeaderStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 27  ,
  color: mainThemeWhiteColor,
  fontWeight: FontWeight.w600,
);
TextStyle kMoreScreenListTileTitleStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14 ,
  color: Colors.black.withOpacity(0.59),
  fontWeight: FontWeight.w500,
);
TextStyle kMoreScreenListTileSubTitleStyle = TextStyle(
  letterSpacing: 0,
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 12 ,
  color: Colors.black.withOpacity(0.23),
  fontWeight: FontWeight.w500,
);
