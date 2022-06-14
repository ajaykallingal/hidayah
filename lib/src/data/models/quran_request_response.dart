// To parse this JSON data, do
//
//     final quranRequestResponse = quranRequestResponseFromJson(jsonString);

import 'dart:convert';

QuranRequestResponse quranRequestResponseFromJson(String str) => QuranRequestResponse.fromJson(json.decode(str));

String quranRequestResponseToJson(QuranRequestResponse data) => json.encode(data.toJson());

class QuranRequestResponse {
  QuranRequestResponse({
    required this.status,
    required this.message,
    required this.displayWholeQuranFiltered,
  });

 final String status;
 final String message;
 final List<DisplayWholeQuranFiltered>? displayWholeQuranFiltered;

  factory QuranRequestResponse.fromJson(Map<String, dynamic> json) => QuranRequestResponse(
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
   // required this.manzilId,
   required this.pageId,
   // required this.rukuId,
   // required this.sajdaNeededOrNot,
   required this.fileName,
  });

 final String ayatAutoIncrId;
 final String ayatNumber;
 final String ayatText;
 final String? suratName;
 final String? suratEngName;
 final String? suartEnglishTranslation;
 final String suratId;
 final String suartRevelationCity;
 final String suartNumberOfAyats;
 final String juzId;
 final String ayatNumberInsurat;
 // final String manzilId;
 final String pageId;
 // final String rukuId;
  // dynamic sajdaNeededOrNot;
 final String fileName;

  factory DisplayWholeQuranFiltered.fromJson(Map<String, dynamic> json) => DisplayWholeQuranFiltered(
    ayatAutoIncrId: json["AyatAutoIncrID"] ?? "",
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
    // manzilId: json["manzil_id"] == null ? null : json["manzil_id"],
    pageId: json["page_id"],
    // rukuId: json["ruku_id"] == null ? null : json["ruku_id"],
    // sajdaNeededOrNot: json["SajdaNeededOrNot"] == null ? null : json["SajdaNeededOrNot"],
    fileName: json["FileName"],
  );

  Map<String, dynamic> toJson() => {
    "AyatAutoIncrID": ayatAutoIncrId,
    "AyatNumber": ayatNumber,
    "AyatText": ayatText,
    "SuratName": suratNameValues.reverse[suratName],
    "SuratEngName": suratEngNameValues.reverse[suratEngName],
    "SuartEnglishTranslation": suartEnglishTranslationValues.reverse[suartEnglishTranslation],
    "SuratID": suratId,
    "SuartRevelationCity": suartRevelationCity,
    "SuartNumberOfAyats": suartNumberOfAyats,
    "juz_id": juzId,
    "AyatNumberInsurat": ayatNumberInsurat,
    // "manzil_id": manzilId == null ? null : manzilId,
    "page_id": pageId,
    // "ruku_id": rukuId == null ? null : rukuId,
    // "SajdaNeededOrNot": sajdaNeededOrNot == null ? null : sajdaNeededOrNot,
    "FileName": fileName,
  };
}

enum SuartEnglishTranslation { THE_COW }

final suartEnglishTranslationValues = EnumValues({
  "The Cow": SuartEnglishTranslation.THE_COW
});

enum SuartRevelationCity { MEDINAN }

final suartRevelationCityValues = EnumValues({
  "Medinan": SuartRevelationCity.MEDINAN
});

enum SuratEngName { AL_BAQARA }

final suratEngNameValues = EnumValues({
  "Al-Baqara": SuratEngName.AL_BAQARA
});

enum SuratName { EMPTY }

final suratNameValues = EnumValues({
  "سورة البقرة": SuratName.EMPTY
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
