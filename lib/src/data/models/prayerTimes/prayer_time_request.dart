// To parse this JSON data, do
//
//     final getPrayerTimesRequest = getPrayerTimesRequestFromJson(jsonString);

import 'dart:convert';

GetPrayerTimesRequest getPrayerTimesRequestFromJson(String str) => GetPrayerTimesRequest.fromJson(json.decode(str));

String getPrayerTimesRequestToJson(GetPrayerTimesRequest data) => json.encode(data.toJson());

class GetPrayerTimesRequest {
  GetPrayerTimesRequest({
    required this.year,
    required this.month,
    required this.method,
    required this.lat,
    required this.long,
    required this.day,
  });

  final String year;
  final String month;
  final String method;
  final String lat;
  final String long;
  final String day;

  factory GetPrayerTimesRequest.fromJson(Map<String, dynamic> json) => GetPrayerTimesRequest(
    year: json["Year"],
    month: json["Month"],
    method: json["Method"],
    lat: json["Lat"],
    long: json["Long"],
    day: json["Day"],
  );

  Map<String, dynamic> toJson() => {
    "Year": year,
    "Month": month,
    "Method": method,
    "Lat": lat,
    "Long": long,
    "Day": day,
  };
}
