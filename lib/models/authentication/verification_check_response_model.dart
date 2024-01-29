// To parse this JSON data, do
//
//     final verificationCheckResponseModel = verificationCheckResponseModelFromMap(jsonString);

import 'dart:convert';

class VerificationCheckResponseModel {
  VerificationCheckResponseModel({
    this.isProfileFilled,
    this.isVerified,
  });

  bool? isProfileFilled;
  bool? isVerified;

  factory VerificationCheckResponseModel.fromJson(String str) => VerificationCheckResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerificationCheckResponseModel.fromMap(Map<String, dynamic> json) => VerificationCheckResponseModel(
    isProfileFilled: json["isProfileFilled"] == null ? null : json["isProfileFilled"],
    isVerified: json["isVerified"] == null ? null : json["isVerified"],
  );

  Map<String, dynamic> toMap() => {
    "isProfileFilled": isProfileFilled == null ? null : isProfileFilled,
    "isVerified": isVerified == null ? null : isVerified,
  };
}
