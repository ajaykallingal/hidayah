// To parse this JSON data, do
//
//     final registrationRequest = registrationRequestFromJson(jsonString);

import 'dart:convert';

RegistrationRequest registrationRequestFromJson(String str) => RegistrationRequest.fromJson(json.decode(str));

String registrationRequestToJson(RegistrationRequest data) => json.encode(data.toJson());

class RegistrationRequest {
  RegistrationRequest({
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

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) => RegistrationRequest(
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
  };
}
