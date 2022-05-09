// To parse this JSON data, do
//
//     final loginWithEmailResponse = loginWithEmailResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PersonalDetailsResponse loginWithEmailResponseFromJson(String str) => PersonalDetailsResponse.fromJson(json.decode(str));

String loginWithEmailResponseToJson(PersonalDetailsResponse data) => json.encode(data.toJson());

class PersonalDetailsResponse {
  PersonalDetailsResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final Response response;

  factory PersonalDetailsResponse.fromJson(Map<String, dynamic> json) => PersonalDetailsResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["Response"] == null ? null : json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "Response": response == null ? null : response.toJson(),
  };
}

class Response {
  Response({
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
    required this.userCreatedAt,
  });

  final String userId;
  final String userEmail;
  final String userFullName;
  final String userPassword;
  final DateTime userDob;
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
  final DateTime userCreatedAt;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
    userCreatedAt: json["userCreatedAt"] == null ? null : json["userCreatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId == null ? null : userId,
    "userEmail": userEmail == null ? null : userEmail,
    "userFullName": userFullName == null ? null : userFullName,
    "userPassword": userPassword == null ? null : userPassword,
    "userDOB": userDob == null ? null : "${userDob.year.toString().padLeft(4, '0')}-${userDob.month.toString().padLeft(2, '0')}-${userDob.day.toString().padLeft(2, '0')}",
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
    "userCreatedAt": userCreatedAt == null ? null : userCreatedAt.toIso8601String(),
  };
}
