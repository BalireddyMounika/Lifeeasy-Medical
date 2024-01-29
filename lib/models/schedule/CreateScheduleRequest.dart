class CreateScheduleRequest {
  CreateScheduleRequest({
    this.hcpId,
    this.clinicId,
    this.typeConsultation,
    this.fromDate,
    this.toDate,
  });

  CreateScheduleRequest.fromJson(dynamic json) {
    hcpId = json['HcpId'];
    clinicId = json['ClinicId'];
    typeConsultation = json['TypeConsultation'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
  }
  int? hcpId;
  int? clinicId;
  String? typeConsultation;
  String? fromDate;
  String? toDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['HcpId'] = hcpId;
    map['ClinicId'] = clinicId;
    map['TypeConsultation'] = typeConsultation;
    map['FromDate'] = fromDate;
    map['ToDate'] = toDate;
    return map;
  }
}
