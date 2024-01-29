// To parse this JSON data, do
//
//     final validateOtpRequest = validateOtpRequestFromMap(jsonString);

import 'dart:convert';

class ValidateOtpRequest {
  ValidateOtpRequest({
    this.otp,
  });

  String? otp;

  factory ValidateOtpRequest.fromJson(String str) =>
      ValidateOtpRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ValidateOtpRequest.fromMap(Map<String, dynamic> json) =>
      ValidateOtpRequest(
        otp: json["otp"] == null ? null : json["otp"],
      );

  Map<String, dynamic> toMap() => {
        "otp": otp == null ? null : otp,
      };
}
