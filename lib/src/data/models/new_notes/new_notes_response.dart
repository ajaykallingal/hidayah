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
  final List<Response>? response;

  factory NewNotesResponse.fromJson(Map<String, dynamic> json) => NewNotesResponse(
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
    required this.notesId,
    required this.userId,
    required this.notes,
  });

  final String notesId;
  final String userId;
  final String notes;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    notesId: json["notesID"] == null ? null : json["notesID"],
    userId: json["userID"] == null ? null : json["userID"],
    notes: json["notes"] == null ? null : json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "notesID": notesId == null ? null : notesId,
    "userID": userId == null ? null : userId,
    "notes": notes == null ? null : notes,
  };
}
