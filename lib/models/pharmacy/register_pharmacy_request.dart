// To parse this JSON data, do
//
//     final registerPharmacyRequest = registerPharmacyRequestFromMap(jsonString);

import 'dart:convert';

class RegisterPharmacyRequest {
 // RegisterPharmacyRequest.flag();
  RegisterPharmacyRequest({
    this.pharmacyName,
    this.pharmacyRegistrationNumber,
    this.pharmacyEmailId,
    this.pharmacyContactNumber,
    this.pharmacyWebsiteUrl,
    this.pharmacyOpenTime,
    this.pharmacyCloseTime,
    this.uploadPharmacyImages,
    this.uploadRegistrationDocuments,
    this.authorizedLicenseNumber,
    this.authorizedFirstName,
    this.authorizedLastName,
    this.authorizedEmailId,
    this.authorizedMobileNumber,
    this.deviceToken,
    this.professionalId,
    this.partnerTypeId,
    this.pharmacyAddress,
    this.pharmacyStatus,
    this.id

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
  String? uploadRegistrationDocuments;
  String? authorizedLicenseNumber;
  String? authorizedFirstName;
  String? authorizedLastName;
  String? authorizedEmailId;
  String? authorizedMobileNumber;
  String? deviceToken;
  int? professionalId;
  int? partnerTypeId;
  String? pharmacyAddress;
  String? pharmacyStatus;


  factory RegisterPharmacyRequest.fromJson(String str) => RegisterPharmacyRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterPharmacyRequest.fromMap(Map<String, dynamic> json) => RegisterPharmacyRequest(
    pharmacyName: json["PharmacyName"] == null ? null : json["PharmacyName"],
    pharmacyRegistrationNumber: json["PharmacyRegistrationNumber"] == null ? null : json["PharmacyRegistrationNumber"],
    pharmacyEmailId: json["PharmacyEmailId"] == null ? null : json["PharmacyEmailId"],
    pharmacyContactNumber: json["PharmacyContactNumber"] == null ? null : json["PharmacyContactNumber"],
    pharmacyWebsiteUrl: json["PharmacyWebsiteUrl"] == null ? null : json["PharmacyWebsiteUrl"],
    pharmacyOpenTime: json["Pharmacy_OpenTime"] == null ? null : json["Pharmacy_OpenTime"],
    pharmacyCloseTime: json["Pharmacy_CloseTime"] == null ? null : json["Pharmacy_CloseTime"],
    uploadPharmacyImages: json["UploadPharmacyImages"] == null ? null : json["UploadPharmacyImages"],
    uploadRegistrationDocuments: json["UploadRegistrationDocuments"] == null ? null : json["UploadRegistrationDocuments"],
    authorizedLicenseNumber: json["Authorized_LicenseNumber"] == null ? null : json["Authorized_LicenseNumber"],
    authorizedFirstName: json["Authorized_FirstName"] == null ? null : json["Authorized_FirstName"],
    authorizedLastName: json["Authorized_LastName"] == null ? null : json["Authorized_LastName"],
    authorizedEmailId: json["Authorized_EmailId"] == null ? null : json["Authorized_EmailId"],
    authorizedMobileNumber: json["Authorized_MobileNumber"] == null ? null : json["Authorized_MobileNumber"],
    deviceToken: json["DeviceToken"] == null ? null : json["DeviceToken"],
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
    partnerTypeId: json["PartnerTypeId"] == null ? null : json["PartnerTypeId"],
    pharmacyAddress: json["Pharmacy_Address"] == null ? null :json["Pharmacy_Address"],
    pharmacyStatus: json["Pharmacy_Status"] == null ? null : json["Pharmacy_Status"],
    id : json["id"]

  );

  Map<String, dynamic> toMap() => {
    "PharmacyName": pharmacyName == null ? null : pharmacyName,
    "PharmacyRegistrationNumber": pharmacyRegistrationNumber == null ? null : pharmacyRegistrationNumber,
    "PharmacyEmailId": pharmacyEmailId == null ? null : pharmacyEmailId,
    "PharmacyContactNumber": pharmacyContactNumber == null ? null : pharmacyContactNumber,
    "PharmacyWebsiteUrl": pharmacyWebsiteUrl == null ? null : pharmacyWebsiteUrl,
    "Pharmacy_OpenTime": pharmacyOpenTime == null ? null : pharmacyOpenTime,
    "Pharmacy_CloseTime": pharmacyCloseTime == null ? null : pharmacyCloseTime,
    "UploadPharmacyImages": uploadPharmacyImages == null ? null : uploadPharmacyImages,
    "UploadRegistrationDocuments": uploadRegistrationDocuments == null ? null : uploadRegistrationDocuments,
    "Authorized_LicenseNumber": authorizedLicenseNumber == null ? null : authorizedLicenseNumber,
    "Authorized_FirstName": authorizedFirstName == null ? null : authorizedFirstName,
    "Authorized_LastName": authorizedLastName == null ? null : authorizedLastName,
    "Authorized_EmailId": authorizedEmailId == null ? null : authorizedEmailId,
    "Authorized_MobileNumber": authorizedMobileNumber == null ? null : authorizedMobileNumber,
    "DeviceToken": deviceToken == null ? null : deviceToken,
    "ProfessionalId": professionalId == null ? null : professionalId,
    "PartnerTypeId": partnerTypeId == null ? null : partnerTypeId,
    "Pharmacy_Address" : pharmacyAddress ==null ? null :pharmacyAddress,
    "Pharmacy_Status" : pharmacyStatus == null ? null :pharmacyStatus,

  };
}
