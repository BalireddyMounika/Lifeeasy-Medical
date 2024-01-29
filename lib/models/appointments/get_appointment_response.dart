// To parse this JSON data, do
//
//     final getAppointmentResponse = getAppointmentResponseFromMap(jsonString);

import 'dart:convert';

import 'package:lifeeazy_medical/models/authentication/login_response_model.dart';

import '../family_member/family_member_model.dart';

class GetAppointmentResponse {
  GetAppointmentResponse({
    this.id,
    this.currentDate,
    this.date,
    this.time,
    this.specialization,
    this.status,
    this.appointmentType,
    this.fees,
    this.userId,
    this.profile,
    this.doctorId,
    this.symptoms,
    this.familyMemberId,
  });

  int? id;
  String? currentDate;
  String? date;
  String? time;
  String? specialization;
  String? status;
  String? appointmentType;
  int? fees;
  dynamic symptoms;
  LoginResponseModel? userId;
  dynamic profile;
  int ? doctorId;
  final FamilyMemberModel? familyMemberId;


  factory GetAppointmentResponse.fromJson(String str) => GetAppointmentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAppointmentResponse.fromMap(Map<String, dynamic> json) => GetAppointmentResponse(
    id: json["id"] == null ? null : json["id"],
    currentDate: json["CurrentDate"] == null ? null : json["CurrentDate"],
    symptoms: json["symptoms"] == null ? null :json["symptoms"],
    date: json["Date"] == null ? null : json["Date"],
    time: json["Time"] == null ? null : json["Time"],
    specialization: json["Specialization"] == null ? null : json["Specialization"],
    status: json["Status"] == null ? null : json["Status"],
    appointmentType: json["AppointmentType"] == null ? null : json["AppointmentType"],
    fees: json["Fees"] == null ? null : json["Fees"],
    userId:json["UserId"] == null ? null :LoginResponseModel.fromMap(json["UserId"]),
    profile: json["Profile"] == null ? null:json["Profile"],

      familyMemberId: json["FamilyMemberId"] == null ? null : FamilyMemberModel.fromMap(json["FamilyMemberId"]),


      doctorId: json["DoctorId"] == null ? null : json["DoctorId"]);


  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "CurrentDate": currentDate == null ? null : currentDate,
    "Date": date == null ? null : date,
    "Time": time == null ? null : time,
    "Specialization": specialization == null ? null : specialization,
    "Status": status == null ? null : status,
    "AppointmentType": appointmentType == null ? null : appointmentType,
    "Fees": fees == null ? null : fees,
    "UserId": userId == null ? null : userId!.toMap(),
    "Profile": profile == null ? null : profile,
    "symptoms" : symptoms == null ?null:symptoms,
    "DoctorId": doctorId == null ? null : doctorId,
    "familyMemberId" : familyMemberId == null ? null : familyMemberId!.toMap()


  };
}





