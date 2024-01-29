// To parse this JSON data, do
//
//     final medicalPrescriptionRequest = medicalPrescriptionRequestFromMap(jsonString);

import 'dart:convert';


class MedicalPrescriptionRequest {
  MedicalPrescriptionRequest({
    this.hcpId,
    this.drugName,
    this.quantity,
    this.dosages,
    this.frequency,
    this.route,
    this.instructions,
    this.nextFollowUpDate,
    this.userId,
    this.appointmentId
  });

  int? hcpId;
  String? drugName;
  int? quantity;
  String? dosages;
  String? frequency;
  String? route;
  String? instructions;
  String? nextFollowUpDate;
  int? userId;
  int? appointmentId;
  factory MedicalPrescriptionRequest.fromJson(String str) => MedicalPrescriptionRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedicalPrescriptionRequest.fromMap(Map<String, dynamic> json) => MedicalPrescriptionRequest(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    drugName: json["DrugName"] == null ? null : json["DrugName"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    dosages: json["Dosages"] == null ? null : json["Dosages"],
    frequency: json["Frequency"] == null ? null : json["Frequency"],
    route: json["Route"] == null ? null : json["Route"],
    instructions: json["Instructions"] == null ? null : json["Instructions"],
    nextFollowUpDate: json["NextFollowUp_Date"] == null ? null : json["NextFollowUp_Date"],
    userId: json["UserId"] == null ? null : json["UserId"],
    appointmentId:json["Appointmentid"] == null ? null : json["Appointmentid"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "DrugName": drugName == null ? null : drugName,
    "Quantity": quantity == null ? null : quantity,
    "Dosages": dosages == null ? null : dosages,
    "Frequency": frequency == null ? null : frequency,
    "Route": route == null ? null : route,
    "Instructions": instructions == null ? null : instructions,
    "NextFollowUp_Date": nextFollowUpDate == null ? null : nextFollowUpDate,
    "UserId": userId == null ? null : userId,
    "Appointmentid" :appointmentId == null ? null :appointmentId
  };



}
