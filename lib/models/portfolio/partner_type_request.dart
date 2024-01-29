// To parse this JSON data, do
//
//     final partnerTypeRequest = partnerTypeRequestFromMap(jsonString);

import 'dart:convert';

class PartnerTypeRequest {
  PartnerTypeRequest({
    this.professionalId,
    this.partnerId,
  });

  int? professionalId;
  int? partnerId;

  factory PartnerTypeRequest.fromJson(String str) => PartnerTypeRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PartnerTypeRequest.fromMap(Map<String, dynamic> json) => PartnerTypeRequest(
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
    partnerId: json["PartnerId"] == null ? null : json["PartnerId"],
  );

  Map<String, dynamic> toMap() => {
    "ProfessionalId": professionalId == null ? null : professionalId,
    "PartnerId": partnerId == null ? null : partnerId,
  };
}
