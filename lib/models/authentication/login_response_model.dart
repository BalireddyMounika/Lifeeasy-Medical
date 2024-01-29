// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromMap(jsonString);

import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.mobileNumber,
    this.profile,
  });

  int ?id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? mobileNumber;
  dynamic? profile;

  factory LoginResponseModel.fromJson(String str) => LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) => LoginResponseModel(
    id: json["id"] == null ? null : json["id"],
    firstName: json["Firstname"] == null ? null : json["Firstname"],
    lastName: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    username: json["Username"] == null ? null : json["Username"],
    mobileNumber: json["MobileNumber"] == null ? null : json["MobileNumber"],
    profile: json["Profile"] == null ? null : json["Profile"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "Firstname": firstName == null ? null : firstName,
    "Lastname": lastName == null ? null : lastName,
    "Email": email == null ? null : email,
    "Username": username == null ? null : username,
    "MobileNumber": mobileNumber == null ? null : mobileNumber,
    "Profile": profile == null ? null : profile,
  };
}
