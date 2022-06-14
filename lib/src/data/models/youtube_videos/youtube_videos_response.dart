// To parse this JSON data, do
//
//     final youtubeVideosResponse = youtubeVideosResponseFromJson(jsonString);

import 'dart:convert';

YoutubeVideosResponse youtubeVideosResponseFromJson(String str) => YoutubeVideosResponse.fromJson(json.decode(str));

String youtubeVideosResponseToJson(YoutubeVideosResponse data) => json.encode(data.toJson());

class YoutubeVideosResponse {
  YoutubeVideosResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final VideoResponse? response;

  factory YoutubeVideosResponse.fromJson(Map<String, dynamic> json) => YoutubeVideosResponse(
    status: json["status"],
    message: json["message"],
    response: json["Response"] == null ? null : VideoResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Response": response == null ? null : response!.toJson(),
  };
}

class VideoResponse {
  VideoResponse({
    required this.id,
    required this.link,
  });

  final String id;
  final String link;

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
    id: json["id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
  };
}
