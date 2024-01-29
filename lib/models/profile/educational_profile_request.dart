// To parse this JSON data, do
//
//     final educationalProfileRequest = educationalProfileRequestFromMap(jsonString);

import 'dart:convert';

class EducationalProfileRequest {
  EducationalProfileRequest({
    this.degree,
    this.collegeUniversity,
    this.yearOfEducation,
    this.educationalLocation,
    this.hcpId,
  });

  String? degree;
  String? collegeUniversity;
  int? yearOfEducation;
  String? educationalLocation;
  int? hcpId;

  factory EducationalProfileRequest.fromJson(String str) => EducationalProfileRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EducationalProfileRequest.fromMap(Map<String, dynamic> json) => EducationalProfileRequest(
    degree: json["Degree"] == null ? null : json["Degree"],
    collegeUniversity: json["CollegeUniversity"] == null ? null : json["CollegeUniversity"],
    yearOfEducation: json["YearOfEducation"] == null ? null : json["YearOfEducation"],
    educationalLocation: json["EducationalLocation"] == null ? null : json["EducationalLocation"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
  );

  Map<String, dynamic> toMap() => {
    "Degree": degree == null ? null : degree,
    "CollegeUniversity": collegeUniversity == null ? null : collegeUniversity,
    "YearOfEducation": yearOfEducation == null ? null : yearOfEducation,
    "EducationalLocation": educationalLocation == null ? null : educationalLocation,
    "HcpId": hcpId == null ? null : hcpId,
  };
}
