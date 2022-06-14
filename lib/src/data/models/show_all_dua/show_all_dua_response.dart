// To parse this JSON data, do
//
//     final showAllDuaResponse = showAllDuaResponseFromJson(jsonString);

import 'dart:convert';

ShowAllDuaResponse showAllDuaResponseFromJson(String str) => ShowAllDuaResponse.fromJson(json.decode(str));

String showAllDuaResponseToJson(ShowAllDuaResponse data) => json.encode(data.toJson());

class ShowAllDuaResponse {
  ShowAllDuaResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final List<Response>? response;

  factory ShowAllDuaResponse.fromJson(Map<String, dynamic> json) => ShowAllDuaResponse(
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
  final DuaCatName duaCatName;

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
    "duaCatName": duaCatName == null ? null : duaCatNameValues.reverse[duaCatName],
  };
}

enum DuaCatName { SLEEPING, TOILET, ABLUTION, MOSQUE, PRAYER, HOME, GARMENT, TRAVEL, FOOD }

final duaCatNameValues = EnumValues({
  "Ablution": DuaCatName.ABLUTION,
  "Food": DuaCatName.FOOD,
  "Garment": DuaCatName.GARMENT,
  "Home": DuaCatName.HOME,
  "Mosque": DuaCatName.MOSQUE,
  "Prayer": DuaCatName.PRAYER,
  "Sleeping": DuaCatName.SLEEPING,
  "Toilet": DuaCatName.TOILET,
  "Travel": DuaCatName.TRAVEL
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
