class SlotTimingRequest {
  SlotTimingRequest({
    this.scheduleV2Id,
    this.hcpId,
    this.scheduleName,
    this.slotTimings,
    this.fees,
    this.fromTime,
    this.toTime,
  });

  SlotTimingRequest.fromJson(dynamic json) {
    scheduleV2Id = json['ScheduleV2Id'];
    hcpId = json['HcpId'];
    scheduleName = json['ScheduleName'];
    slotTimings = json['SlotTimings'];
    fees = json['Fees'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
  }
  int? scheduleV2Id;
  int? hcpId;
  String? scheduleName;
  int? slotTimings;
  int? fees;
  String? fromTime;
  String? toTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ScheduleV2Id'] = scheduleV2Id;
    map['HcpId'] = hcpId;
    map['ScheduleName'] = scheduleName;
    map['SlotTimings'] = slotTimings;
    map['Fees'] = fees;
    map['FromTime'] = fromTime;
    map['ToTime'] = toTime;
    return map;
  }
}
