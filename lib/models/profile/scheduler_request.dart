// To parse this JSON data, do
//
//     final scheduleRequest = scheduleRequestFromMap(jsonString);

import 'dart:convert';

class ScheduleRequest {
  ScheduleRequest({
    this.hcpId,
    this.fromDate,
    this.toDate,
    this.fromTIme,
    this.toTime,
    this.teleconsultationFees,
    this.inclinicFees,
    this.homeFees,
  });

  int? hcpId;
  String? fromDate;
  String? toDate;
  String? fromTIme;
  String? toTime;
  int? teleconsultationFees;
  int? inclinicFees;
  int? homeFees;

  factory ScheduleRequest.fromJson(String str) => ScheduleRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleRequest.fromMap(Map<String, dynamic> json) => ScheduleRequest(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    fromDate: json["FromDate"] == null ? null : json["FromDate"],
    toDate: json["ToDate"] == null ? null : json["ToDate"],
    fromTIme: json["FromTIme"] == null ? null : json["FromTIme"],
    toTime: json["ToTime"] == null ? null : json["ToTime"],
    teleconsultationFees: json["TeleconsultationFees"] == null ? null : json["TeleconsultationFees"],
    inclinicFees: json["InclinicFees"] == null ? null : json["InclinicFees"],
    homeFees: json["HomeFees"] == null ? null : json["HomeFees"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "FromDate": fromDate == null ? null : fromDate,
    "ToDate": toDate == null ? null : toDate,
    "FromTIme": fromTIme == null ? null : fromTIme,
    "ToTime": toTime == null ? null : toTime,
    "TeleconsultationFees": teleconsultationFees == null ? null : teleconsultationFees,
    "InclinicFees": inclinicFees == null ? null : inclinicFees,
    "HomeFees": homeFees == null ? null : homeFees,
  };
}
