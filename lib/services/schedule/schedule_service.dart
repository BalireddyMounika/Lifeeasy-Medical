import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/schedule/CreateScheduleRequest.dart';
import 'package:lifeeazy_medical/models/schedule/slot_timeing_request.dart';

class ScheduleService {
  ScheduleService(this.dio);

  Dio dio;

  createSchedule(CreateScheduleRequest scheduleData) async {
    var url = "/HcpAppointment/HcpSchedulerAPIV2/";
    GenericResponse response = GenericResponse();
    try {
      var httpResponse = await dio.post(url, data: scheduleData.toJson());

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

  setSlotTime(SlotTimingRequest slotTimingRequest) async {
    var url = "/HcpAppointment/HcpSlotTimingsAPI/";
    GenericResponse response = GenericResponse();
    try {
      var httpResponse = await dio.post(url, data: slotTimingRequest.toJson());

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

  getClinicData({required int hcpId}) async {
    var url = "HCP/ClinicById/$hcpId";
    GenericResponse response = GenericResponse();
    try {
      var httpResponse = await dio.get(url);

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

  getScheduleData({required int hcpId}) async {
    var url = "/HcpAppointment/GetHcpSchedulerV2ByHcpId/$hcpId/";
    GenericResponse response = GenericResponse();
    try {
      var httpResponse = await dio.get(url);
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
