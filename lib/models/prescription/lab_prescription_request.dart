// To parse this JSON data, do
//
//     final labPrescriptionRequest = labPrescriptionRequestFromMap(jsonString);

import 'dart:convert';



class LabPrescriptionRequest {
  LabPrescriptionRequest({
    this.hcpId,
    this.labInvestigation,
    this.imageInvestigation,
    this.others,
    this.userId,
  });

  int? hcpId;
  String? labInvestigation;
  String? imageInvestigation;
  String? others;
  int? userId;

  factory LabPrescriptionRequest.fromJson(String str) =>
      LabPrescriptionRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LabPrescriptionRequest.fromMap(Map<String, dynamic> json) =>
      LabPrescriptionRequest(

        hcpId: json["HcpId"] == null ? null : json["HcpId"],
        labInvestigation: json["LabInvestigation"] == null
            ? null
            : json["LabInvestigation"],
        imageInvestigation: json["ImageInvestigation"] == null
            ? null
            : json["ImageInvestigation"],
        others: json["Others"] == null ? null : json["Others"],
        userId: json["UserId"] == null ? null : json["UserId"],
      );

  Map<String, dynamic> toMap() =>
      {
        "HcpId": hcpId == null ? null : hcpId,
        "LabInvestigation": labInvestigation == null ? null : labInvestigation,
        "ImageInvestigation": imageInvestigation == null
            ? null
            : imageInvestigation,
        "Others": others == null ? null : others,
        "UserId": userId == null ? null : userId,
      };

}


