import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/add_notes/post_note_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/vide_call/schedule_call_status.dart';
import 'package:lifeeazy_medical/models/vide_call/video_call_responce.dart';
import 'package:lifeeazy_medical/services/video_call/video_call_service.dart';

class VideoCallServiceImp extends VideoCallService {
  late Dio dio;

  VideoCallServiceImp(this.dio);

  @override
  Future<GenericResponse> postVideoCall(VideoCallRequest request) async {
    var response = new GenericResponse();
    var url = "User/ScheduleVideoApi/";

    try {
      var httpResponse = await dio.post(url, data: request.toJson());

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

  @override
  Future<GenericResponse> postScheduleCallStatus(
      ScheduleCallStatus request) async {
    var response = new GenericResponse();
    var url = "UserAppointment/VideoConsultAPI/";

    try {
      var httpResponse = await dio.post(url, data: request.toJson());

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

  @override
  Future<GenericResponse> getScheduleCallStatusByAppointmentId(int id) async{
    var response = new GenericResponse();
    var url = "/UserAppointment/GetByAppointmentIdVideoConsult/$id";

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
  Future<GenericResponse> agoraToken(String channelName) async {
    var response = new GenericResponse();
    var url = "AgoraTokenGeneration/create_channel/";

    try {
      var httpResponse = await dio.post(url, data: { "channelName": "$channelName"});

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
