// To parse this JSON data, do
//
//     final newNotesResponse = newNotesResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewNotesResponse newNotesResponseFromJson(String str) => NewNotesResponse.fromJson(json.decode(str));

String newNotesResponseToJson(NewNotesResponse data) => json.encode(data.toJson());

class NewNotesResponse {
  NewNotesResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final int response;

  factory NewNotesResponse.fromJson(Map<String, dynamic> json) => NewNotesResponse(
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
