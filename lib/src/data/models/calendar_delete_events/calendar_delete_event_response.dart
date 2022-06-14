// To parse this JSON data, do
//
//     final calendarDeleteEventResponse = calendarDeleteEventResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CalendarDeleteEventResponse calendarDeleteEventResponseFromJson(String str) => CalendarDeleteEventResponse.fromJson(json.decode(str));

String calendarDeleteEventResponseToJson(CalendarDeleteEventResponse data) => json.encode(data.toJson());

class CalendarDeleteEventResponse {
  CalendarDeleteEventResponse({
    required this.status,
    required this.message,
    required this.deleteResponse,
    required this.response,
  });

  final String status;
  final String message;
  final bool deleteResponse;
  final List<CalendarDeleteResponse>? response;

  factory CalendarDeleteEventResponse.fromJson(Map<String, dynamic> json) => CalendarDeleteEventResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    deleteResponse: json["DeleteResponse"] == null ? null : json["DeleteResponse"],
    response: json["Response"] == null ? null : List<CalendarDeleteResponse>.from(json["Response"].map((x) => CalendarDeleteResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "DeleteResponse": deleteResponse == null ? null : deleteResponse,
    "Response": response == null ? null : List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class CalendarDeleteResponse {
  CalendarDeleteResponse({
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.eventDescription,
  });

  final String eventId;
  final String eventDate;
  final String eventName;
  final String eventDescription;

  factory CalendarDeleteResponse.fromJson(Map<String, dynamic> json) => CalendarDeleteResponse(
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
