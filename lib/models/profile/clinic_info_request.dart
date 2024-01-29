// To parse this JSON data, do
//
//     final clinicInfoRequest = clinicInfoRequestFromMap(jsonString);

import 'dart:convert';

class ClinicInfoRequest {
  ClinicInfoRequest(
      {this.clinicName,
      this.address,
      this.fromDate,
      this.toDate,
      this.fromTime,
      this.toTime,
      this.fee,
      this.hcpId,
      this.id});
  int? id;
  String? clinicName;
  String? address;
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  int? fee;
  int? hcpId;

  factory ClinicInfoRequest.fromJson(String str) =>
      ClinicInfoRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClinicInfoRequest.fromMap(Map<String, dynamic> json) =>
      ClinicInfoRequest(
          clinicName: json["ClinicName"] == null ? null : json["ClinicName"],
          address: json["Address"] == null ? null : json["Address"],
          fromDate: json["FromDate"] == null ? null : json["FromDate"],
          toDate: json["ToDate"] == null ? null : json["ToDate"],
          fromTime: json["FromTime"] == null ? null : json["FromTime"],
          toTime: json["ToTime"] == null ? null : json["ToTime"],
          fee: json["Fee"] == null ? null : json["Fee"],
          hcpId: json["HcpId"] == null ? null : json["HcpId"],
          id: json["id"] == null ? null : json["id"]);

  Map<String, dynamic> toMap() => {
        "ClinicName": clinicName == null ? null : clinicName,
        "Address": address == null ? null : address,
        "FromDate": fromDate == null ? null : fromDate,
        "ToDate": toDate == null ? null : toDate,
        "FromTime": fromTime == null ? null : fromTime,
        "ToTime": toTime == null ? null : toTime,
        "Fee": fee == null ? null : fee,
        "HcpId": hcpId == null ? null : hcpId,
        // "id" : id == null?null : id
      };
}
