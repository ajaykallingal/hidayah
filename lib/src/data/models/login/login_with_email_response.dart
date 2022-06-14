// To parse this JSON data, do
//
//     final loginWithEmailResponse = loginWithEmailResponseFromJson(jsonString);

import 'dart:convert';

LoginWithEmailResponse loginWithEmailResponseFromJson(String str) => LoginWithEmailResponse.fromJson(json.decode(str));

String loginWithEmailResponseToJson(LoginWithEmailResponse data) => json.encode(data.toJson());

class LoginWithEmailResponse {
  LoginWithEmailResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final LoginResponse? response;

  factory LoginWithEmailResponse.fromJson(Map<String, dynamic> json) => LoginWithEmailResponse(
    status: json["status"],
    message: json["message"],
    response: json["Response"] == null ? null : LoginResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Response": response == null ? null : response!.toJson(),
  };
}

class LoginResponse {
  LoginResponse({
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
  final String userCreatedAt;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
    "userDOB": userDob,
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
    "userCreatedAt": userCreatedAt,
  };
}
