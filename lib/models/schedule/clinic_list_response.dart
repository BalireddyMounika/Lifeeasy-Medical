// To parse this JSON data, do
//
//     final clinicListResponse = clinicListResponseFromMap(jsonString);

import 'dart:convert';

class ClinicListResponse {
  ClinicListResponse({
    this.id,
    this.clinicName,
    this.address,
    this.hcpId,
  });

  int? id;
  String? clinicName;
  String? address;
  int? hcpId;

  factory ClinicListResponse.fromJson(String str) =>
      ClinicListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClinicListResponse.fromMap(Map<String, dynamic> json) =>
      ClinicListResponse(
        id: json["id"],
        clinicName: json["ClinicName"],
        address: json["Address"],
        hcpId: json["HcpId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ClinicName": clinicName,
        "Address": address,
        "HcpId": hcpId,
      };
}
