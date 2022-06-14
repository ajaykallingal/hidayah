// To parse this JSON data, do
//
//     final notesResponse = notesResponseFromJson(jsonString);

import 'dart:convert';

NotesResponse notesResponseFromJson(String str) => NotesResponse.fromJson(json.decode(str));

String notesResponseToJson(NotesResponse data) => json.encode(data.toJson());

class NotesResponse {
  NotesResponse({
    required this.status,
    required this.message,
    required this.responseOfNotes,
  });

  final String status;
  final String message;
  final List<ResponseOfNote>? responseOfNotes;

  factory NotesResponse.fromJson(Map<String, dynamic> json) => NotesResponse(
    status: json["status"],
    message: json["message"],
    responseOfNotes: json["Response"] == null ? null : List<ResponseOfNote>.from(json["Response"].map((x) => ResponseOfNote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Response": responseOfNotes == null ? null : List<dynamic>.from(responseOfNotes!.map((x) => x.toJson())),
  };
}

class ResponseOfNote {
  ResponseOfNote({
    required this.notesId,
    required this.userId,
    required this.notes,
  });

  final String notesId;
  final String userId;
  final String notes;

  factory ResponseOfNote.fromJson(Map<String, dynamic> json) => ResponseOfNote(
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
