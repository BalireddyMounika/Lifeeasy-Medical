// To parse this JSON data, do
//
//     final clinicListResponse = clinicListResponseFromMap(jsonString);

import 'dart:convert';

List<ClinicListResponse> clinicListResponseFromMap(String str) =>
    List<ClinicListResponse>.from(
        json.decode(str).map((x) => ClinicListResponse.fromMap(x)));

String clinicListResponseToMap(List<ClinicListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

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
