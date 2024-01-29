// To parse this JSON data, do
//
//     final postSefNoteRequest = postSefNoteRequestFromMap(jsonString);

import 'dart:convert';

PostNoteRequest postSefNoteRequestFromMap(String str) => PostNoteRequest.fromMap(json.decode(str));

String postSefNoteRequestToMap(PostNoteRequest data) => json.encode(data.toMap());

class PostNoteRequest {
  PostNoteRequest({
    this.hcpId,
    this.appointmentId,
    this.selfNote,
  });

  int? hcpId;
  int? appointmentId;
  String? selfNote;

  factory PostNoteRequest.fromMap(Map<String, dynamic> json) => PostNoteRequest(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
    selfNote: json["SelfNote"] == null ? null : json["SelfNote"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "AppointmentId": appointmentId == null ? null : appointmentId,
    "SelfNote": selfNote == null ? null : selfNote,
  };

  String toJson() => json.encode(toMap());
}
