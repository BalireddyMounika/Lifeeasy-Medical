// To parse this JSON data, do
//
//     final pharmacyOrderResponse = pharmacyOrderResponseFromMap(jsonString);

import 'dart:convert';

class PharmacyOrderResponse {
  PharmacyOrderResponse({
    this.id,
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
    this.currentDate,
    this.medicine,
  });

  int? id;
  int? userId;
  int? professionalId;
  String? userAddress;
  String? username;
  String? userPhoneNumber;
  int? userSecondaryPhoneNumber;
  PharmacyId? pharmacyId;
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
  String? currentDate;
  List<Medicine>? medicine;

  factory PharmacyOrderResponse.fromJson(String str) => PharmacyOrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PharmacyOrderResponse.fromMap(Map<String, dynamic> json) => PharmacyOrderResponse(
    id: json["id"] == null ? null : json["id"],
    userId: json["UserId"] == null ? null : json["UserId"],
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
    userAddress: json["UserAddress"] == null ? null : json["UserAddress"],
    username: json["Username"] == null ? null :json["Username"],
    userPhoneNumber: json["UserPhoneNumber"] == null ? null : json["UserPhoneNumber"],
    userSecondaryPhoneNumber: json["UserSecondaryPhoneNumber"] == null ? null : json["UserSecondaryPhoneNumber"],
    pharmacyId: json["PharmacyId"] == null ? null : PharmacyId?.fromMap(json["PharmacyId"]),
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
    currentDate: json["CurrentDate"] == null ? null :json["CurrentDate"],
    medicine: json["Medicine"] == null ? null : List<Medicine>.from(json["Medicine"].map((x) => Medicine.fromMap(x))),

  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "UserId": userId == null ? null : userId,
    "ProfessionalId": professionalId == null ? null : professionalId,
    "UserAddress": userAddress == null ? null : userAddress,
    "Username" : username == null ? null :username,
    "UserPhoneNumber": userPhoneNumber == null ? null : userPhoneNumber,
    "UserSecondaryPhoneNumber": userSecondaryPhoneNumber == null ? null : userSecondaryPhoneNumber,
    "PharmacyId": pharmacyId == null ? null : pharmacyId?.toMap(),
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
    "CurrentDate": currentDate == null ? null : currentDate,
    "Medicine": medicine == null ? null : List<dynamic>.from(medicine!.map((x) => x.toMap())),

  };
}
class Medicine {
  Medicine({
    this.orderId,
    this.medicine,
    this.power,
    this.quantity,
    this.cost,
    this.discount,
    this.total,
    this.specialInstructionsForMedicine,
  });

  int? orderId;
  String? medicine;
  String? power;
  int? quantity;
  int? cost;
  String? discount;
  String? total;
  String? specialInstructionsForMedicine;

  factory Medicine.fromJson(String str) => Medicine.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Medicine.fromMap(Map<String, dynamic> json) => Medicine(
    orderId: json["OrderId"] == null ? null : json["OrderId"],
    medicine: json["Medicine"] == null ? null : json["Medicine"],
    power: json["Power"] == null ? null : json["Power"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    cost: json["Cost"] == null ? null : json["Cost"],
    discount: json["Discount"] == null ? null : json["Discount"],
    total: json["Total"] == null ? null : json["Total"],
    specialInstructionsForMedicine: json["Special_Instructions_For_Medicine"] == null ? null : json["Special_Instructions_For_Medicine"],
  );

  Map<String, dynamic> toMap() => {
    "OrderId": orderId == null ? null : orderId,
    "Medicine": medicine == null ? null : medicine,
    "Power": power == null ? null : power,
    "Quantity": quantity == null ? null : quantity,
    "Cost": cost == null ? null : cost,
    "Discount": discount == null ? null : discount,
    "Total": total == null ? null : total,
    "Special_Instructions_For_Medicine": specialInstructionsForMedicine == null ? null : specialInstructionsForMedicine,
  };
}
class PharmacyId {
  PharmacyId({
    this.id,
    this.pharmacyName,
    this.pharmacyRegistrationNumber,
    this.pharmacyEmailId,
    this.pharmacyContactNumber,
    this.pharmacyWebsiteUrl,
    this.pharmacyOpenTime,
    this.pharmacyCloseTime,
    this.uploadPharmacyImages,
    this.pharmacyAddress,
    this.pharmacyStatus,
    this.uploadRegistrationDocuments,
    this.authorizedLicenseNumber,
    this.authorizedFirstName,
    this.authorizedLastName,
    this.authorizedEmailId,
    this.authorizedMobileNumber,
    this.deviceToken,
    this.professionalId,
  });

  int? id;
  String? pharmacyName;
  String? pharmacyRegistrationNumber;
  String? pharmacyEmailId;
  String? pharmacyContactNumber;
  String? pharmacyWebsiteUrl;
  String? pharmacyOpenTime;
  String? pharmacyCloseTime;
  String? uploadPharmacyImages;
  String? pharmacyAddress;
  String? pharmacyStatus;
  String? uploadRegistrationDocuments;
  String? authorizedLicenseNumber;
  String? authorizedFirstName;
  String? authorizedLastName;
  String? authorizedEmailId;
  String? authorizedMobileNumber;
  String? deviceToken;
  int? professionalId;

  factory PharmacyId.fromJson(String str) => PharmacyId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PharmacyId.fromMap(Map<String, dynamic> json) => PharmacyId(
    id: json["id"] == null ? null : json["id"],
    pharmacyName: json["PharmacyName"] == null ? null : json["PharmacyName"],
    pharmacyRegistrationNumber: json["PharmacyRegistrationNumber"] == null ? null : json["PharmacyRegistrationNumber"],
    pharmacyEmailId: json["PharmacyEmailId"] == null ? null : json["PharmacyEmailId"],
    pharmacyContactNumber: json["PharmacyContactNumber"] == null ? null : json["PharmacyContactNumber"],
    pharmacyWebsiteUrl: json["PharmacyWebsiteUrl"] == null ? null : json["PharmacyWebsiteUrl"],
    pharmacyOpenTime: json["Pharmacy_OpenTime"] == null ? null : json["Pharmacy_OpenTime"],
    pharmacyCloseTime: json["Pharmacy_CloseTime"] == null ? null : json["Pharmacy_CloseTime"],
    uploadPharmacyImages: json["UploadPharmacyImages"] == null ? null : json["UploadPharmacyImages"],
    pharmacyAddress: json["Pharmacy_Address"] == null ? null : json["Pharmacy_Address"],
    pharmacyStatus: json["Pharmacy_Status"] == null ? null : json["Pharmacy_Status"],
    uploadRegistrationDocuments: json["UploadRegistrationDocuments"] == null ? null : json["UploadRegistrationDocuments"],
    authorizedLicenseNumber: json["Authorized_LicenseNumber"] == null ? null : json["Authorized_LicenseNumber"],
    authorizedFirstName: json["Authorized_FirstName"] == null ? null : json["Authorized_FirstName"],
    authorizedLastName: json["Authorized_LastName"] == null ? null : json["Authorized_LastName"],
    authorizedEmailId: json["Authorized_EmailId"] == null ? null : json["Authorized_EmailId"],
    authorizedMobileNumber: json["Authorized_MobileNumber"] == null ? null : json["Authorized_MobileNumber"],
    deviceToken: json["DeviceToken"] == null ? null : json["DeviceToken"],
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "PharmacyName": pharmacyName == null ? null : pharmacyName,
    "PharmacyRegistrationNumber": pharmacyRegistrationNumber == null ? null : pharmacyRegistrationNumber,
    "PharmacyEmailId": pharmacyEmailId == null ? null : pharmacyEmailId,
    "PharmacyContactNumber": pharmacyContactNumber == null ? null : pharmacyContactNumber,
    "PharmacyWebsiteUrl": pharmacyWebsiteUrl == null ? null : pharmacyWebsiteUrl,
    "Pharmacy_OpenTime": pharmacyOpenTime == null ? null : pharmacyOpenTime,
    "Pharmacy_CloseTime": pharmacyCloseTime == null ? null : pharmacyCloseTime,
    "UploadPharmacyImages": uploadPharmacyImages == null ? null : uploadPharmacyImages,
    "Pharmacy_Address": pharmacyAddress == null ? null : pharmacyAddress,
    "Pharmacy_Status": pharmacyStatus == null ? null : pharmacyStatus,
    "UploadRegistrationDocuments": uploadRegistrationDocuments == null ? null : uploadRegistrationDocuments,
    "Authorized_LicenseNumber": authorizedLicenseNumber == null ? null : authorizedLicenseNumber,
    "Authorized_FirstName": authorizedFirstName == null ? null : authorizedFirstName,
    "Authorized_LastName": authorizedLastName == null ? null : authorizedLastName,
    "Authorized_EmailId": authorizedEmailId == null ? null : authorizedEmailId,
    "Authorized_MobileNumber": authorizedMobileNumber == null ? null : authorizedMobileNumber,
    "DeviceToken": deviceToken == null ? null : deviceToken,
    "ProfessionalId": professionalId == null ? null : professionalId,
  };
}
