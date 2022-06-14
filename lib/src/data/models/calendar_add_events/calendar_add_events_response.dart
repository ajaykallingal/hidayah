// To parse this JSON data, do
//
//     final calendarAddEventResponse = calendarAddEventResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CalendarAddEventResponse calendarAddEventResponseFromJson(String str) => CalendarAddEventResponse.fromJson(json.decode(str));

String calendarAddEventResponseToJson(CalendarAddEventResponse data) => json.encode(data.toJson());

class CalendarAddEventResponse {
  CalendarAddEventResponse({
    required this.status,
    required this.message,
    required this.addEventResponse,
  });

  final String status;
  final String message;
  final List<ResponseOfAddEvent>? addEventResponse;

  factory CalendarAddEventResponse.fromJson(Map<String, dynamic> json) => CalendarAddEventResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    addEventResponse: json["Response"] == null ? null : List<ResponseOfAddEvent>.from(json["Response"].map((x) => ResponseOfAddEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "Response": addEventResponse == null ? null : List<dynamic>.from(addEventResponse!.map((x) => x.toJson())),
  };
}

class ResponseOfAddEvent {
  ResponseOfAddEvent({
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.eventDescription,
  });

  final String eventId;
  final String eventDate;
  final String eventName;
  final String eventDescription;

  factory ResponseOfAddEvent.fromJson(Map<String, dynamic> json) => ResponseOfAddEvent(
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
