// To parse this JSON data, do
//
//     final locationResponseModel = locationResponseModelFromMap(jsonString);

import 'dart:convert';

class LocationResponseModel {
  LocationResponseModel({
    this.lat,
    this.long,
    this.address,
    this.city,
    this.country,
    this.pinCode,
    this.state,
  });

  double? lat;
  double? long;
  String? address;
  String? city;
  String? country;
  int? pinCode;
  String? state;

  factory LocationResponseModel.fromJson(String str) => LocationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationResponseModel.fromMap(Map<String, dynamic> json) => LocationResponseModel(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    long: json["long"] == null ? null : json["long"].toDouble(),
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    country: json["country"] == null ? null : json["country"],
    pinCode: json["pinCode"] == null ? null : json["pinCode"],
    state: json["state"] == null ? null : json["state"],
  );

  Map<String, dynamic> toMap() => {
    "lat": lat == null ? null : lat,
    "long": long == null ? null : long,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "country": country == null ? null : country,
    "pinCode": pinCode == null ? null : pinCode,
    "state": state == null ? null : state,
  };
}
