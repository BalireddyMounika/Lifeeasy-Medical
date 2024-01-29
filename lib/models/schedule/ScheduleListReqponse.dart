import 'dart:convert';

class ScheduleListResponse {
  ScheduleListResponse({
    this.id,
    this.scheduleV2Id,
    this.hcpId,
    this.scheduleName,
    this.slotTimings,
    this.fees,
    this.fromTime,
    this.toTime,
  });

  int? id;
  ScheduleV2Id? scheduleV2Id;
  int? hcpId;
  String? scheduleName;
  int? slotTimings;
  int? fees;
  String? fromTime;
  String? toTime;

  factory ScheduleListResponse.fromJson(String str) =>
      ScheduleListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleListResponse.fromMap(Map<String, dynamic> json) =>
      ScheduleListResponse(
        id: json["id"],
        scheduleV2Id: json["ScheduleV2Id"] == null
            ? null
            : ScheduleV2Id.fromMap(json["ScheduleV2Id"]),
        hcpId: json["HcpId"],
        scheduleName: json["ScheduleName"],
        slotTimings: json["SlotTimings"],
        fees: json["Fees"],
        fromTime: json["FromTime"],
        toTime: json["ToTime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ScheduleV2Id": scheduleV2Id?.toMap(),
        "HcpId": hcpId,
        "ScheduleName": scheduleName,
        "SlotTimings": slotTimings,
        "Fees": fees,
        "FromTime": fromTime,
        "ToTime": toTime,
      };
}

class ScheduleV2Id {
  ScheduleV2Id({
    this.id,
    this.hcpId,
    this.clinicId,
    this.typeConsultation,
    this.fromDate,
    this.toDate,
  });

  int? id;
  int? hcpId;
  ClinicId? clinicId;
  String? typeConsultation;
  DateTime? fromDate;
  DateTime? toDate;

  factory ScheduleV2Id.fromJson(String str) =>
      ScheduleV2Id.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleV2Id.fromMap(Map<String, dynamic> json) => ScheduleV2Id(
        id: json["id"],
        hcpId: json["HcpId"],
        clinicId: json["ClinicId"] == null
            ? null
            : ClinicId.fromMap(json["ClinicId"]),
        typeConsultation: json["TypeConsultation"],
        fromDate:
            json["FromDate"] == null ? null : DateTime.parse(json["FromDate"]),
        toDate: json["ToDate"] == null ? null : DateTime.parse(json["ToDate"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "HcpId": hcpId,
        "ClinicId": clinicId?.toMap(),
        "TypeConsultation": typeConsultation,
        "FromDate":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "ToDate":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
      };
}

class ClinicId {
  ClinicId({
    this.id,
    this.clinicName,
  });

  int? id;
  String? clinicName;

  factory ClinicId.fromJson(String str) => ClinicId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClinicId.fromMap(Map<String, dynamic> json) => ClinicId(
        id: json["id"],
        clinicName: json["ClinicName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ClinicName": clinicName,
      };
}
