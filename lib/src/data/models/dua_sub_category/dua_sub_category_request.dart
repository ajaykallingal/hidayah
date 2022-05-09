// To parse this JSON data, do
//
//     final duaSubCategoryRequest = duaSubCategoryRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DuaSubCategoryRequest duaSubCategoryRequestFromJson(String str) => DuaSubCategoryRequest.fromJson(json.decode(str));

String duaSubCategoryRequestToJson(DuaSubCategoryRequest data) => json.encode(data.toJson());

class DuaSubCategoryRequest {
  DuaSubCategoryRequest({
    required this.catId,
  });

  final String catId;

  factory DuaSubCategoryRequest.fromJson(Map<String, dynamic> json) => DuaSubCategoryRequest(
    catId: json["CatID"] == null ? null : json["CatID"],
  );

  Map<String, dynamic> toJson() => {
    "CatID": catId == null ? null : catId,
  };
}
