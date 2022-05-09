import 'package:flutter/material.dart';


class Urls{
  Urls._();

  /// Base Url

  static const String baseUrl = "https://communiqo.com";
  static const String QuranUrl = "/test_api/hidayah_api/index.php/QuranCtrl/displayWholeQuranFiltered";
  static const String GetPrayerTimes = "/test_api/hidayah_api/index.php/TimeController/displayPrayerTimes";
  static const String GetDailyQuotes =  "/test_api/hidayah_api/index.php/QuotesCtrl/showDailyQuotes";
  static const String GetDailyVerses = "/test_api/hidayah_api/index.php/QuranCtrl/displayDailySurats/12";
  static const String LoginWithEmail = "/test_api/hidayah_api/index.php/UserController/loginUser";
  static const String RegistrationOfNewUser = "/test_api/hidayah_api/index.php/UserController/registerUser";
  static const String GetDuaCategory = "/test_api/hidayah_api/index.php/DuaController/getAllDuaCategories";
  static const String GetDuaSubCategory = "/test_api/hidayah_api/index.php/DuaController/getAllDuaSubCategories";
  static const String GetDuaDetailed = "/test_api/hidayah_api/index.php/DuaController/getAllDua";
  static const String GetHadith = "/test_api/hidayah_api/index.php/HadithController/getHadithOfTheDay";
  static const String PersonalDetails = "/test_api/hidayah_api/index.php/UserController/registerUser";
  static const String FetchUserNotes = "/test_api/hidayah_api/index.php/UserController/showNotes";
  static const String InsertNewNotes = "/test_api/hidayah_api/index.php/UserController/upsertNotes";
  static const String ShowAllDua = "/test_api/hidayah_api/index.php/DuaController/getAllDua";
  static const String YoutubeVideo = "/test_api/hidayah_api/index.php/UserController/showVideo";
  static const String CalendarEvents = "/test_api/hidayah_api/index.php/CalendarController/getUpcommingEvents";
  static const String DeleteNotes = "/test_api/hidayah_api/index.php/UserController/dropNotes";







}