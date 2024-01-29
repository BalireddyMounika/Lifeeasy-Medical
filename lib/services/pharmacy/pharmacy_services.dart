

import 'package:lifeeazy_medical/models/pharmacy/order_medicine_request.dart';
import 'package:lifeeazy_medical/models/pharmacy/register_pharmacy_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

import '../../models/pharmacy/pharmacy_order_request.dart';

abstract class PharmacyService
{
  Future<GenericResponse> registerPharmacy(RegisterPharmacyRequest request);
  Future<GenericResponse> updatePharmacy(RegisterPharmacyRequest request,int pharmacyID);
  Future<GenericResponse> orderMedicine(OrderMedicineRequest request);
  Future<GenericResponse> getPharmacyByProfId(int profId);
  Future<GenericResponse> getPharmacyOrdersByProfID(int profID);
  Future<GenericResponse> updatePharmacyOrders(PharmacyOrdersRequest request,int id);




}