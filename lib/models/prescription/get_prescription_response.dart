// To parse this JSON data, do
//
//     final getPrescriptionResponse = getPrescriptionResponseFromMap(jsonString);

import 'dart:convert';

GetPrescriptionResponse getPrescriptionResponseFromMap(String str) => GetPrescriptionResponse.fromMap(json.decode(str));

String getPrescriptionResponseToMap(GetPrescriptionResponse data) => json.encode(data.toMap());

class GetPrescriptionResponse {
  GetPrescriptionResponse({
    this.hcpId,
    this.drugName,
    this.quantity,
    this.dosages,
    this.frequency,
    this.route,
    this.instructions,
    this.nextFollowUpDate,
    this.userId,
  });

  Id? hcpId;
  String? drugName;
  int? quantity;
  dynamic dosages;
  int? frequency;
  dynamic route;
  dynamic instructions;
  dynamic nextFollowUpDate;

  Id? userId;

  factory GetPrescriptionResponse.fromMap(Map<String, dynamic> json) => GetPrescriptionResponse(
    hcpId: json["HcpId"] == null ? null : Id.fromMap(json["HcpId"]),
    drugName: json["DrugName"] == null ? null : json["DrugName"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    dosages: json["Dosages"],
    frequency: json["Frequency"] == null ? null : json["Frequency"],
    route: json["Route"],
    instructions: json["Instructions"],
    nextFollowUpDate: json["NextFollowUp_Date"],
    userId: json["UserId"] == null ? null : Id.fromMap(json["UserId"]),
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId!.toMap(),
    "DrugName": drugName == null ? null : drugName,
    "Quantity": quantity == null ? null : quantity,
    "Dosages": dosages,
    "Frequency": frequency == null ? null : frequency,
    "Route": route,
    "Instructions": instructions,
    "NextFollowUp_Date": nextFollowUpDate,
    "UserId": userId == null ? null : userId!.toMap(),
  };
}

class Id {
  Id({
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.mobileNumber,
    this.profile,
  });

  String?firstname;
  String? lastname;
  String? email;
  String? username;
  String? mobileNumber;
 dynamic profile;

  factory Id.fromMap(Map<String, dynamic> json) => Id(
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    username: json["Username"] == null ? null : json["Username"],
    profile: json["Profile"] == null ? null : json["Profile"],
    mobileNumber: json["MobileNumber"] == null ? null : json["MobileNumber"],
  );

  Map<String, dynamic> toMap() => {
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
    "Username": username == null ? null : username,
    "MobileNumber": mobileNumber == null ? null : mobileNumber,
    "Profile": profile == null ? null :profile,
  };
}
