// To parse this JSON data, do
//
//     final scheduleCallStatus = scheduleCallStatusFromMap(jsonString);

import 'dart:convert';

class ScheduleCallStatus {
  ScheduleCallStatus({
    this.appointmentId,
    this.createdDate,
    this.status,
    this.duration,
  });

  int? appointmentId;
  String? createdDate;
  String? status;
  String? duration;

  factory ScheduleCallStatus.fromJson(String str) => ScheduleCallStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleCallStatus.fromMap(Map<String, dynamic> json) => ScheduleCallStatus(
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
    createdDate: json["CreatedDate"] == null ? null : json["CreatedDate"],
    status: json["Status"] == null ? null : json["Status"],
    duration: json["Duration"] == null ? null : json["Duration"],
  );

  Map<String, dynamic> toMap() => {
    "AppointmentId": appointmentId == null ? null : appointmentId,
    "CreatedDate": createdDate == null ? null : createdDate,
    "Status": status == null ? null : status,
    "Duration": duration == null ? null : duration,
  };
}
