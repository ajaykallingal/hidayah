// To parse this JSON data, do
//
//     final getPrayerTimesReponse = getPrayerTimesReponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPrayerTimesReponse getPrayerTimesReponseFromJson(String str) => GetPrayerTimesReponse.fromJson(json.decode(str));

String getPrayerTimesReponseToJson(GetPrayerTimesReponse data) => json.encode(data.toJson());

class GetPrayerTimesReponse {
  GetPrayerTimesReponse({
    required this.status,
    required this.message,
    required this.times,
  });

  final String status;
  final String message;
  final Times? times;

  factory GetPrayerTimesReponse.fromJson(Map<String, dynamic> json) => GetPrayerTimesReponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    times: json["times"] == null ? null : Times.fromJson(json["times"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "times": times == null ? null : times!.toJson(),
  };
}

class Times {
  Times({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;

  factory Times.fromJson(Map<String, dynamic> json) => Times(
    fajr: json["Fajr"] == null ? null : json["Fajr"],
    sunrise: json["Sunrise"] == null ? null : json["Sunrise"],
    dhuhr: json["Dhuhr"] == null ? null : json["Dhuhr"],
    asr: json["Asr"] == null ? null : json["Asr"],
    sunset: json["Sunset"] == null ? null : json["Sunset"],
    maghrib: json["Maghrib"] == null ? null : json["Maghrib"],
    isha: json["Isha"] == null ? null : json["Isha"],
    imsak: json["Imsak"] == null ? null : json["Imsak"],
    midnight: json["Midnight"] == null ? null : json["Midnight"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr == null ? null : fajr,
    "Sunrise": sunrise == null ? null : sunrise,
    "Dhuhr": dhuhr == null ? null : dhuhr,
    "Asr": asr == null ? null : asr,
    "Sunset": sunset == null ? null : sunset,
    "Maghrib": maghrib == null ? null : maghrib,
    "Isha": isha == null ? null : isha,
    "Imsak": imsak == null ? null : imsak,
    "Midnight": midnight == null ? null : midnight,
  };
}
