import 'dart:convert';


class OrderMedicineRequest {
  OrderMedicineRequest({
    this.medicine,
  });

  List<PharmacyMedicineModel>? medicine;

  factory OrderMedicineRequest.fromJson(String str) => OrderMedicineRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderMedicineRequest.fromMap(Map<String, dynamic> json) => OrderMedicineRequest(
    medicine: json["Medicine"] == null ? null : List<PharmacyMedicineModel>.from(json["Medicine"].map((x) => PharmacyMedicineModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Medicine": medicine == null ? null : List<dynamic>.from(medicine!.map((x) => x.toMap())),
  };
}



class PharmacyMedicineModel {
  PharmacyMedicineModel({
    this.medicine,
    this.power,
    this.quantity,
    this.cost,
    this.discount,
    this.total,
    this.specialInstructionsForMedicine,
    this.orderId,
  });

  String? medicine;
  String? power;
  int? quantity;
  int? cost;
  String? discount;
  String? total;
  String? specialInstructionsForMedicine;
  int? orderId;

  factory PharmacyMedicineModel.fromJson(String str) => PharmacyMedicineModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PharmacyMedicineModel.fromMap(Map<String, dynamic> json) => PharmacyMedicineModel(
    medicine: json["Medicine"] == null ? null : json["Medicine"],
    power: json["Power"] == null ? null : json["Power"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    cost: json["Cost"] == null ? null : json["Cost"],
    discount: json["Discount"] == null ? null : json["Discount"],
    total: json["Total"] == null ? null : json["Total"],
    specialInstructionsForMedicine: json["Special_Instructions_For_Medicine"] == null ? null : json["Special_Instructions_For_Medicine"],
    orderId: json["OrderId"] == null ? null : json["OrderId"],
  );

  Map<String, dynamic> toMap() => {
    "Medicine": medicine == null ? null : medicine,
    "Power": power == null ? null : power,
    "Quantity": quantity == null ? null : quantity,
    "Cost": cost == null ? null : cost,
    "Discount": discount == null ? null : discount,
    "Total": total == null ? null : total,
    "Special_Instructions_For_Medicine": specialInstructionsForMedicine == null ? null : specialInstructionsForMedicine,
    "OrderId": orderId == null ? null : orderId,
  };
}
