// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) => RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) => json.encode(data.toJson());

class RegistrationResponse {
  RegistrationResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  final String status;
  final String message;
  final int response;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
    status: json["status"],
    message: json["message"],
    response: json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Response": response,
  };
}
