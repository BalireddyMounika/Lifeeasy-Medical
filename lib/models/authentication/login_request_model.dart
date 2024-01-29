// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromMap(jsonString);

import 'dart:convert';

class LoginRequestModel {
  LoginRequestModel({
    this.username,
    this.password,
    this.deviceToken,
  });

  String? username;
  String? password;
  String? deviceToken;

  factory LoginRequestModel.fromJson(String str) =>
      LoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(
        username: json["Username"] == null ? null : json["Username"],
        password: json["Password"] == null ? null : json["Password"],
        deviceToken: json["DeviceToken"] == null ? null : json["DeviceToken"],
      );

  Map<String, dynamic> toMap() => {
    "Username": username == null ? null : username,
    "Password": password == null ? null : password,
    "DeviceToken": deviceToken == null ? null : deviceToken,
  };
}
