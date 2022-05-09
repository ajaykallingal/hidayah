// To parse this JSON data, do
//
//     final notesRequest = notesRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotesRequest notesRequestFromJson(String str) => NotesRequest.fromJson(json.decode(str));

String notesRequestToJson(NotesRequest data) => json.encode(data.toJson());

class NotesRequest {
  NotesRequest({
    required this.userId,
  });

  final String userId;

  factory NotesRequest.fromJson(Map<String, dynamic> json) => NotesRequest(
    userId: json["userID"] == null ? null : json["userID"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId == null ? null : userId,
  };
}
