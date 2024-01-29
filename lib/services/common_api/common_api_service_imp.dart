import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/models/otp/generate_otp_request.dart';
import 'package:lifeeazy_medical/models/otp/validate_otp_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

import 'common_api_service.dart';

class CommonApiServiceImp extends CommonApiService {
  late Dio dio;

  CommonApiServiceImp(this.dio);

  @override
  Future<GenericResponse> postImage(File file) async {
    GenericResponse response = new GenericResponse();
    String url = "ImageUpload/PostImages/";
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "Image": await MultipartFile.fromFile(file.path, filename: fileName),
      "type": "image/jpeg"
    });
    try {
      var httpResponse = await dio.post(url, data: formData);

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
  Future<GenericResponse> getAutoCompleteSearch(String data) async {
    GenericResponse response = new GenericResponse();
    String url = "GeographicalLocation/GeolocationLocationGet/$data";
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

  @override
  Future<GenericResponse> getDataByLatLang(String lat, String long) {
    // TODO: implement getDataByLatLang
    throw UnimplementedError();
  }

  @override
  Future<GenericResponse> getSpecialisation() async {
    GenericResponse response = new GenericResponse();
    String url = "HCP/GetAllMasterSpecializationDetails/";
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

  @override
  Future<GenericResponse> getImageByName(String name) async {
    GenericResponse response = new GenericResponse();
    String url = "ImageUpload/GetImageByName/$name";
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

  @override
  Future<GenericResponse> generateOtp(GenerateOtpRequest request) async {
    GenericResponse response = new GenericResponse();
    String url = "Otp/otp_generation";
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
  Future<GenericResponse> validateOtp(
      ValidateOtpRequest request, int id) async {
    GenericResponse response = new GenericResponse();
    String url = "Otp/otpvalidate/$id";
    try {
      var httpResponse = await dio.post(url, data: request.toJson());
      log(httpResponse.data.toString());
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
