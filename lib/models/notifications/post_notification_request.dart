// To parse this JSON data, do
//
//     final postNotificationRequest = postNotificationRequestFromMap(jsonString);

import 'dart:convert';

PostNotificationRequest postNotificationRequestFromMap(String str) => PostNotificationRequest.fromMap(json.decode(str));

String postNotificationRequestToMap(PostNotificationRequest data) => json.encode(data.toMap());

class PostNotificationRequest {
  PostNotificationRequest({
    this.userId,
    this.hcpId,
    this.title,
    this.body,
  });

  int? userId;
  int ?hcpId;
  String? title;
  String ?body;
  factory PostNotificationRequest.fromJson(String str) =>
      PostNotificationRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory PostNotificationRequest.fromMap(Map<String, dynamic> json) => PostNotificationRequest(
    userId: json["UserId"] == null ? null : json["UserId"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    title: json["Title"] == null ? null : json["Title"],
    body: json["Body"] == null ? null : json["Body"],
  );

  Map<String, dynamic> toMap() => {
    "UserId": userId == null ? null : userId,
    "HcpId": hcpId == null ? null : hcpId,
    "Title": title == null ? null : title,
    "Body": body == null ? null : body,
  };

}
