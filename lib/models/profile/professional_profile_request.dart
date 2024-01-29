// To parse this JSON data, do
//
//     final professionalProfileRequest = professionalProfileRequestFromMap(jsonString);

import 'dart:convert';

class ProfessionalProfileRequest {
  ProfessionalProfileRequest({
    this.professionalId,
    this.professionalExperienceInYears,
    this.currentStatus,
    this.mciNumber,
    this.mciStateCouncil,
    this.specialization,
    this.areaFocusOn,
    this.patientsHandledPerDay,
    this.patientsHandledPerSlot,
    this.appointmentType,
    this.signature,
    this.hcpId,
  });

  String? professionalId;
  int? professionalExperienceInYears;
  dynamic currentStatus;
  int? mciNumber;
  String? mciStateCouncil;
  String? specialization;
  String? areaFocusOn;
  int? patientsHandledPerDay;
  int? patientsHandledPerSlot;
  List<String>? appointmentType;
  String? signature;
  int? hcpId;

  factory ProfessionalProfileRequest.fromJson(String str) => ProfessionalProfileRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfessionalProfileRequest.fromMap(Map<String, dynamic> json) => ProfessionalProfileRequest(
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
    professionalExperienceInYears: json["ProfessionalExperienceInYears"] == null ? null : json["ProfessionalExperienceInYears"],
    currentStatus: json["CurrentStatus"] == null ? null : json["CurrentStatus"],
    mciNumber: json["MciNumber"] == null ? null : json["MciNumber"],
    mciStateCouncil: json["MciStateCouncil"] == null ? null : json["MciStateCouncil"],
    specialization: json["Specialization"] == null ? null : json["Specialization"],
    areaFocusOn: json["AreaFocusOn"] == null ? null : json["AreaFocusOn"],
    patientsHandledPerDay: json["PatientsHandledPerDay"] == null ? null : json["PatientsHandledPerDay"],
    patientsHandledPerSlot: json["PatientsHandledPerSlot"] == null ? null : json["PatientsHandledPerSlot"],
    appointmentType: json["AppointmentType"] == null ? null : List<String>.from(json["AppointmentType"].map((x) => x)),
    signature: json["Signature"] == null ? null : json["Signature"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
  );

  Map<String, dynamic> toMap() => {
    "ProfessionalId": professionalId == null ? null : professionalId,
    "ProfessionalExperienceInYears": professionalExperienceInYears == null ? null : professionalExperienceInYears,
    "CurrentStatus": currentStatus == null ? null : currentStatus,
    "MciNumber": mciNumber == null ? null : mciNumber,
    "MciStateCouncil": mciStateCouncil == null ? null : mciStateCouncil,
    "Specialization": specialization == null ? null : specialization,
    "AreaFocusOn": areaFocusOn == null ? null : areaFocusOn,
    "PatientsHandledPerDay": patientsHandledPerDay == null ? null : patientsHandledPerDay,
    "PatientsHandledPerSlot": patientsHandledPerSlot == null ? null : patientsHandledPerSlot,
    "AppointmentType": appointmentType == null ? null : List<dynamic>.from(appointmentType!.map((x) => x)),
    "Signature": signature == null ? null : signature,
    "HcpId": hcpId == null ? null : hcpId,
  };
}
