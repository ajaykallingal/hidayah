// To parse this JSON data, do
//
//     final calendarDeleteEventRequest = calendarDeleteEventRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CalendarDeleteEventRequest calendarDeleteEventRequestFromJson(String str) => CalendarDeleteEventRequest.fromJson(json.decode(str));

String calendarDeleteEventRequestToJson(CalendarDeleteEventRequest data) => json.encode(data.toJson());

class CalendarDeleteEventRequest {
  CalendarDeleteEventRequest({
    required this.userId,
    required this.eventId,
  });

  final String userId;
  final String eventId;

  factory CalendarDeleteEventRequest.fromJson(Map<String, dynamic> json) => CalendarDeleteEventRequest(
    userId: json["UserID"] == null ? null : json["UserID"],
    eventId: json["EventID"] == null ? null : json["EventID"],
  );

  Map<String, dynamic> toJson() => {
    "UserID": userId == null ? null : userId,
    "EventID": eventId == null ? null : eventId,
  };
}
