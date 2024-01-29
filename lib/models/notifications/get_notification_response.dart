// To parse this JSON data, do
//
//     final getNotificationResponse = getNotificationResponseFromMap(jsonString);

import 'dart:convert';

GetNotificationResponse getNotificationResponseFromMap(String str) => GetNotificationResponse.fromMap(json.decode(str));

String getNotificationResponseToMap(GetNotificationResponse data) => json.encode(data.toMap());

class GetNotificationResponse {
  GetNotificationResponse({
    this.id,
    this.userId,
    this.hcpId,
    this.title,
    this.body,
    this.currentDate,
  });

  int? id;
  int ?userId;
  int ?hcpId;
  String? title;
  String? body;
  String? currentDate;

  factory GetNotificationResponse.fromMap(Map<String, dynamic> json) => GetNotificationResponse(
    id: json["id"] == null ? null : json["id"],
    userId: json["UserId"] == null ? null : json["UserId"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    title: json["Title"] == null ? null : json["Title"],
    body: json["Body"] == null ? null : json["Body"],
    currentDate: json["CurrentDate"] == null ? null :json["CurrentDate"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "UserId": userId == null ? null : userId,
    "HcpId": hcpId == null ? null : hcpId,
    "Title": title == null ? null : title,
    "Body": body == null ? null : body,
    "CurrentDate": currentDate == null ? null : currentDate,
  };
}
