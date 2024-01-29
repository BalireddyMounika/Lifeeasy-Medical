
import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/authentication/login_request_model.dart';
import 'package:lifeeazy_medical/models/authentication/register_request_model.dart';
import 'package:lifeeazy_medical/models/authentication/reset_password_request_model.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'auth_servcices.dart';

class AuthServiceImp extends AuthService {
  late Dio dio;

  AuthServiceImp(this.dio);

  @override
  Future<GenericResponse> isDoctorVerified(int id) async {
    var response = new GenericResponse();
    var url = "/HCP/IsDoctorVerified/$id";

    try {
      var httpResponse = await dio.get(url);

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage;
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
  Future<GenericResponse> login(LoginRequestModel model) async {
    var response = new GenericResponse();
    var url = "HCP/Login/";

    try {
      var httpResponse = await dio.post(url, data: model.toJson());

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
  Future<GenericResponse> register(RegisterRequestModel model) async {
    var response = new GenericResponse(
        message: "", result: dynamic, hasError: false, statusCode: 200);
    var url = "HCP/register/";

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
  Future<GenericResponse> isPhoneNumberRegistered(String? phoneNumber) async {
    var response = new GenericResponse();
    var url = "HCP/HcpIsNumberRegistered/$phoneNumber/";

    try {
      var httpResponse = await dio.get(url);

      if (httpResponse.statusCode == 200)
        return GenericResponse.fromMap(httpResponse.data);

      response.message = httpResponse.statusMessage;
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
  Future<GenericResponse> resetPassword(ResetPasswordRequestModel model) async {
    var response = new GenericResponse();
    var url = "HCP/HcpChangePassword/${SessionManager.getUser.id}/";

    try {
      var httpResponse = await dio.put(url, data: model.toJson());

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
