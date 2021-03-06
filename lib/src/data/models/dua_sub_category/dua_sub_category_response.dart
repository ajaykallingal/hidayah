// To parse this JSON data, do
//
//     final duaSubCategoryResponse = duaSubCategoryResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DuaSubCategoryResponse duaSubCategoryResponseFromJson(String str) => DuaSubCategoryResponse.fromJson(json.decode(str));

String duaSubCategoryResponseToJson(DuaSubCategoryResponse data) => json.encode(data.toJson());

class DuaSubCategoryResponse {
  DuaSubCategoryResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final List<Response>? response;

  factory DuaSubCategoryResponse.fromJson(Map<String, dynamic> json) => DuaSubCategoryResponse(
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
    required this.duaSubCatId,
    required this.duaSubCatName,
    required this.duaCatId,
    required this.duaCatName,
  });

  final String duaSubCatId;
  final String duaSubCatName;
  final String duaCatId;
  final String duaCatName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    duaSubCatId: json["duaSubCatID"] == null ? null : json["duaSubCatID"],
    duaSubCatName: json["duaSubCatName"] == null ? null : json["duaSubCatName"],
    duaCatId: json["duaCatID"] == null ? null : json["duaCatID"],
    duaCatName: json["duaCatName"] == null ? null : json["duaCatName"],
  );

  Map<String, dynamic> toJson() => {
    "duaSubCatID": duaSubCatId == null ? null : duaSubCatId,
    "duaSubCatName": duaSubCatName == null ? null : duaSubCatName,
    "duaCatID": duaCatId == null ? null : duaCatId,
    "duaCatName": duaCatName == null ? null : duaCatName,
  };
}
