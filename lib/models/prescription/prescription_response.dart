// To parse this JSON data, do
//
//     final getPrescriptionResponse = getPrescriptionResponseFromMap(jsonString);

import 'dart:convert';

import '../family_member/family_member_model.dart';

class PrescriptionResponse {
  PrescriptionResponse({
    this.hcpId,
    this.appointmentId,
    this.nextFollowUpDate,
    this.currentDate,
    this.signature,
    this.userId,
    this.medication,
    this.labrecordetails,
    this.familyMemberId
  });

  HcpId? hcpId;
  int? appointmentId;
  DateTime? nextFollowUpDate;
  DateTime? currentDate;
  Signature? signature;
  UserId? userId;
  List<Medication>? medication;
  List<dynamic>? labrecordetails;
  final FamilyMemberModel? familyMemberId;

  factory PrescriptionResponse.fromJson(String str) => PrescriptionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrescriptionResponse.fromMap(Map<String, dynamic> json) => PrescriptionResponse(
    hcpId: json["HcpId"] == null ? null : HcpId.fromMap(json["HcpId"]),
    appointmentId: json["AppointmentId"] == null ? null : json["AppointmentId"],
    nextFollowUpDate: json["NextFollowUpDate"] == null ? null : DateTime.parse(json["NextFollowUpDate"]),
    currentDate: json["CurrentDate"] == null ? null : DateTime.parse(json["CurrentDate"]),
    signature: json["Signature"] == null ? null : signatureValues.map[json["Signature"]],
    userId: json["UserId"] == null ? null : UserId.fromMap(json["UserId"]),
    medication: json["Medication"] == null ? null : List<Medication>.from(json["Medication"].map((x) => Medication.fromMap(x))),
    labrecordetails: json["labrecordetails"] == null ? null : List<dynamic>.from(json["labrecordetails"].map((x) => x)),
    familyMemberId: json["FamilyMemberId"] == null ? null : FamilyMemberModel.fromMap(json["FamilyMemberId"]),

  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId!.toMap(),
    "AppointmentId": appointmentId == null ? null : appointmentId,
    "NextFollowUpDate": nextFollowUpDate == null ? null : "${nextFollowUpDate!.year.toString().padLeft(4, '0')}-${nextFollowUpDate!.month.toString().padLeft(2, '0')}-${nextFollowUpDate!.day.toString().padLeft(2, '0')}",
    "CurrentDate": currentDate == null ? null : currentDate!.toIso8601String(),
    "Signature": signature == null ? null : signatureValues.reverse[signature],
    "UserId": userId == null ? null : userId!.toMap(),
    "Medication": medication == null ? null : List<dynamic>.from(medication!.map((x) => x.toMap())),
    "labrecordetails": labrecordetails == null ? null : List<dynamic>.from(labrecordetails!.map((x) => x)),
    "familyMemberId" : familyMemberId == null ? null : familyMemberId!.toMap()

  };
}

class HcpId {
  HcpId({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.password,
    this.mobileNumber,
    this.deviceToken,
    this.profile,
    this.education,
    this.professional,
    this.clinicdetails,
  });

  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? password;
  String? mobileNumber;
  String? deviceToken;
  HcpIdProfile? profile;
  Education? education;
  Professional? professional;
  List<Clinicdetail>? clinicdetails;

  factory HcpId.fromJson(String str) => HcpId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HcpId.fromMap(Map<String, dynamic> json) => HcpId(
    id: json["id"] == null ? null : json["id"],
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    username: json["Username"] == null ? null : json["Username"],
    password: json["Password"] == null ? null : json["Password"],
    mobileNumber: json["MobileNumber"] == null ? null : json["MobileNumber"],
    deviceToken: json["DeviceToken"] == null ? null : json["DeviceToken"],
    profile: json["Profile"] == null ? null : HcpIdProfile.fromMap(json["Profile"]),
    education: json["Education"] == null ? null : Education.fromMap(json["Education"]),
    professional: json["Professional"] == null ? null : Professional.fromMap(json["Professional"]),
    clinicdetails: json["Clinicdetails"] == null ? null : List<Clinicdetail>.from(json["Clinicdetails"].map((x) => Clinicdetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
    "Username": username == null ? null : username,
    "Password": password == null ? null : password,
    "MobileNumber": mobileNumber == null ? null : mobileNumber,
    "DeviceToken": deviceToken == null ? null : deviceToken,
    "Profile": profile == null ? null : profile!.toMap(),
    "Education": education == null ? null : education!.toMap(),
    "Professional": professional == null ? null : professional!.toMap(),
    "Clinicdetails": clinicdetails == null ? null : List<dynamic>.from(clinicdetails!.map((x) => x.toMap())),
  };
}

class Clinicdetail {
  Clinicdetail({
    this.id,
    this.clinicName,
    this.address,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.fee,
    this.hcpId,
  });

  int? id;
  String? clinicName;
  String? address;
  DateTime? fromDate;
  DateTime? toDate;
  String? fromTime;
  String? toTime;
  int? fee;
  int? hcpId;

  factory Clinicdetail.fromJson(String str) => Clinicdetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Clinicdetail.fromMap(Map<String, dynamic> json) => Clinicdetail(
    id: json["id"] == null ? null : json["id"],
    clinicName: json["ClinicName"] == null ? null : json["ClinicName"],
    address: json["Address"] == null ? null : json["Address"],
    fromDate: json["FromDate"] == null ? null : DateTime.parse(json["FromDate"]),
    toDate: json["ToDate"] == null ? null : DateTime.parse(json["ToDate"]),
    fromTime: json["FromTime"] == null ? null : json["FromTime"],
    toTime: json["ToTime"] == null ? null : json["ToTime"],
    fee: json["Fee"] == null ? null : json["Fee"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "ClinicName": clinicName == null ? null : clinicName,
    "Address": address == null ? null : address,
    "FromDate": fromDate == null ? null : "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "ToDate": toDate == null ? null : "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
    "FromTime": fromTime == null ? null : fromTime,
    "ToTime": toTime == null ? null : toTime,
    "Fee": fee == null ? null : fee,
    "HcpId": hcpId == null ? null : hcpId,
  };
}

class Education {
  Education({
    this.hcpId,
    this.degree,
    this.collegeUniversity,
    this.yearOfEducation,
    this.educationalLocation,
  });

  int? hcpId;
  String? degree;
  String? collegeUniversity;
  int? yearOfEducation;
  String? educationalLocation;

  factory Education.fromJson(String str) => Education.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Education.fromMap(Map<String, dynamic> json) => Education(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    degree: json["Degree"] == null ? null : json["Degree"],
    collegeUniversity: json["CollegeUniversity"] == null ? null : json["CollegeUniversity"],
    yearOfEducation: json["YearOfEducation"] == null ? null : json["YearOfEducation"],
    educationalLocation: json["EducationalLocation"] == null ? null : json["EducationalLocation"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "Degree": degree == null ? null : degree,
    "CollegeUniversity": collegeUniversity == null ? null : collegeUniversity,
    "YearOfEducation": yearOfEducation == null ? null : yearOfEducation,
    "EducationalLocation": educationalLocation == null ? null : educationalLocation,
  };
}

class Professional {
  Professional({
    this.hcpId,
    this.professionalId,
    this.professionalExperienceInYears,
    this.currentStatus,
    this.mciNumber,
    this.mciStateCouncil,
    this.specialization,
    this.areaFocusOn,
    this.patientsHandledPerDay,
    this.patientsHandledPerSlot,
    this.appointmentType,
    this.signature,
  });

  int? hcpId;
  String? professionalId;
  int? professionalExperienceInYears;
  dynamic currentStatus;
  int? mciNumber;
  String? mciStateCouncil;
  String? specialization;
  String? areaFocusOn;
  int? patientsHandledPerDay;
  int? patientsHandledPerSlot;
  List<String>? appointmentType;
  String? signature;

  factory Professional.fromJson(String str) => Professional.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Professional.fromMap(Map<String, dynamic> json) => Professional(
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
    professionalId: json["ProfessionalId"] == null ? null : json["ProfessionalId"],
    professionalExperienceInYears: json["ProfessionalExperienceInYears"] == null ? null : json["ProfessionalExperienceInYears"],
    currentStatus: json["CurrentStatus"] == null ? null : json["CurrentStatus"],
    mciNumber: json["MciNumber"] == null ? null : json["MciNumber"],
    mciStateCouncil: json["MciStateCouncil"] == null ? null : json["MciStateCouncil"],
    specialization: json["Specialization"] == null ? null : json["Specialization"],
    areaFocusOn: json["AreaFocusOn"] == null ? null : json["AreaFocusOn"],
    patientsHandledPerDay: json["PatientsHandledPerDay"] == null ? null : json["PatientsHandledPerDay"],
    patientsHandledPerSlot: json["PatientsHandledPerSlot"] == null ? null : json["PatientsHandledPerSlot"],
    appointmentType: json["AppointmentType"] == null ? null : List<String>.from(json["AppointmentType"].map((x) => x)),
    signature: json["Signature"] == null ? null : json["Signature"],
  );

  Map<String, dynamic> toMap() => {
    "HcpId": hcpId == null ? null : hcpId,
    "ProfessionalId": professionalId == null ? null : professionalId,
    "ProfessionalExperienceInYears": professionalExperienceInYears == null ? null : professionalExperienceInYears,
    "CurrentStatus": currentStatus == null ? null : currentStatus,
    "MciNumber": mciNumber == null ? null : mciNumber,
    "MciStateCouncil": mciStateCouncil == null ? null : mciStateCouncil,
    "Specialization": specialization == null ? null : specialization,
    "AreaFocusOn": areaFocusOn == null ? null : areaFocusOn,
    "PatientsHandledPerDay": patientsHandledPerDay == null ? null : patientsHandledPerDay,
    "PatientsHandledPerSlot": patientsHandledPerSlot == null ? null : patientsHandledPerSlot,
    "AppointmentType": appointmentType == null ? null : List<dynamic>.from(appointmentType!.map((x) => x)),
    "Signature": signature == null ? null : signature,
  };
}

class HcpIdProfile {
  HcpIdProfile({
    this.id,
    this.profilePicture,
    this.state,
    this.city,
    this.address,
    this.pincode,
    this.timezone,
    this.hcpId,
  });

  int? id;
  String? profilePicture;
  String? state;
  String? city;
  String? address;
  String? pincode;
  String? timezone;
  int? hcpId;

  factory HcpIdProfile.fromJson(String str) => HcpIdProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HcpIdProfile.fromMap(Map<String, dynamic> json) => HcpIdProfile(
    id: json["id"] == null ? null : json["id"],
    profilePicture: json["ProfilePicture"] == null ? null : json["ProfilePicture"],
    state: json["State"] == null ? null : json["State"],
    city: json["City"] == null ? null : json["City"],
    address: json["Address"] == null ? null : json["Address"],
    pincode: json["Pincode"] == null ? null : json["Pincode"],
    timezone: json["Timezone"] == null ? null : json["Timezone"],
    hcpId: json["HcpId"] == null ? null : json["HcpId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "ProfilePicture": profilePicture == null ? null : profilePicture,
    "State": state == null ? null : state,
    "City": city == null ? null : city,
    "Address": address == null ? null : address,
    "Pincode": pincode == null ? null : pincode,
    "Timezone": timezone == null ? null : timezone,
    "HcpId": hcpId == null ? null : hcpId,
  };
}

class Medication {
  Medication({
    this.id,
    this.drugName,
    this.quantity,
    this.dosages,
    this.route,
    this.frequency,
    this.instructions,
    this.prescriptionId,
  });

  int? id;
  String? drugName;
  int? quantity;
  String? dosages;
  String? route;
  String? frequency;
  String? instructions;
  int? prescriptionId;

  factory Medication.fromJson(String str) => Medication.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Medication.fromMap(Map<String, dynamic> json) => Medication(
    id: json["id"] == null ? null : json["id"],
    drugName: json["DrugName"] == null ? null : json["DrugName"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    dosages: json["Dosages"] == null ? null :   json["Dosages"],
    route: json["Route"] == null ? null : json["Route"],
    frequency: json["Frequency"] == null ? null : json["Frequency"],
    instructions: json["Instructions"] == null ? null : json["Instructions"],
    prescriptionId: json["PrescriptionId"] == null ? null : json["PrescriptionId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "DrugName": drugName == null ? null : drugName,
    "Quantity": quantity == null ? null : quantity,
    "Dosages": dosages == null ? null : dosages,
    "Route": route == null ? null : route,
    "Frequency": frequency == null ? null : frequency,
    "Instructions": instructions == null ? null : instructions,
    "PrescriptionId": prescriptionId == null ? null : prescriptionId,
  };
}

enum Signature { STRING, TWO_TIMES_A_DAY, ONE_AT_NIGHT }

final signatureValues = EnumValues({
  "One at night": Signature.ONE_AT_NIGHT,
  "string": Signature.STRING,
  "Two Times a day": Signature.TWO_TIMES_A_DAY
});

class UserId {
  UserId({
    this.firstname,
    this.lastname,
    this.email,
    this.profile,
    this.address,


  });

  String? firstname;
  String? lastname;
  String? email;
  UserIdProfile? profile;
  dynamic address;


  factory UserId.fromJson(String str) => UserId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserId.fromMap(Map<String, dynamic> json) => UserId(
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    address: json["Address"] == null ? null : json["Address"],
    profile: json["Profile"] == null ? null : UserIdProfile.fromMap(json["Profile"]),
  );

  Map<String, dynamic> toMap() => {
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
    "Profile": profile == null ? null : profile!.toMap(),
  };
}

class UserIdProfile {
  UserIdProfile({
    this.id,
    this.title,
    this.gender,
    this.profilePicture,
    this.dob,
    this.martialStatus,
    this.bloodGroup,
    this.userId,
  });

  int? id;
  String? title;
  String? gender;
  String? profilePicture;
  DateTime? dob;
  String? martialStatus;
  String? bloodGroup;
  int? userId;

  factory UserIdProfile.fromJson(String str) => UserIdProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserIdProfile.fromMap(Map<String, dynamic> json) => UserIdProfile(
    id: json["id"] == null ? null : json["id"],
    title: json["Title"] == null ? null : json["Title"],
    gender: json["Gender"] == null ? null : json["Gender"],
    profilePicture: json["ProfilePicture"] == null ? null : json["ProfilePicture"],
    dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
    martialStatus: json["MartialStatus"] == null ? null : json["MartialStatus"],
    bloodGroup: json["BloodGroup"] == null ? null : json["BloodGroup"],
    userId: json["UserId"] == null ? null : json["UserId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "Title": title == null ? null : title,
    "Gender": gender == null ? null : gender,
    "ProfilePicture": profilePicture == null ? null : profilePicture,
    "DOB": dob == null ? null : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "MartialStatus": martialStatus == null ? null : martialStatus,
    "BloodGroup": bloodGroup == null ? null : bloodGroup,
    "UserId": userId == null ? null : userId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
