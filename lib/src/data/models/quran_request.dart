// To parse this JSON data, do
//
//     final quranRequest = quranRequestFromJson(jsonString);

import 'dart:convert';

QuranRequest quranRequestFromJson(String str) => QuranRequest.fromJson(json.decode(str));

String quranRequestToJson(QuranRequest data) => json.encode(data.toJson());

class QuranRequest {
  QuranRequest({
    required this.langId,
    required this.suratId,
    required this.ayathNo,
    required this.juzId,
    required this.ayathPageNo,
    required this.ayatAutoIncrId,
    required this.searchText,
    required this.limitFrom,
    required this.limitTo,
    required this.voiceTypeId,
  });

 final String langId;
 final String suratId;
 final String ayathNo;
 final String juzId;
 final String ayathPageNo;
 final String ayatAutoIncrId;
 final String searchText;
 final String limitFrom;
 final String limitTo;
 final String voiceTypeId;

  factory QuranRequest.fromJson(Map<String, dynamic> json) => QuranRequest(
    langId: json["LangID"],
    suratId: json["SuratID"],
    ayathNo: json["AyathNo"],
    juzId: json["JuzID"],
    ayathPageNo: json["AyathPageNo"],
    ayatAutoIncrId: json["AyatAutoIncrID"],
    searchText: json["SearchText"],
    limitFrom: json["LimitFrom"],
    limitTo: json["LimitTo"] ,
    voiceTypeId: json["VoiceTypeID"],
  );

  Map<String, dynamic> toJson() => {
    "LangID": langId,
    "SuratID": suratId,
    "AyathNo": ayathNo,
    "JuzID": juzId,
    "AyathPageNo": ayathPageNo,
    "AyatAutoIncrID": ayatAutoIncrId,
    "SearchText": searchText,
    "LimitFrom": limitFrom,
    "LimitTo": limitTo,
    "VoiceTypeID": voiceTypeId,
  };
}
