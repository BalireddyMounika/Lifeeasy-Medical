import 'dart:convert';

class FamilyMemberModel {
  FamilyMemberModel({
    this.id,
    this.title,
    this.firstname,
    this.lastname,
    this.email,
    this.gender,
    this.profilePicture,
    this.age,
    this.familyMemberType,
    this.dob,
    this.martialStatus,
    this.bloodGroup,
    this.relationshipToPatient,
    this.isEmergency,
    this.userId,
  });

  int? id;
  String? title;
  String? firstname;
  String? lastname;
  String? email;
  String? gender;
  String? profilePicture;
  int? age;
  String? familyMemberType;
  String? dob;
  String? martialStatus;
  String? bloodGroup;
  String? relationshipToPatient;
  bool? isEmergency;
  int? userId;

  factory FamilyMemberModel.fromJson(String str) => FamilyMemberModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FamilyMemberModel.fromMap(Map<String, dynamic> json) => FamilyMemberModel(
    id: json["id"] == null ? null : json["id"],
    title: json["Title"] == null ? null : json["Title"],
    firstname: json["Firstname"] == null ? null : json["Firstname"],
    lastname: json["Lastname"] == null ? null : json["Lastname"],
    email: json["Email"] == null ? null : json["Email"],
    gender: json["Gender"] == null ? null : json["Gender"],
    profilePicture: json["ProfilePicture"] == null ? null : json["ProfilePicture"],
    age: json["Age"] == null ? null : json["Age"],
    familyMemberType: json["FamilyMemberType"] == null ? null : json["FamilyMemberType"],
    dob: json["DOB"] == null ? null : json["DOB"],
    martialStatus: json["MartialStatus"] == null ? null : json["MartialStatus"],
    bloodGroup: json["BloodGroup"] == null ? null : json["BloodGroup"],
    relationshipToPatient: json["RelationshipToPatient"] == null ? null : json["RelationshipToPatient"],
    isEmergency: json["IsEmergency"] == null ? null : json["IsEmergency"],
    userId: json["UserId"] == null ? null : json["UserId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "Title": title == null ? null : title,
    "Firstname": firstname == null ? null : firstname,
    "Lastname": lastname == null ? null : lastname,
    "Email": email == null ? null : email,
    "Gender": gender == null ? null : gender,
    "ProfilePicture": profilePicture == null ? null : profilePicture,
    "Age": age == null ? null : age,
    "FamilyMemberType": familyMemberType == null ? null : familyMemberType,
    "DOB": dob == null ? null : dob,
    "MartialStatus": martialStatus == null ? null : martialStatus,
    "BloodGroup": bloodGroup == null ? null : bloodGroup,
    "RelationshipToPatient": relationshipToPatient == null ? null : relationshipToPatient,
    "IsEmergency": isEmergency == null ? null : isEmergency,
    "UserId": userId == null ? null : userId,
  };
}
