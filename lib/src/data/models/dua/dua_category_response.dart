// To parse this JSON data, do
//
//     final duaCategoryResponse = duaCategoryResponseFromJson(jsonString);

import 'package:meta/meta.dart';
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
    required this.duaCatId,
    required this.duaCatName,
  });

  final String duaCatId;
  final String duaCatName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    duaCatId: json["duaCatID"] == null ? null : json["duaCatID"],
    duaCatName: json["duaCatName"] == null ? null : json["duaCatName"],
  );

  Map<String, dynamic> toJson() => {
    "duaCatID": duaCatId == null ? null : duaCatId,
    "duaCatName": duaCatName == null ? null : duaCatName,
  };
}
