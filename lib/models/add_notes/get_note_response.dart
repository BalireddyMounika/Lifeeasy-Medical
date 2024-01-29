// To parse this JSON data, do
//
//     final getNoteResponse = getNoteResponseFromMap(jsonString);

import 'dart:convert';

GetNoteResponse getNoteResponseFromMap(String str) => GetNoteResponse.fromMap(json.decode(str));

String getNoteResponseToMap(GetNoteResponse data) => json.encode(data.toMap());

class GetNoteResponse {
  GetNoteResponse({
    this.hcpId,
    this.appointmentId,
    this.selfNote,
  });

  int? hcpId;
  int? appointmentId;
  String? selfNote;

  factory GetNoteResponse.fromMap(Map<String, dynamic> json) => GetNoteResponse(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
    selfNote: json["SelfNote"] == null ? null : json["SelfNote"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "AppointmentId": appointmentId == null ? null : appointmentId,
    "SelfNote": selfNote == null ? null : selfNote,
  };
}
