// To parse this JSON data, do
//
//     final surahResponse = surahResponseFromJson(jsonString);

import 'package:meta/meta.dart';
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
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    transliteration: json["transliteration"] == null ? null : json["transliteration"],
    translation: json["translation"] == null ? null : json["translation"],
    type: json["type"] == null ? null : json["type"],
    totalVerses: json["total_verses"] == null ? null : json["total_verses"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "transliteration": transliteration == null ? null : transliteration,
    "translation": translation == null ? null : translation,
    "type": type == null ? null : type,
    "total_verses": totalVerses == null ? null : totalVerses,
    "link": link == null ? null : link,
  };
}
