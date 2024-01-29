// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromMap(jsonString);

import 'dart:convert';

class RegisterRequestModel {
  RegisterRequestModel({
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.password,
    this.mobileNumber,
    this.deviceToken,
    this.tag
  });

  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? password;
  String? mobileNumber;
  String? deviceToken;
  String? tag;

  factory RegisterRequestModel.fromJson(String str) => RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) => RegisterRequestModel(
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    username: json["Username"] == null ? null : json["Username"],
    password: json["Password"] == null ? null : json["Password"],
    mobileNumber: json["MobileNumber"] == null ? null : json["MobileNumber"],
    deviceToken: json["DeviceToken"] == null ? null : json["DeviceToken"],
    tag : json["Tag"]  == null ? null : json["Tag"]
  );

  Map<String, dynamic> toMap() => {
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
    "Username": username == null ? null : username,
    "Password": password == null ? null : password,
    "MobileNumber": mobileNumber == null ? null : mobileNumber,
    "DeviceToken": deviceToken == null ? null : deviceToken,
    "Tag" : tag == null ? null :tag
  };
}
