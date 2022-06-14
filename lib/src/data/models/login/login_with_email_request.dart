// To parse this JSON data, do
//
//     final loginWithEmailRequest = loginWithEmailRequestFromJson(jsonString);

import 'dart:convert';

LoginWithEmailRequest loginWithEmailRequestFromJson(String str) => LoginWithEmailRequest.fromJson(json.decode(str));

String loginWithEmailRequestToJson(LoginWithEmailRequest data) => json.encode(data.toJson());

class LoginWithEmailRequest {
  LoginWithEmailRequest({
    required this.userEmail,
    required this.userPassword,
  });

  final String userEmail;
  final String userPassword;

  factory LoginWithEmailRequest.fromJson(Map<String, dynamic> json) => LoginWithEmailRequest(
    userEmail: json["userEmail"],
    userPassword: json["userPassword"],
  );

  Map<String, dynamic> toJson() => {
    "userEmail": userEmail,
    "userPassword": userPassword,
  };
}
