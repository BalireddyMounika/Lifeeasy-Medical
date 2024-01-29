
import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/prescription/lab_prescription_request.dart';
import 'package:lifeeazy_medical/models/prescription/medical_prescription_request.dart';
import 'package:lifeeazy_medical/models/prescription/medication_request.dart';
import 'package:lifeeazy_medical/models/prescription/prescription_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/services/prescription/prescription_service.dart';
 
class PrescriptionServiceImp extends PrescriptionService {
  late Dio dio;
  PrescriptionServiceImp(this.dio);

  @override
  Future<GenericResponse> getPrescriptionInfo(int id) async {
    GenericResponse response = GenericResponse();
     String url = "HcpPrescription/GetPrescriptionById/$id/";
    try {
      var httpResponse = await dio.get((url));

      if (httpResponse.statusCode == 200) {
        return GenericResponse.fromMap(httpResponse.data);
      }
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      } else {
        throw ("something went wrong");
      }
    }
    return response;
  }

  @override
  Future<GenericResponse> postMedicalPrescriptionInfo (MedicalPrescriptionRequest model) async {
    var response = new GenericResponse(
        message: "", result: dynamic, hasError: false, statusCode: 200);
   var url = "HcpPrescription/MedicalPrescriptionAPI/";

    try {
      var httpResponse = await dio.post(url, data:model.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    }  catch (error) {
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
  Future<GenericResponse> postLabPrescriptionInfo(LabPrescriptionRequest model) async{
    var response = new GenericResponse(
        message: "", result: dynamic, hasError: false, statusCode: 200);
    var url ="HcpPrescription/LabPrescriptionAPI/";

    try {
      var httpResponse = await dio.post(url, data:model.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    }  catch (error) {
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
  Future<GenericResponse> getPrescriptionInfoByAppointmentId(int id) async{
    GenericResponse response = GenericResponse();
    String url = "HcpPrescription/GetPrescriptionByAppointmentId/$id/";
    try {
      var httpResponse = await dio.get((url));

      if (httpResponse.statusCode == 200) {
        return GenericResponse.fromMap(httpResponse.data);
      }
    } catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      } else {
        throw ("something went wrong");
      }
    }
    return response;
  }

  @override
  Future<GenericResponse> postMedication(MedicationRequestModel model) async{
    var response = new GenericResponse(
        message: "", result: dynamic, hasError: false, statusCode: 200);
    var url = "HcpPrescription/Medication/";

    try {
      var httpResponse = await dio.post(url, data:model.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    }  catch (error) {
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
  Future<GenericResponse> postPrescription(PrescriptionRequest model)async{
    var response = new GenericResponse(
        message: "", result: dynamic, hasError: false, statusCode: 200);
    var url ="HcpPrescription/MedicalPrescriptionAPI/";

    try {
      var httpResponse = await dio.post(url, data:model.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage!;
      response.hasError = true;
    }  catch (error) {
      if (error is DioError) {
        return GenericResponse.fromMap(error.response?.data);
      }
      else
        response.message = somethingWentWrong;

      response.hasError = true;
    }

    return response;
  }

 

}
