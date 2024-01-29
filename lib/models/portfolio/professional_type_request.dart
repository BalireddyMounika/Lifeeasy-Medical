// To parse this JSON data, do
//
//     final professionalTypeRequest = professionalTypeRequestFromMap(jsonString);

import 'dart:convert';

class ProfessionalTypeRequest {
  ProfessionalTypeRequest({
    this.professionalId,
    this.professionalTypeId,
  });

  int? professionalId;
  int? professionalTypeId;

  factory ProfessionalTypeRequest.fromJson(String str) =>
      ProfessionalTypeRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfessionalTypeRequest.fromMap(Map<String, dynamic> json) =>
      ProfessionalTypeRequest(
        professionalId:
            json["ProfessionalId"] == null ? null : json["ProfessionalId"],
        professionalTypeId: json["ProfessionalTypeId"] == null
            ? null
            : json["ProfessionalTypeId"],
      );

  Map<String, dynamic> toMap() => {
        "ProfessionalId": professionalId == null ? null : professionalId,
        "ProfessionalTypeId":
            professionalTypeId == null ? null : professionalTypeId,
      };
}
