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
  });

  final String notesId;

  factory DeleteNotesRequest.fromJson(Map<String, dynamic> json) => DeleteNotesRequest(
    notesId: json["notesID"] == null ? "" : json["notesID"],
  );

  Map<String, dynamic> toJson() => {
    "notesID": notesId == null ? null : notesId,
  };
}
