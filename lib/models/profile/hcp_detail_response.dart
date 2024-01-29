// To parse this JSON data, do
//
//     final hcpDetailResponse = hcpDetailResponseFromMap(jsonString);

import 'dart:convert';

import 'package:lifeeazy_medical/models/profile/educational_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/personal_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/professional_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/scheduler_request.dart';

class HcpDetailResponse {
  HcpDetailResponse({
    this.profile,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.mobileNumber,
    this.deviceToken,
    this.education,
    this.professional,
    this.schedule,
  });


  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? mobileNumber;
  String? deviceToken;
  PersonalProfileRequest? profile;
  EducationalProfileRequest? education;
  ProfessionalProfileRequest? professional;
  ScheduleRequest? schedule;

  factory HcpDetailResponse.fromJson(String str) => HcpDetailResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HcpDetailResponse.fromMap(Map<String, dynamic> json) => HcpDetailResponse(
    profile: json["Profile"] == null ? null : PersonalProfileRequest.fromMap(json["Profile"]),
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    username: json["Username"] == null ? null : json["Username"],
    mobileNumber: json["MobileNumber"] == null ? null : json["MobileNumber"],
    deviceToken: json["DeviceToken"] == null ? null : json["DeviceToken"],
    education: json["Education"] == null ? null :  EducationalProfileRequest.fromMap(json["Education"]),
    professional: json["Professional"] == null ? null :  ProfessionalProfileRequest.fromMap(json["Professional"]),
    schedule: json["Schedule"] == null ? null :  ScheduleRequest.fromMap(json["Schedule"]),
  );

  Map<String, dynamic> toMap() => {
    "Profile": profile == null ? null : profile!.toMap(),
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
    "Username": username == null ? null : username,
    "MobileNumber": mobileNumber == null ? null : mobileNumber,
    "DeviceToken": deviceToken == null ? null : deviceToken,
    "Education": education == null ? null : education!.toMap(),
    "Professional": professional == null ? null : professional!.toMap(),
    "Schedule": schedule == null ? null : schedule!.toMap(),
  };
}

