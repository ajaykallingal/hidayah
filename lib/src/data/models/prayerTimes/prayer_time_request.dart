// To parse this JSON data, do
//
//     final getPrayerTimesRequest = getPrayerTimesRequestFromJson(jsonString);

import 'package:meta/meta.dart';
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
    year: json["Year"] == null ? null : json["Year"],
    month: json["Month"] == null ? null : json["Month"],
    method: json["Method"] == null ? null : json["Method"],
    lat: json["Lat"] == null ? null : json["Lat"],
    long: json["Long"] == null ? null : json["Long"],
    day: json["Day"] == null ? null : json["Day"],
  );

  Map<String, dynamic> toJson() => {
    "Year": year == null ? null : year,
    "Month": month == null ? null : month,
    "Method": method == null ? null : method,
    "Lat": lat == null ? null : lat,
    "Long": long == null ? null : long,
    "Day": day == null ? null : day,
  };
}
