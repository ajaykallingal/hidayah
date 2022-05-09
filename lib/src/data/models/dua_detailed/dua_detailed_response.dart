// To parse this JSON data, do
//
//     final duaDetailedResponse = duaDetailedResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DuaDetailedResponse duaDetailedResponseFromJson(String str) => DuaDetailedResponse.fromJson(json.decode(str));

String duaDetailedResponseToJson(DuaDetailedResponse data) => json.encode(data.toJson());

class DuaDetailedResponse {
  DuaDetailedResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final List<Response>? response;

  factory DuaDetailedResponse.fromJson(Map<String, dynamic> json) => DuaDetailedResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["Response"] == null ? null : List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "Response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    required this.duaId,
    required this.duaArabic,
    required this.duaEnTranslation,
    required this.duaTransliteration,
    required this.duaSubCatId,
    required this.duaSubCatName,
    required this.duaCatId,
    required this.duaCatName,
  });

  final String duaId;
  final String duaArabic;
  final String duaEnTranslation;
  final String duaTransliteration;
  final String duaSubCatId;
  final String duaSubCatName;
  final String duaCatId;
  final String duaCatName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    duaId: json["duaID"] == null ? null : json["duaID"],
    duaArabic: json["duaArabic"] == null ? null : json["duaArabic"],
    duaEnTranslation: json["duaEnTranslation"] == null ? null : json["duaEnTranslation"],
    duaTransliteration: json["duaTransliteration"] == null ? null : json["duaTransliteration"],
    duaSubCatId: json["duaSubCatID"] == null ? null : json["duaSubCatID"],
    duaSubCatName: json["duaSubCatName"] == null ? null : json["duaSubCatName"],
    duaCatId: json["duaCatID"] == null ? null : json["duaCatID"],
    duaCatName: json["duaCatName"] == null ? null : json["duaCatName"],
  );

  Map<String, dynamic> toJson() => {
    "duaID": duaId == null ? null : duaId,
    "duaArabic": duaArabic == null ? null : duaArabic,
    "duaEnTranslation": duaEnTranslation == null ? null : duaEnTranslation,
    "duaTransliteration": duaTransliteration == null ? null : duaTransliteration,
    "duaSubCatID": duaSubCatId == null ? null : duaSubCatId,
    "duaSubCatName": duaSubCatName == null ? null : duaSubCatName,
    "duaCatID": duaCatId == null ? null : duaCatId,
    "duaCatName": duaCatName == null ? null : duaCatName,
  };
}
