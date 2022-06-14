// To parse this JSON data, do
//
//     final duaDetailedRequest = duaDetailedRequestFromJson(jsonString);

import 'dart:convert';

DuaDetailedRequest duaDetailedRequestFromJson(String str) => DuaDetailedRequest.fromJson(json.decode(str));

String duaDetailedRequestToJson(DuaDetailedRequest data) => json.encode(data.toJson());

class DuaDetailedRequest {
  DuaDetailedRequest({
    required this.subCatId,
  });

  final String subCatId;

  factory DuaDetailedRequest.fromJson(Map<String, dynamic> json) => DuaDetailedRequest(
    subCatId: json["SubCatID"],
  );

  Map<String, dynamic> toJson() => {
    "SubCatID": subCatId,
  };
}
