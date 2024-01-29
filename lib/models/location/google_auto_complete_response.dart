// To parse this JSON data, do
//
//     final googleAutoCompleteResponse = googleAutoCompleteResponseFromMap(jsonString);

import 'dart:convert';

class GoogleAutoCompleteResponse {
  GoogleAutoCompleteResponse({
    this.predictions,
    this.status,
  });

  List<Predictions>? predictions;
  String? status;

  factory GoogleAutoCompleteResponse.fromJson(String str) => GoogleAutoCompleteResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoogleAutoCompleteResponse.fromMap(Map<String, dynamic> json) => GoogleAutoCompleteResponse(
    predictions: json["predictions"] == null ? null : List<Predictions>.from(json["predictions"].map((x) => Predictions.fromMap(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "predictions": predictions == null ? null : List<dynamic>.from(predictions!.map((x) => x.toMap())),
    "status": status == null ? null : status,
  };
}

class Predictions {
  Predictions({
    this.description,
    this.distanceMeters,
    this.id,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  String? description;
  int? distanceMeters;
  dynamic id;
  List<MatchedSubstring>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Term>? terms;
  List<String>? types;

  factory Predictions.fromJson(String str) => Predictions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Predictions.fromMap(Map<String, dynamic> json) => Predictions(
    description: json["description"] == null ? null : json["description"],
    distanceMeters: json["distance_meters"] == null ? null : json["distance_meters"],
    id: json["id"],
    matchedSubstrings: json["matched_substrings"] == null ? null : List<MatchedSubstring>.from(json["matched_substrings"].map((x) => MatchedSubstring.fromMap(x))),
    placeId: json["place_id"] == null ? null : json["place_id"],
    reference: json["reference"] == null ? null : json["reference"],
    structuredFormatting: json["structured_formatting"] == null ? null : StructuredFormatting.fromMap(json["structured_formatting"]),
    terms: json["terms"] == null ? null : List<Term>.from(json["terms"].map((x) => Term.fromMap(x))),
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "description": description == null ? null : description,
    "distance_meters": distanceMeters == null ? null : distanceMeters,
    "id": id,
    "matched_substrings": matchedSubstrings == null ? null : List<dynamic>.from(matchedSubstrings!.map((x) => x.toMap())),
    "place_id": placeId == null ? null : placeId,
    "reference": reference == null ? null : reference,
    "structured_formatting": structuredFormatting == null ? null : structuredFormatting!.toMap(),
    "terms": terms == null ? null : List<dynamic>.from(terms!.map((x) => x.toMap())),
    "types": types == null ? null : List<dynamic>.from(types!.map((x) => x)),
  };
}

class MatchedSubstring {
  MatchedSubstring({
    this.length,
    this.offset,
  });

  int? length;
  int? offset;

  factory MatchedSubstring.fromJson(String str) => MatchedSubstring.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MatchedSubstring.fromMap(Map<String, dynamic> json) => MatchedSubstring(
    length: json["length"] == null ? null : json["length"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toMap() => {
    "length": length == null ? null : length,
    "offset": offset == null ? null : offset,
  };
}

class StructuredFormatting {
  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  String? mainText;
  List<MatchedSubstring>? mainTextMatchedSubstrings;
  String? secondaryText;

  factory StructuredFormatting.fromJson(String str) => StructuredFormatting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StructuredFormatting.fromMap(Map<String, dynamic> json) => StructuredFormatting(
    mainText: json["main_text"] == null ? null : json["main_text"],
    mainTextMatchedSubstrings: json["main_text_matched_substrings"] == null ? null : List<MatchedSubstring>.from(json["main_text_matched_substrings"].map((x) => MatchedSubstring.fromMap(x))),
    secondaryText: json["secondary_text"] == null ? null : json["secondary_text"],
  );

  Map<String, dynamic> toMap() => {
    "main_text": mainText == null ? null : mainText,
    "main_text_matched_substrings": mainTextMatchedSubstrings == null ? null : List<dynamic>.from(mainTextMatchedSubstrings!.map((x) => x.toMap())),
    "secondary_text": secondaryText == null ? null : secondaryText,
  };
}

class Term {
  Term({
    this.offset,
    this.value,
  });

  int? offset;
  String? value;

  factory Term.fromJson(String str) => Term.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Term.fromMap(Map<String, dynamic> json) => Term(
    offset: json["offset"] == null ? null : json["offset"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toMap() => {
    "offset": offset == null ? null : offset,
    "value": value == null ? null : value,
  };
}
