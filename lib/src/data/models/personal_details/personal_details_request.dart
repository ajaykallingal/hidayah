// To parse this JSON data, do
//
//     final personalDetailsRequest = personalDetailsRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PersonalDetailsRequest personalDetailsRequestFromJson(String str) => PersonalDetailsRequest.fromJson(json.decode(str));

String personalDetailsRequestToJson(PersonalDetailsRequest data) => json.encode(data.toJson());

class PersonalDetailsRequest {
  PersonalDetailsRequest({
    required this.userId,
    required this.userEmail,
    required this.userFullName,
    required this.userPassword,
    required this.userDob,
    required this.userSelectedLanguageId,
    required this.userGender,
    required this.userMaritialStatus,
    required this.userGoalPrayFive,
    required this.userGoalReadTwentyAyaDaily,
    required this.userGoalSayThreeDua,
    required this.userGoalPrayWitrNight,
    required this.userGoalGiveCharity,
    required this.userFavPrayerTime,
    required this.userFavQbila,
    required this.userFavNarMosque,
    required this.userFavQuran,
    required this.userFavDua,
    required this.userZakah,
  });

  final String userId;
  final String userEmail;
  final String userFullName;
  final String userPassword;
  final String userDob;
  final String userSelectedLanguageId;
  final String userGender;
  final String userMaritialStatus;
  final String userGoalPrayFive;
  final String userGoalReadTwentyAyaDaily;
  final String userGoalSayThreeDua;
  final String userGoalPrayWitrNight;
  final String userGoalGiveCharity;
  final String userFavPrayerTime;
  final String userFavQbila;
  final String userFavNarMosque;
  final String userFavQuran;
  final String userFavDua;
  final String userZakah;

  factory PersonalDetailsRequest.fromJson(Map<String, dynamic> json) => PersonalDetailsRequest(
    userId: json["userID"] == null ? null : json["userID"],
    userEmail: json["userEmail"] == null ? null : json["userEmail"],
    userFullName: json["userFullName"] == null ? null : json["userFullName"],
    userPassword: json["userPassword"] == null ? null : json["userPassword"],
    userDob: json["userDOB"] == null ? null : json["userDOB"],
    userSelectedLanguageId: json["userSelectedLanguageID"] == null ? null : json["userSelectedLanguageID"],
    userGender: json["userGender"] == null ? null : json["userGender"],
    userMaritialStatus: json["userMaritialStatus"] == null ? null : json["userMaritialStatus"],
    userGoalPrayFive: json["userGoalPrayFive"] == null ? null : json["userGoalPrayFive"],
    userGoalReadTwentyAyaDaily: json["userGoalReadTwentyAyaDaily"] == null ? null : json["userGoalReadTwentyAyaDaily"],
    userGoalSayThreeDua: json["userGoalSayThreeDua"] == null ? null : json["userGoalSayThreeDua"],
    userGoalPrayWitrNight: json["userGoalPrayWitrNight"] == null ? null : json["userGoalPrayWitrNight"],
    userGoalGiveCharity: json["userGoalGiveCharity"] == null ? null : json["userGoalGiveCharity"],
    userFavPrayerTime: json["userFavPrayerTime"] == null ? null : json["userFavPrayerTime"],
    userFavQbila: json["userFavQbila"] == null ? null : json["userFavQbila"],
    userFavNarMosque: json["userFavNarMosque"] == null ? null : json["userFavNarMosque"],
    userFavQuran: json["userFavQuran"] == null ? null : json["userFavQuran"],
    userFavDua: json["userFavDua"] == null ? null : json["userFavDua"],
    userZakah: json["userZakah"] == null ? null : json["userZakah"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId == null ? null : userId,
    "userEmail": userEmail == null ? null : userEmail,
    "userFullName": userFullName == null ? null : userFullName,
    "userPassword": userPassword == null ? null : userPassword,
    "userDOB": userDob == null ? null : userDob,
    "userSelectedLanguageID": userSelectedLanguageId == null ? null : userSelectedLanguageId,
    "userGender": userGender == null ? null : userGender,
    "userMaritialStatus": userMaritialStatus == null ? null : userMaritialStatus,
    "userGoalPrayFive": userGoalPrayFive == null ? null : userGoalPrayFive,
    "userGoalReadTwentyAyaDaily": userGoalReadTwentyAyaDaily == null ? null : userGoalReadTwentyAyaDaily,
    "userGoalSayThreeDua": userGoalSayThreeDua == null ? null : userGoalSayThreeDua,
    "userGoalPrayWitrNight": userGoalPrayWitrNight == null ? null : userGoalPrayWitrNight,
    "userGoalGiveCharity": userGoalGiveCharity == null ? null : userGoalGiveCharity,
    "userFavPrayerTime": userFavPrayerTime == null ? null : userFavPrayerTime,
    "userFavQbila": userFavQbila == null ? null : userFavQbila,
    "userFavNarMosque": userFavNarMosque == null ? null : userFavNarMosque,
    "userFavQuran": userFavQuran == null ? null : userFavQuran,
    "userFavDua": userFavDua == null ? null : userFavDua,
    "userZakah": userZakah == null ? null : userZakah,
  };
}
