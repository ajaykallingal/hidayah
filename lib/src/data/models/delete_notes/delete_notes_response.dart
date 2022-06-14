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
  final List<Response>? response;

  factory DeleteNotesResponse.fromJson(Map<String, dynamic> json) => DeleteNotesResponse(
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
