import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/appointments/appointment_status_update_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/services/appointments/appointment_services.dart';

class AppointmentServiceImp extends AppointmentService {
  late Dio dio;

  AppointmentServiceImp(this.dio);

  @override
  Future<GenericResponse> getAppointmentById(int id) async {
    var response = new GenericResponse();
    var url = "/HcpAppointment/HcpByDoctorName/$id";

    try {
      var httpResponse = await dio.get(url);
      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);
      response.message = httpResponse.statusMessage;
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

  @override
  Future<GenericResponse> updateAppointmentStatus(
      int id, UpdateAppointmentStatusRequest request) async {
    var response = new GenericResponse();
    var url = "HcpAppointment/DoctorStatusUpdate/$id/";

    try {
      var httpResponse = await dio.put(url, data: request.toJson());

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage;
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
