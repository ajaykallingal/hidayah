// To parse this JSON data, do
//
//     final showAllDuaRequest = showAllDuaRequestFromJson(jsonString);

import 'dart:convert';

ShowAllDuaRequest showAllDuaRequestFromJson(String str) => ShowAllDuaRequest.fromJson(json.decode(str));

String showAllDuaRequestToJson(ShowAllDuaRequest data) => json.encode(data.toJson());

class ShowAllDuaRequest {
  ShowAllDuaRequest({
    required this.subCatId,
  });

  final String subCatId;

  factory ShowAllDuaRequest.fromJson(Map<String, dynamic> json) => ShowAllDuaRequest(
    subCatId: json["SubCatID"],
  );

  Map<String, dynamic> toJson() => {
    "SubCatID": subCatId,
  };
}
