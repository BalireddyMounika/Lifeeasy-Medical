// To parse this JSON data, do
//
//     final medicationRequest = medicationRequestFromMap(jsonString);

import 'dart:convert';
// To parse this JSON data, do
//
//     final medicationRequestModel = medicationRequestModelFromMap(jsonString);

import 'dart:convert';

class MedicationRequestModel {
  MedicationRequestModel({
    this.medication,
  });

  List<MedicationRequest>? medication;

  factory MedicationRequestModel.fromJson(String str) => MedicationRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedicationRequestModel.fromMap(Map<String, dynamic> json) => MedicationRequestModel(
    medication: json["Medication"] == null ? null : List<MedicationRequest>.from(json["Medication"].map((x) => MedicationRequest.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Medication": medication == null ? null : List<dynamic>.from(medication!.map((x) => x.toMap())),
  };
}



class MedicationRequest {
  MedicationRequest({
    this.drugName,
    this.quantity,
    this.dosages,
    this.route,
    this.frequency,
    this.instructions,
    this.prescriptionId,
  });

  String? drugName;
  int? quantity;
  String? dosages;
  String? route;
  String ? frequency;
  String? instructions;
  int? prescriptionId;

  factory MedicationRequest.fromJson(String str) => MedicationRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedicationRequest.fromMap(Map<String, dynamic> json) => MedicationRequest(
    drugName: json["DrugName"] == null ? null : json["DrugName"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    dosages: json["Dosages"] == null ? null : json["Dosages"],
    route: json["Route"] == null ? null : json["Route"],
    frequency: json["Frequency"] == null ? null : json["Frequency"],
    instructions: json["Instructions"] == null ? null : json["Instructions"],
    prescriptionId: json["PrescriptionId"] == null ? null : json["PrescriptionId"],
  );

  Map<String, dynamic> toMap() => {
    "DrugName": drugName == null ? null : drugName,
    "Quantity": quantity == null ? null : quantity,
    "Dosages": dosages == null ? null : dosages,
    "Route": route == null ? null : route,
    "Frequency": frequency == null ? null : frequency,
    "Instructions": instructions == null ? null : instructions,
    "PrescriptionId": prescriptionId == null ? null : prescriptionId,
  };
}
