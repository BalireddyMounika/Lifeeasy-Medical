


import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/models/pharmacy/order_medicine_request.dart';
import 'package:lifeeazy_medical/models/pharmacy/register_pharmacy_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/services/pharmacy/pharmacy_services.dart';

import '../../constants/strings.dart';
import '../../models/pharmacy/pharmacy_order_request.dart';

class PharmacyServiceImp extends PharmacyService
{
  Dio dio;
  PharmacyServiceImp(this.dio);


  @override
  Future<GenericResponse> getPharmacyByProfId(int profId) async{
    var response = new GenericResponse();
    var url = "Pharmacy/IsPharmacyregistered/$profId";

    try {
      var httpResponse = await dio.get(url);

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;


  }

  @override
  Future<GenericResponse> orderMedicine(OrderMedicineRequest request) async{

    var response = new GenericResponse();
    var url = "Pharmacy/OrderMedicine/";

    try {
      var httpResponse = await dio.post(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;

  }

  @override
  Future<GenericResponse> registerPharmacy(RegisterPharmacyRequest request) async{

    var response = new GenericResponse();
    var url = "Pharmacy/Pharmacyregister/";

    try {
      var httpResponse = await dio.post(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;

  }

  @override
  Future<GenericResponse> updatePharmacy(RegisterPharmacyRequest request, int pharmacyID) async{
    var response = new GenericResponse();
    var url = "Pharmacy/PharmacyUpdate/$pharmacyID";

    try {
      var httpResponse = await dio.put(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;
  }

  @override
  Future<GenericResponse> getPharmacyOrdersByProfID(int profID)async {
    var response = new GenericResponse();
    var url = "Pharmacy/OrdersBy/$profID";

    try {
      var httpResponse = await dio.get(url);

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;
  }

  @override
  Future<GenericResponse> updatePharmacyOrders(PharmacyOrdersRequest request,int id) async{
    var response = new GenericResponse();
    var url = "/Pharmacy/Pharmacyupdateorders/$id";

    try {
      var httpResponse = await dio.put(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      } else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;
  }

}