// To parse this JSON data, do
//
//     final personalProfileRequest = personalProfileRequestFromMap(jsonString);

import 'dart:convert';

class PersonalProfileRequest {
  PersonalProfileRequest({
    this.hcpId,
    this.state,
    this.city,
    this.address,
    this.pincode,
    this.timezone,
    this.profilePicture,
    this.id
  });

  int? id;
  int? hcpId;
  String? state;
  String? city;
  String? address;
  String? pincode;
  String? timezone;
  String? profilePicture;

  factory PersonalProfileRequest.fromJson(String str) => PersonalProfileRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalProfileRequest.fromMap(Map<String, dynamic> json) => PersonalProfileRequest(
    id:json["id"] == null ? null :json["id"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    state: json["State"] == null ? null : json["State"],
    city: json["City"] == null ? null : json["City"],
    address: json["Address"] == null ? null : json["Address"],
    pincode: json["Pincode"] == null ? null : json["Pincode"],
    timezone: json["Timezone"] == null ? null : json["Timezone"],
    profilePicture: json["ProfilePicture"] == null ? null : json["ProfilePicture"]
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "State": state == null ? null : state,
    "City": city == null ? null : city,
    "Address": address == null ? null : address,
    "Pincode": pincode == null ? null : pincode,
    "Timezone": timezone == null ? null : timezone,
    "ProfilePicture": profilePicture ==null ? null :profilePicture
  };
}
