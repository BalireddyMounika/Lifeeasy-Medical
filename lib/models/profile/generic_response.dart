// To parse this JSON data, do
//
//     final genericResponse = genericResponseFromMap(jsonString);
import 'dart:convert';

class GenericResponse {
  GenericResponse({
    this.message,
    this.result,
    this.hasError,
    this.statusCode,
  });

  String? message;
  dynamic result;
  bool? hasError = false;
  int? statusCode;

  factory GenericResponse.fromJson(String str) => GenericResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenericResponse.fromMap(Map<String, dynamic> json) => GenericResponse(
    message: json["Message"] == null ? null : json["Message"],
    result: json["Result"],
    hasError: json["HasError"] == null ? null : json["HasError"],
    statusCode: json["Status"] == null ? null : json["Status"],
  );

  Map<String, dynamic> toMap() => {
    "Message": message == null ? null : message,
    "Result":  result,
    "HasError": hasError == null ? null : hasError,
    "Status": statusCode == null ? null : statusCode,
  };
}
