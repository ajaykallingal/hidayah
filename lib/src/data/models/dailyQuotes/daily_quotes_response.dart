// To parse this JSON data, do
//
//     final getDailyQuotesReponse = getDailyQuotesReponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    todaysQuote: json["TodaysQuote"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "TodaysQuote": todaysQuote,
  };
}
