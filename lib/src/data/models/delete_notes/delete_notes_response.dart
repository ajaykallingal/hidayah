// To parse this JSON data, do
//
//     final deleteNotesResponse = deleteNotesResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteNotesResponse deleteNotesResponseFromJson(String str) => DeleteNotesResponse.fromJson(json.decode(str));

String deleteNotesResponseToJson(DeleteNotesResponse data) => json.encode(data.toJson());

class DeleteNotesResponse {
  DeleteNotesResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final bool response;

  factory DeleteNotesResponse.fromJson(Map<String, dynamic> json) => DeleteNotesResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["Response"] == null ? null : json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "Response": response == null ? null : response,
  };
}
