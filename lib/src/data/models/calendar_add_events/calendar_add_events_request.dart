// To parse this JSON data, do
//
//     final calendarAddEventRequest = calendarAddEventRequestFromJson(jsonString);

import 'dart:convert';

CalendarAddEventRequest calendarAddEventRequestFromJson(String str) => CalendarAddEventRequest.fromJson(json.decode(str));

String calendarAddEventRequestToJson(CalendarAddEventRequest data) => json.encode(data.toJson());

class CalendarAddEventRequest {
  CalendarAddEventRequest({
    required this.userId,
    required this.date,
    required this.name,
    required this.description,
    required this.eventID,
  });

  final String userId;
  final String date;
  final String name;
  final String description;
  final String eventID;

  factory CalendarAddEventRequest.fromJson(Map<String, dynamic> json) => CalendarAddEventRequest(
    userId: json["UserID"],
    date: json["Date"],
    name: json["Name"],
    description: json["Description"],
      eventID: json["EventID"],
  );

  Map<String, dynamic> toJson() => {
    "UserID": userId,
    "Date": date,
    "Name": name,
    "Description": description,
    "EventID": eventID,
  };
}
