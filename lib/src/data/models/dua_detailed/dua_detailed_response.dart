// To parse this JSON data, do
//
//     final duaDetailedResponse = duaDetailedResponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    response: json["Response"] == null ? null : List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
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
    duaId: json["duaID"],
    duaArabic: json["duaArabic"],
    duaEnTranslation: json["duaEnTranslation"],
    duaTransliteration: json["duaTransliteration"],
    duaSubCatId: json["duaSubCatID"],
    duaSubCatName: json["duaSubCatName"],
    duaCatId: json["duaCatID"],
    duaCatName: json["duaCatName"],
  );

  Map<String, dynamic> toJson() => {
    "duaID": duaId,
    "duaArabic": duaArabic,
    "duaEnTranslation": duaEnTranslation,
    "duaTransliteration": duaTransliteration,
    "duaSubCatID": duaSubCatId,
    "duaSubCatName": duaSubCatName,
    "duaCatID": duaCatId,
    "duaCatName": duaCatName,
  };
}
