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
    langId: json["LangID"] == null ? null : json["LangID"],
    suratId: json["SuratID"] == null ? null : json["SuratID"],
    ayathNo: json["AyathNo"] == null ? null : json["AyathNo"],
    juzId: json["JuzID"] == null ? null : json["JuzID"],
    ayathPageNo: json["AyathPageNo"] == null ? null : json["AyathPageNo"],
    ayatAutoIncrId: json["AyatAutoIncrID"] == null ? null : json["AyatAutoIncrID"],
    searchText: json["SearchText"] == null ? null : json["SearchText"],
    limitFrom: json["LimitFrom"] ==null ? null : json["LimitFrom"],
    limitTo: json["LimitTo"] == null ? null : json["LimitTo"] ,
    voiceTypeId: json["VoiceTypeID"] == null ? null : json["VoiceTypeID"],
  );

  Map<String, dynamic> toJson() => {
    "LangID": langId ==null ? null : langId,
    "SuratID": suratId == null ? null : suratId,
    "AyathNo": ayathNo == null ? null : ayathNo,
    "JuzID": juzId == null ? null : juzId,
    "AyathPageNo": ayathPageNo == null ? null : ayathPageNo,
    "AyatAutoIncrID": ayatAutoIncrId == null ? null : ayatAutoIncrId,
    "SearchText": searchText == null ? null : searchText,
    "LimitFrom": limitFrom == null ? null : limitFrom,
    "LimitTo": limitTo == null ? null : limitTo,
    "VoiceTypeID": voiceTypeId == null ? null : voiceTypeId,
  };
}
