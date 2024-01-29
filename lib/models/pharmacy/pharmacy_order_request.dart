// To parse this JSON data, do
//
//     final pharmacyOrdersRequest = pharmacyOrdersRequestFromMap(jsonString);

import 'dart:convert';

class PharmacyOrdersRequest {
  PharmacyOrdersRequest({
    this.userId,
    this.professionalId,
    this.userAddress,
    this.username,
    this.userPhoneNumber,
    this.userSecondaryPhoneNumber,
    this.pharmacyId,
    this.chronicIllnessQualifier,
    this.uploadDocument,
    this.prescribedBy,
    this.deliveredDate,
    this.deliveredTime,
    this.itemQuantity,
    this.orderStatus,
    this.paymentStatus,
    this.transactionId,
    this.total,
  });

  int? userId;
  int? professionalId;
  String? userAddress;
  String? username;
  String? userPhoneNumber;
  int? userSecondaryPhoneNumber;
  int? pharmacyId;
  String? chronicIllnessQualifier;
  String? uploadDocument;
  String? prescribedBy;
  String? deliveredDate;
  String? deliveredTime;
  int? itemQuantity;
  String? orderStatus;
  String? paymentStatus;
  String? transactionId;
  int? total;

  factory PharmacyOrdersRequest.fromJson(String str) => PharmacyOrdersRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PharmacyOrdersRequest.fromMap(Map<String, dynamic> json) => PharmacyOrdersRequest(
    userId: json["UserId"] == null ? null : json["UserId"],
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
    userAddress: json["UserAddress"] == null ? null : json["UserAddress"],
    username: json["Username"] == null ? null :json["Username"],
    userPhoneNumber: json["UserPhoneNumber"] == null ? null : json["UserPhoneNumber"],
    userSecondaryPhoneNumber: json["UserSecondaryPhoneNumber"] == null ? null : json["UserSecondaryPhoneNumber"],
    pharmacyId: json["PharmacyId"] == null ? null : json["PharmacyId"],
    chronicIllnessQualifier: json["ChronicIllnessQualifier"] == null ? null : json["ChronicIllnessQualifier"],
    uploadDocument: json["UploadDocument"] == null ? null : json["UploadDocument"],
    prescribedBy: json["PrescribedBy"] == null ? null : json["PrescribedBy"],
    deliveredDate: json["DeliveredDate"] == null ? null : json["DeliveredDate"],
    deliveredTime: json["DeliveredTime"] == null ? null : json["DeliveredTime"],
    itemQuantity: json["ItemQuantity"] == null ? null : json["ItemQuantity"],
    orderStatus: json["OrderStatus"] == null ? null : json["OrderStatus"],
    paymentStatus: json["PaymentStatus"] == null ? null : json["PaymentStatus"],
    transactionId: json["TransactionId"] == null ? null : json["TransactionId"],
    total: json["Total"] == null ? null : json["Total"],
  );

  Map<String, dynamic> toMap() => {
    "UserId": userId == null ? null : userId,
    "ProfessionalId": professionalId == null ? null : professionalId,
    "UserAddress": userAddress == null ? null : userAddress,
    "Username" :username == null ? null :username,
    "UserPhoneNumber": userPhoneNumber == null ? null : userPhoneNumber,
    "UserSecondaryPhoneNumber": userSecondaryPhoneNumber == null ? null : userSecondaryPhoneNumber,
    "PharmacyId": pharmacyId == null ? null : pharmacyId,
    "ChronicIllnessQualifier": chronicIllnessQualifier == null ? null : chronicIllnessQualifier,
    "UploadDocument": uploadDocument == null ? null : uploadDocument,
    "PrescribedBy": prescribedBy == null ? null : prescribedBy,
    "DeliveredDate": deliveredDate == null ? null : deliveredDate,
    "DeliveredTime": deliveredTime == null ? null : deliveredTime,
    "ItemQuantity": itemQuantity == null ? null : itemQuantity,
    "OrderStatus": orderStatus == null ? null : orderStatus,
    "PaymentStatus": paymentStatus == null ? null : paymentStatus,
    "TransactionId": transactionId == null ? null : transactionId,
    "Total": total == null ? null : total,
  };
}
