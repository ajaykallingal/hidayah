// To parse this JSON data, do
//
//     final duaCategoryResponse = duaCategoryResponseFromJson(jsonString);

import 'dart:convert';

DuaCategoryResponse duaCategoryResponseFromJson(String str) => DuaCategoryResponse.fromJson(json.decode(str));

String duaCategoryResponseToJson(DuaCategoryResponse data) => json.encode(data.toJson());

class DuaCategoryResponse {
  DuaCategoryResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final List<Response>? response;

  factory DuaCategoryResponse.fromJson(Map<String, dynamic> json) => DuaCategoryResponse(
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
    required this.duaCatId,
    required this.duaCatName,
  });

  final String duaCatId;
  final String duaCatName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    duaCatId: json["duaCatID"],
    duaCatName: json["duaCatName"],
  );

  Map<String, dynamic> toJson() => {
    "duaCatID": duaCatId,
    "duaCatName": duaCatName,
  };
}
