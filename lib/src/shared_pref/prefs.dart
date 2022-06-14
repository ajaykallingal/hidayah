

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/login/login_with_email_response.dart';
import '../data/models/quran_request_response.dart';
import '../data/models/surah/surah_response.dart';

class Prefs{

  JsonCodec codec = const JsonCodec();
  SharedPreferences? _sharedPreferences;

  static const String? _IS_USER_LOADED = "is_user_loaded";
  static const String? _USER_ID = "user_id";
  static const String? _USER_DATA = "user_data";
  static const String? _IS_LOGGED_IN = "is_logged_in";
  static const String _DHIKR_COUNT = "dhikr_count";
  static const String _USER_LAST_READ_QURAN = "user_last_read_quran";

  // static const String _LASTREADSURAH = "last_read_surah";
  // static const String _LASTREADSURAHTRANSLATION = "last_read_suarah_trasnlation";
  // static const String _LASTREADSURAHVERSES = "last_read_surah_verses";
    // "last_read_surah_translation","last_read_surah_verses"



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
    var result = LoginWithEmailResponse.fromJson(resultMap!);
    return result;
  }

  /// for clearing the data in preference
  void clearPrefs() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  ///  save user dhikrcount
  void setUserDhikrCount({String? userDhikrCount}) {
    _sharedPreferences!.setString(_DHIKR_COUNT, userDhikrCount!);
  }

  ///get dhikr count
  String? getUserDhikrCount() => _sharedPreferences!.getString(_DHIKR_COUNT);

  // ///  save last read surah
  // void setLastReadSurah({String? lastReadSurah}) {
  //   _sharedPreferences!.setString(_LASTREADSURAH, lastReadSurah!);
  // }
  // ///get last read surah
  // String? getLastReadSurah() => _sharedPreferences!.getString(_LASTREADSURAH);
  //
  //
  // ///  save last read surah translation
  // void setLastReadSurahTranslation({String? lastReadSurahTranslation}) {
  //   _sharedPreferences!.setString(_LASTREADSURAHTRANSLATION, lastReadSurahTranslation!);
  // }
  // ///get last read surah translation
  // String? getLastReadSurahTranslation() => _sharedPreferences!.getString(_LASTREADSURAHTRANSLATION);
  //
  // ///  save last read surah verses
  // void setLastReadSurahVerses({String? lastReadSurahVerses}) {
  //   _sharedPreferences!.setString(_LASTREADSURAHVERSES, lastReadSurahVerses!);
  // }
  // ///get last read surah verses
  // String? getLastReadSurahVerses() => _sharedPreferences!.getString(_LASTREADSURAHVERSES);
  //



  void saveUserLastReadData(SurahResponse result) {
    String jsonString = jsonEncode(result);
    _sharedPreferences!.setString(_USER_LAST_READ_QURAN, jsonString);
  }

  /// get user data
  SurahResponse? getUserLastReadData() {
    if(_sharedPreferences!.getString(_USER_LAST_READ_QURAN)!=null) {
      Map<String, dynamic>? resultMap = jsonDecode(
          _sharedPreferences!.getString(_USER_LAST_READ_QURAN)!);
      var result = SurahResponse.fromJson(resultMap!);
      return result;
    }else {
      return null;
    }
  }


}