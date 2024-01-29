// To parse this JSON data, do
//
//     final personalProfileUpdateRequest = personalProfileUpdateRequestFromMap(jsonString);

import 'dart:convert';

class PersonalProfileUpdateRequest {
  PersonalProfileUpdateRequest({
    this.hcpId,
    this.profilePicture,
    this.state,
    this.city,
    this.address,
    this.pincode,
    this.timezone,
  });

  HcpId ? hcpId;
  String ?profilePicture;
  String ?state;
  String? city;
  String? address;
  String? pincode;
  String? timezone;

  factory PersonalProfileUpdateRequest.fromJson(String str) => PersonalProfileUpdateRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalProfileUpdateRequest.fromMap(Map<String, dynamic> json) => PersonalProfileUpdateRequest(
    hcpId: json["HcpId"] == null ? null : HcpId.fromMap(json["HcpId"]),
    profilePicture: json["ProfilePicture"] == null ? null : json["ProfilePicture"],
    state: json["State"] == null ? null : json["State"],
    city: json["City"] == null ? null : json["City"],
    address: json["Address"] == null ? null : json["Address"],
    pincode: json["Pincode"] == null ? null : json["Pincode"],
    timezone: json["Timezone"] == null ? null : json["Timezone"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId!.toMap(),
    "ProfilePicture": profilePicture == null ? null : profilePicture,
    "State": state == null ? null : state,
    "City": city == null ? null : city,
    "Address": address == null ? null : address,
    "Pincode": pincode == null ? null : pincode,
    "Timezone": timezone == null ? null : timezone,
  };
}

class HcpId {
  HcpId({
    this.firstname,
    this.lastname,
    this.email,
  });

  String? firstname;
  String? lastname;
  String? email;

  factory HcpId.fromJson(String str) => HcpId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HcpId.fromMap(Map<String, dynamic> json) => HcpId(
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
  );

  Map<String, dynamic> toMap() => {
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
  };
}
