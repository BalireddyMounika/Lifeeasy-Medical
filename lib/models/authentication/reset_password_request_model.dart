// To parse this JSON data, do
//
//     final resetPasswordRequestModel = resetPasswordRequestModelFromMap(jsonString);

import 'dart:convert';

class ResetPasswordRequestModel {
  final String password;
  ResetPasswordRequestModel({
   required this.password,
  });




  factory ResetPasswordRequestModel.fromJson(String str) => ResetPasswordRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordRequestModel.fromMap(Map<String, dynamic> json) => ResetPasswordRequestModel(
    password: json["Password"] == null ? null : json["Password"],
  );

  Map<String, dynamic> toMap() => {
    "Password": password == null ? null : password,
  };
}
