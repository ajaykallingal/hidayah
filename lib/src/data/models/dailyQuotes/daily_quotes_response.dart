// To parse this JSON data, do
//
//     final getDailyQuotesReponse = getDailyQuotesReponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetDailyQuotesReponse getDailyQuotesReponseFromJson(String str) => GetDailyQuotesReponse.fromJson(json.decode(str));

String getDailyQuotesReponseToJson(GetDailyQuotesReponse data) => json.encode(data.toJson());

class GetDailyQuotesReponse {
  GetDailyQuotesReponse({
    required this.status,
    required this.message,
    required this.todaysQuote,
  });

  final String status;
  final String message;
  final String todaysQuote;

  factory GetDailyQuotesReponse.fromJson(Map<String, dynamic> json) => GetDailyQuotesReponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    todaysQuote: json["TodaysQuote"] == null ? null : json["TodaysQuote"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "TodaysQuote": todaysQuote == null ? null : todaysQuote,
  };
}
