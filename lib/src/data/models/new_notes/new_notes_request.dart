// To parse this JSON data, do
//
//     final newNotesRequest = newNotesRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewNotesRequest newNotesRequestFromJson(String str) => NewNotesRequest.fromJson(json.decode(str));

String newNotesRequestToJson(NewNotesRequest data) => json.encode(data.toJson());

class NewNotesRequest {
  NewNotesRequest({
    required this.notesId,
    required this.userId,
    required this.notes,
  });

  final String notesId;
  final String userId;
  final String notes;

  factory NewNotesRequest.fromJson(Map<String, dynamic> json) => NewNotesRequest(
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
