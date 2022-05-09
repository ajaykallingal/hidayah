// To parse this JSON data, do
//
//     final hadithOfTheDayResponse = hadithOfTheDayResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HadithOfTheDayResponse hadithOfTheDayResponseFromJson(String str) => HadithOfTheDayResponse.fromJson(json.decode(str));

String hadithOfTheDayResponseToJson(HadithOfTheDayResponse data) => json.encode(data.toJson());

class HadithOfTheDayResponse {
  HadithOfTheDayResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final Response? response;

  factory HadithOfTheDayResponse.fromJson(Map<String, dynamic> json) => HadithOfTheDayResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["Response"] == null ? null :  Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "Response": response == null ? null : response!.toJson(),
  };
}

class Response {
  Response({
    required this.id,
    required this.engAuth,
    required this.engBookName,
    required this.engText,
    required this.arAuth,
    required this.arBookName,
    required this.arText,
  });

  final String id;
  final String engAuth;
  final String engBookName;
  final String engText;
  final String arAuth;
  final String arBookName;
  final String arText;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"] == null ? null : json["id"],
    engAuth: json["eng_auth"] == null ? null : json["eng_auth"],
    engBookName: json["eng_bookName"] == null ? null : json["eng_bookName"],
    engText: json["eng_text"] == null ? null : json["eng_text"],
    arAuth: json["ar_auth"] == null ? null : json["ar_auth"],
    arBookName: json["ar_bookName"] == null ? null : json["ar_bookName"],
    arText: json["ar_text"] == null ? null : json["ar_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "eng_auth": engAuth == null ? null : engAuth,
    "eng_bookName": engBookName == null ? null : engBookName,
    "eng_text": engText == null ? null : engText,
    "ar_auth": arAuth == null ? null : arAuth,
    "ar_bookName": arBookName == null ? null : arBookName,
    "ar_text": arText == null ? null : arText,
  };
}
