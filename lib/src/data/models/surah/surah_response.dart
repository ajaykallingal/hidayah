// To parse this JSON data, do
//
//     final surahResponse = surahResponseFromJson(jsonString);

import 'dart:convert';

List<SurahResponse> surahResponseFromJson(String str) => List<SurahResponse>.from(json.decode(str).map((x) => SurahResponse.fromJson(x)));

String surahResponseToJson(List<SurahResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurahResponse {
  SurahResponse({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.totalVerses,
    required this.link,
  });

  final String id;
  final String name;
  final String transliteration;
  final String translation;
  final String type;
  final String totalVerses;
  final String link;

  factory SurahResponse.fromJson(Map<String, dynamic> json) => SurahResponse(
    id: json["id"],
    name: json["name"],
    transliteration: json["transliteration"],
    translation: json["translation"],
    type: json["type"],
    totalVerses: json["total_verses"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "transliteration": transliteration,
    "translation": translation,
    "type": type,
    "total_verses": totalVerses,
    "link": link,
  };
}
