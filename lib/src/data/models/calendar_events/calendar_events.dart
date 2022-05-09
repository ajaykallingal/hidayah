// To parse this JSON data, do
//
//     final calendarResponse = calendarResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CalendarResponse calendarResponseFromJson(String str) => CalendarResponse.fromJson(json.decode(str));

String calendarResponseToJson(CalendarResponse data) => json.encode(data.toJson());

class CalendarResponse {
  CalendarResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final List<ResponseOfCalendarEvents>? response;

  factory CalendarResponse.fromJson(Map<String, dynamic> json) => CalendarResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    response: json["Response"] == null ? null : List<ResponseOfCalendarEvents>.from(json["Response"].map((x) => ResponseOfCalendarEvents.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "Response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class ResponseOfCalendarEvents {
  ResponseOfCalendarEvents({
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.eventDescription,
  });

  final String eventId;
  final String eventDate;
  final String eventName;
  final String eventDescription;

  factory ResponseOfCalendarEvents.fromJson(Map<String, dynamic> json) => ResponseOfCalendarEvents(
    eventId: json["eventID"] == null ? null : json["eventID"],
    eventDate: json["eventDate"] == null ? null : json["eventDate"],
    eventName: json["eventName"] == null ? null : json["eventName"],
    eventDescription: json["eventDescription"] == null ? null : json["eventDescription"],
  );

  Map<String, dynamic> toJson() => {
    "eventID": eventId == null ? null : eventId,
    "eventDate": eventDate == null ? null : eventDate,
    "eventName": eventName == null ? null : eventName,
    "eventDescription": eventDescription == null ? null : eventDescription,
  };
}
