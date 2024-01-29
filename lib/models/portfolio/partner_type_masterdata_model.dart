// To parse this JSON data, do
//
//     final partnerTypeResponseModel = partnerTypeResponseModelFromMap(jsonString);

import 'dart:convert';

class PartnerTypeMasterDataModel {
  PartnerTypeMasterDataModel({
    this.id,
    this.partnerType,
  });

  int? id;
  String? partnerType;

  factory PartnerTypeMasterDataModel.fromJson(String str) => PartnerTypeMasterDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PartnerTypeMasterDataModel.fromMap(Map<String, dynamic> json) => PartnerTypeMasterDataModel(
    id: json["id"] == null ? null : json["id"],
    partnerType: json["PartnerType"] == null ? null : json["PartnerType"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "PartnerType": partnerType == null ? null : partnerType,
  };
}
