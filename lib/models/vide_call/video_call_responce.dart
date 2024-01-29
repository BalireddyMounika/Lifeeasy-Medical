// To parse this JSON data, do
//
//     final videoCallRequest = videoCallRequestFromMap(jsonString);

import 'dart:convert';

class VideoCallRequest {
  VideoCallRequest({
    this.title,
    this.body,
    this.channelName,
    this.userId,
    this.appointmentId,
  });

  String? title;
  String? body;
  String? channelName;
  int? userId;
  int? appointmentId;

  factory VideoCallRequest.fromJson(String str) => VideoCallRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoCallRequest.fromMap(Map<String, dynamic> json) => VideoCallRequest(
    title: json["Title"] == null ? null : json["Title"],
    body: json["Body"] == null ? null : json["Body"],
    channelName: json["ChannelName"] == null ? null : json["ChannelName"],
    userId: json["UserId"] == null ? null : json["UserId"],
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
  );

  Map<String, dynamic> toMap() => {
    "Title": title == null ? null : title,
    "Body": body == null ? null : body,
    "ChannelName": channelName == null ? null : channelName,
    "UserId": userId == null ? null : userId,
    "AppointmentId": appointmentId == null ? null : appointmentId,
  };
}
