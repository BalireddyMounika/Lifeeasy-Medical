// To parse this JSON data, do
//
//     final updateAppointmentStatusRequest = updateAppointmentStatusRequestFromMap(jsonString);

import 'dart:convert';

class UpdateAppointmentStatusRequest {
  UpdateAppointmentStatusRequest({
    this.status,
  });

  String? status;

  factory UpdateAppointmentStatusRequest.fromJson(String str) => UpdateAppointmentStatusRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateAppointmentStatusRequest.fromMap(Map<String, dynamic> json) => UpdateAppointmentStatusRequest(
    status: json["Status"],
  );

  Map<String, dynamic> toMap() => {
    "Status": status,
  };
}
