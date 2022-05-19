

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hidayah/src/data/models/personal_details/personal_details_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/login/login_with_email_response.dart';

class Prefs{

  JsonCodec codec = const JsonCodec();
  SharedPreferences? _sharedPreferences;

  static const String? _IS_USER_LOADED = "is_user_loaded";
  static const String? _USER_ID = "user_id";
  static const String? _USER_DATA = "user_data";
  static const String? _IS_LOGGED_IN = "is_logged_in";
  static const String? _DHIKR_COUNT = "dhikr_count";


  Prefs();
  set sharedPreferences(SharedPreferences value){
    _sharedPreferences = value;
  }

  ///saving  the auth token as a String
  void setUserId({String? userId}) {
    _sharedPreferences!.setString(_USER_ID!, userId!);
  }

  ///get method  for auth token
  String? getUserId() => _sharedPreferences!.getString(_USER_ID!);

  ///after login set isLoggedIn true
  ///before logout set isLoggedIn false
  void setIsLoggedIn(bool status) {
    _sharedPreferences!.setBool(_IS_LOGGED_IN!, status);
  }

  ///checking that is logged in or not
  bool? isLoggedIn() => _sharedPreferences!.getBool(_IS_LOGGED_IN!) != null &&
      _sharedPreferences!.getBool(_IS_LOGGED_IN!) == true
      ? true
      : false;

  ///  save user data
  void saveUserData(LoginWithEmailResponse result) {
    String jsonString = jsonEncode(result);
    _sharedPreferences!.setString(_USER_DATA!, jsonString);
  }

  /// get user data
  LoginWithEmailResponse? getUserData() {
    Map<String, dynamic>? resultMap =
    jsonDecode(_sharedPreferences!.getString(_USER_DATA!)!);
    var result = new LoginWithEmailResponse.fromJson(resultMap!);
    return result;
  }

  /// for clearing the data in preference
  void clearPrefs() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  ///  save user dhikrcount
  void setUserDhikrCount({String? userDhikrCount}) {
    _sharedPreferences!.setString(_DHIKR_COUNT!, userDhikrCount!);
  }


}