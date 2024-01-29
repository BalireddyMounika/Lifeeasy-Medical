// To parse this JSON data, do
//
//     final getScheduleCallStatusResponse = getScheduleCallStatusResponseFromMap(jsonString);

import 'dart:convert';

class GetScheduleCallStatusResponse {
  GetScheduleCallStatusResponse({
    this.id,
    this.appointmentId,
    this.createdDate,
    this.status,
    this.duration,
  });

  int? id;
  int? appointmentId;
  DateTime? createdDate;
  String? status;
  String? duration;

  factory GetScheduleCallStatusResponse.fromJson(String str) => GetScheduleCallStatusResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetScheduleCallStatusResponse.fromMap(Map<String, dynamic> json) => GetScheduleCallStatusResponse(
    id: json["id"] == null ? null : json["id"],
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
    createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
    status: json["Status"] == null ? null : json["Status"],
    duration: json["Duration"] == null ? null : json["Duration"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "AppointmentId": appointmentId == null ? null : appointmentId,
    "CreatedDate": createdDate == null ? null : "${createdDate?.year.toString().padLeft(4, '0')}-${createdDate?.month.toString().padLeft(2, '0')}-${createdDate?.day.toString().padLeft(2, '0')}",
    "Status": status == null ? null : status,
    "Duration": duration == null ? null : duration,
  };
}
