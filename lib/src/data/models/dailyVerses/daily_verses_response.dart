// To parse this JSON data, do
//
//     final dailyVersesResponse = dailyVersesResponseFromJson(jsonString);

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
    status: json["status"],
    message: json["message"],
    displayWholeQuranFiltered: json["displayWholeQuranFiltered"] == null ? null : List<DisplayWholeQuranFiltered>.from(json["displayWholeQuranFiltered"].map((x) => DisplayWholeQuranFiltered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
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
    ayatAutoIncrId: json["AyatAutoIncrID"],
    ayatNumber: json["AyatNumber"],
    ayatText: json["AyatText"],
    suratName: json["SuratName"],
    suratEngName: json["SuratEngName"],
    suartEnglishTranslation: json["SuartEnglishTranslation"],
    suratId: json["SuratID"],
    suartRevelationCity: json["SuartRevelationCity"],
    suartNumberOfAyats: json["SuartNumberOfAyats"],
    juzId: json["juz_id"],
    ayatNumberInsurat: json["AyatNumberInsurat"],
    pageId: json["page_id"],
    fileName: json["FileName"],
  );

  Map<String, dynamic> toJson() => {
    "AyatAutoIncrID": ayatAutoIncrId,
    "AyatNumber": ayatNumber,
    "AyatText": ayatText,
    "SuratName": suratName,
    "SuratEngName": suratEngName,
    "SuartEnglishTranslation": suartEnglishTranslation,
    "SuratID": suratId,
    "SuartRevelationCity": suartRevelationCity,
    "SuartNumberOfAyats": suartNumberOfAyats,
    "juz_id": juzId,
    "AyatNumberInsurat": ayatNumberInsurat,
    "page_id": pageId,
    "FileName": fileName,
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
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
