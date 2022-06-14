// To parse this JSON data, do
//
//     final newNotesRequest = newNotesRequestFromJson(jsonString);

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
    notesId: json["notesID"],
    userId: json["userID"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "notesID": notesId,
    "userID": userId,
    "notes": notes,
  };
}
