// To parse this JSON data, do
//
//     final dailyVersesResponse = dailyVersesResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DailyVersesResponse dailyVersesResponseFromJson(String str) => DailyVersesResponse.fromJson(json.decode(str));

String dailyVersesResponseToJson(DailyVersesResponse data) => json.encode(data.toJson());

class DailyVersesResponse {
  DailyVersesResponse({
    required this.status,
    required this.message,
    required this.displayWholeQuranFiltered,
  });

  final String status;
  final String message;
  final List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;

  factory DailyVersesResponse.fromJson(Map<String, dynamic> json) => DailyVersesResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    displayWholeQuranFiltered: json["displayWholeQuranFiltered"] == null ? null : List<DisplayWholeQuranFiltered>.from(json["displayWholeQuranFiltered"].map((x) => DisplayWholeQuranFiltered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "displayWholeQuranFiltered": displayWholeQuranFiltered == null ? null : List<dynamic>.from(displayWholeQuranFiltered!.map((x) => x.toJson())),
  };
}

class DisplayWholeQuranFiltered {
  DisplayWholeQuranFiltered({
    required this.ayatAutoIncrId,
    required this.ayatNumber,
    required this.ayatText,
    required this.suratName,
    required this.suratEngName,
    required this.suartEnglishTranslation,
    required this.suratId,
    required this.suartRevelationCity,
    required this.suartNumberOfAyats,
    required this.juzId,
    required this.ayatNumberInsurat,
    required this.pageId,
    required this.fileName,
  });

  final String ayatAutoIncrId;
  final String ayatNumber;
  final String ayatText;
  final String suratName;
  final String suratEngName;
  final String suartEnglishTranslation;
  final String suratId;
  final String suartRevelationCity;
  final String suartNumberOfAyats;
  final String juzId;
  final String ayatNumberInsurat;
  final String pageId;
  final String fileName;

  factory DisplayWholeQuranFiltered.fromJson(Map<String, dynamic> json) => DisplayWholeQuranFiltered(
    ayatAutoIncrId: json["AyatAutoIncrID"] == null ? null : json["AyatAutoIncrID"],
    ayatNumber: json["AyatNumber"] == null ? null : json["AyatNumber"],
    ayatText: json["AyatText"] == null ? null : json["AyatText"],
    suratName: json["SuratName"] == null ? null : json["SuratName"],
    suratEngName: json["SuratEngName"] == null ? null : json["SuratEngName"],
    suartEnglishTranslation: json["SuartEnglishTranslation"] == null ? null : json["SuartEnglishTranslation"],
    suratId: json["SuratID"] == null ? null : json["SuratID"],
    suartRevelationCity: json["SuartRevelationCity"] == null ? null : json["SuartRevelationCity"],
    suartNumberOfAyats: json["SuartNumberOfAyats"] == null ? null : json["SuartNumberOfAyats"],
    juzId: json["juz_id"] == null ? null : json["juz_id"],
    ayatNumberInsurat: json["AyatNumberInsurat"] == null ? null : json["AyatNumberInsurat"],
    pageId: json["page_id"] == null ? null : json["page_id"],
    fileName: json["FileName"] == null ? null : json["FileName"],
  );

  Map<String, dynamic> toJson() => {
    "AyatAutoIncrID": ayatAutoIncrId == null ? null : ayatAutoIncrId,
    "AyatNumber": ayatNumber == null ? null : ayatNumber,
    "AyatText": ayatText == null ? null : ayatText,
    "SuratName": suratName == null ? null : suratName,
    "SuratEngName": suratEngName == null ? null : suratEngName,
    "SuartEnglishTranslation": suartEnglishTranslation == null ? null : suartEnglishTranslation,
    "SuratID": suratId == null ? null : suratId,
    "SuartRevelationCity": suartRevelationCity == null ? null : suartRevelationCity,
    "SuartNumberOfAyats": suartNumberOfAyats == null ? null : suartNumberOfAyats,
    "juz_id": juzId == null ? null : juzId,
    "AyatNumberInsurat": ayatNumberInsurat == null ? null : ayatNumberInsurat,
    "page_id": pageId == null ? null : pageId,
    "FileName": fileName == null ? null : fileName,
  };
}

enum SuartEnglishTranslation { THE_ORIGINATOR }

final suartEnglishTranslationValues = EnumValues({
  "The Originator": SuartEnglishTranslation.THE_ORIGINATOR
});

enum SuartRevelationCity { MECCAN }

final suartRevelationCityValues = EnumValues({
  "Meccan": SuartRevelationCity.MECCAN
});

enum SuratEngName { FAATIR }

final suratEngNameValues = EnumValues({
  "Faatir": SuratEngName.FAATIR
});

enum SuratName { EMPTY }

final suratNameValues = EnumValues({
  "سورة فاطر": SuratName.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
