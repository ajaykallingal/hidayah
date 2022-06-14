// To parse this JSON data, do
//
//     final loginWithEmailResponse = loginWithEmailResponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    response: json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
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
    userId: json["userID"],
    userEmail: json["userEmail"],
    userFullName: json["userFullName"],
    userPassword: json["userPassword"],
    userDob: json["userDOB"],
    userSelectedLanguageId: json["userSelectedLanguageID"],
    userGender: json["userGender"],
    userMaritialStatus: json["userMaritialStatus"],
    userGoalPrayFive: json["userGoalPrayFive"],
    userGoalReadTwentyAyaDaily: json["userGoalReadTwentyAyaDaily"],
    userGoalSayThreeDua: json["userGoalSayThreeDua"],
    userGoalPrayWitrNight: json["userGoalPrayWitrNight"],
    userGoalGiveCharity: json["userGoalGiveCharity"],
    userFavPrayerTime: json["userFavPrayerTime"],
    userFavQbila: json["userFavQbila"],
    userFavNarMosque: json["userFavNarMosque"],
    userFavQuran: json["userFavQuran"],
    userFavDua: json["userFavDua"],
    userZakah: json["userZakah"],
    userCreatedAt: json["userCreatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "userEmail": userEmail,
    "userFullName": userFullName,
    "userPassword": userPassword,
    "userDOB": userDob == null ? null : "${userDob.year.toString().padLeft(4, '0')}-${userDob.month.toString().padLeft(2, '0')}-${userDob.day.toString().padLeft(2, '0')}",
    "userSelectedLanguageID": userSelectedLanguageId,
    "userGender": userGender,
    "userMaritialStatus": userMaritialStatus,
    "userGoalPrayFive": userGoalPrayFive,
    "userGoalReadTwentyAyaDaily": userGoalReadTwentyAyaDaily,
    "userGoalSayThreeDua": userGoalSayThreeDua,
    "userGoalPrayWitrNight": userGoalPrayWitrNight,
    "userGoalGiveCharity": userGoalGiveCharity,
    "userFavPrayerTime": userFavPrayerTime,
    "userFavQbila": userFavQbila,
    "userFavNarMosque": userFavNarMosque,
    "userFavQuran": userFavQuran,
    "userFavDua": userFavDua,
    "userZakah": userZakah,
    "userCreatedAt": userCreatedAt == null ? null : userCreatedAt.toIso8601String(),
  };
}
