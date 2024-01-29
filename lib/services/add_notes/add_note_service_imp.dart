import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/add_notes/post_note_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

import 'add_note_service.dart';

class AddNoteServiceImp extends AddNoteService {
  late Dio dio;

  AddNoteServiceImp(this.dio);

  @override
  Future<GenericResponse> getNoteInfo(int id) async {
    GenericResponse response = GenericResponse();

    String url = "HcpAppointment/GetSelfNotesByAppointmentId/$id/";
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
  Future<GenericResponse> postNoteInfo(PostNoteRequest model) async {
    var response = new GenericResponse();
    var url = "HcpAppointment/HcpSelfNoteApi";
    print(model.toJson());
    print(jsonEncode(model));
    try {
      var httpResponse = await dio.post(url, data: model.toJson());

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
  Future<GenericResponse> PostNoteInfo(PostNoteRequest model) {
    // TODO: implement postNoteInfo
    throw UnimplementedError();
  }
}
