// To parse this JSON data, do
//
//     final deleteNotesRequest = deleteNotesRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteNotesRequest deleteNotesRequestFromJson(String str) => DeleteNotesRequest.fromJson(json.decode(str));

String deleteNotesRequestToJson(DeleteNotesRequest data) => json.encode(data.toJson());

class DeleteNotesRequest {
  DeleteNotesRequest({
    required this.notesId,
    required this.userId,
  });

  final String notesId;
  final String userId;

  factory DeleteNotesRequest.fromJson(Map<String, dynamic> json) => DeleteNotesRequest(
    notesId: json["notesID"] == null ? null : json["notesID"],
    userId: json["userID"] == null ? null : json["userID"],
  );

  Map<String, dynamic> toJson() => {
    "notesID": notesId == null ? null : notesId,
    "userID": userId == null ? null : userId,
  };
}
