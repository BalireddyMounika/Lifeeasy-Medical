// To parse this JSON data, do
//
//     final generateOtpRequest = generateOtpRequestFromMap(jsonString);

import 'dart:convert';

class GenerateOtpRequest {
  GenerateOtpRequest({
    this.phoneNumber,
  });

  String? phoneNumber;

  factory GenerateOtpRequest.fromJson(String str) =>
      GenerateOtpRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenerateOtpRequest.fromMap(Map<String, dynamic> json) =>
      GenerateOtpRequest(
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
      );

  Map<String, dynamic> toMap() => {
        "phone_number": phoneNumber == null ? null : phoneNumber,
      };
}
