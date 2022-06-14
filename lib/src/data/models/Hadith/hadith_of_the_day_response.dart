// To parse this JSON data, do
//
//     final hadithOfTheDayResponse = hadithOfTheDayResponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    response: json["Response"] == null ? null :  Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
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
    id: json["id"],
    engAuth: json["eng_auth"],
    engBookName: json["eng_bookName"],
    engText: json["eng_text"],
    arAuth: json["ar_auth"],
    arBookName: json["ar_bookName"],
    arText: json["ar_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eng_auth": engAuth,
    "eng_bookName": engBookName,
    "eng_text": engText,
    "ar_auth": arAuth,
    "ar_bookName": arBookName,
    "ar_text": arText,
  };
}
