// To parse this JSON data, do
//
//     final getBankDetailsResponse = getBankDetailsResponseFromMap(jsonString);

import 'dart:convert';

GetBankDetailsResponse getBankDetailsResponseFromMap(String str) => GetBankDetailsResponse.fromMap(json.decode(str));

String getBankDetailsResponseToMap(GetBankDetailsResponse data) => json.encode(data.toMap());

class GetBankDetailsResponse {
  GetBankDetailsResponse({
    this.hcpId,
    this.bankAccountNumber,
    this.bankName,
    this.ifscCode,
    this.bankBranch,
    this.accountNumber,
    this.panNumber,
    this.uploadPancard,
    this.uploadDocuments,
    this.remarks,
  });

  int? hcpId;
  String? bankAccountNumber;
  String? bankName;
  String? ifscCode;
  String? bankBranch;
  String? accountNumber;
  String ?panNumber;
  String ?uploadPancard;
  String ?uploadDocuments;
  String ?remarks;

  factory GetBankDetailsResponse.fromMap(Map<String, dynamic> json) => GetBankDetailsResponse(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    bankAccountNumber: json["BankAccountNumber"] == null ? null : json["BankAccountNumber"],
    bankName: json["BankName"] == null ? null : json["BankName"],
    ifscCode: json["IFSCCode"] == null ? null : json["IFSCCode"],
    bankBranch: json["BankBranch"] == null ? null : json["BankBranch"],
    accountNumber: json["AccountNumber"] == null ? null : json["AccountNumber"],
    panNumber: json["PanNumber"] == null ? null : json["PanNumber"],
    uploadPancard: json["UploadPancard"] == null ? null : json["UploadPancard"],
    uploadDocuments: json["UploadDocuments"] == null ? null : json["UploadDocuments"],
    remarks: json["Remarks"] == null ? null : json["Remarks"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "BankAccountNumber": bankAccountNumber == null ? null : bankAccountNumber,
    "BankName": bankName == null ? null : bankName,
    "IFSCCode": ifscCode == null ? null : ifscCode,
    "BankBranch": bankBranch == null ? null : bankBranch,
    "AccountNumber": accountNumber == null ? null : accountNumber,
    "PanNumber": panNumber == null ? null : panNumber,
    "UploadPancard": uploadPancard == null ? null : uploadPancard,
    "UploadDocuments": uploadDocuments == null ? null : uploadDocuments,
    "Remarks": remarks == null ? null : remarks,
  };
}
