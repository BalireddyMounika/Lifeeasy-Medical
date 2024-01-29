// To parse this JSON data, do
//
//     final prescriptionRequest = prescriptionRequestFromMap(jsonString);

import 'dart:convert';

class PrescriptionRequest {
  PrescriptionRequest({
    this.hcpId,
    this.appointmentId,
    this.nextFollowUpDate,
    this.signature,
    this.userId,
    this.familyMemberId
  });

  int? hcpId;
  int? appointmentId;
  String? nextFollowUpDate;
  String? signature;
  int? userId;
  int? familyMemberId;

  factory PrescriptionRequest.fromJson(String str) => PrescriptionRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrescriptionRequest.fromMap(Map<String, dynamic> json) => PrescriptionRequest(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
    nextFollowUpDate: json["NextFollowUpDate"] == null ? null : json["NextFollowUpDate"],
    signature: json["Signature"] == null ? null : json["Signature"],
    userId: json["UserId"] == null ? null : json["UserId"],
    familyMemberId: json["FamilyMemberId"] ==null ? null :json["FamilyMemberId"]
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "AppointmentId": appointmentId == null ? null : appointmentId,
    "NextFollowUpDate": nextFollowUpDate == null ? null : nextFollowUpDate,
    "Signature": signature == null ? null : signature,
    "UserId": userId == null ? null : userId,
    "FamilyMemberId":familyMemberId ==null? null :familyMemberId
  };
}
