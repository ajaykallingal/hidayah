// To parse this JSON data, do
//
//     final calendarResponse = calendarResponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    response: json["Response"] == null ? null : List<ResponseOfCalendarEvents>.from(json["Response"].map((x) => ResponseOfCalendarEvents.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
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
    eventId: json["eventID"],
    eventDate: json["eventDate"],
    eventName: json["eventName"],
    eventDescription: json["eventDescription"],
  );

  Map<String, dynamic> toJson() => {
    "eventID": eventId,
    "eventDate": eventDate,
    "eventName": eventName,
    "eventDescription": eventDescription,
  };
}
