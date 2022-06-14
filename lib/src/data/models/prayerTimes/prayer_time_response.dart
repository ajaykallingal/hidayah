// To parse this JSON data, do
//
//     final getPrayerTimesReponse = getPrayerTimesReponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    times: json["times"] == null ? null : Times.fromJson(json["times"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
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
    fajr: json["Fajr"],
    sunrise: json["Sunrise"],
    dhuhr: json["Dhuhr"],
    asr: json["Asr"],
    sunset: json["Sunset"],
    maghrib: json["Maghrib"],
    isha: json["Isha"],
    imsak: json["Imsak"],
    midnight: json["Midnight"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Sunrise": sunrise,
    "Dhuhr": dhuhr,
    "Asr": asr,
    "Sunset": sunset,
    "Maghrib": maghrib,
    "Isha": isha,
    "Imsak": imsak,
    "Midnight": midnight,
  };
}
