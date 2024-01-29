import 'dart:io';

import 'package:lifeeazy_medical/models/otp/generate_otp_request.dart';
import 'package:lifeeazy_medical/models/otp/validate_otp_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

abstract class CommonApiService {
  Future<GenericResponse> postImage(File file);
  Future<GenericResponse> getAutoCompleteSearch(String data);
  Future<GenericResponse> getImageByName(String name);
  Future<GenericResponse> getDataByLatLang(String lat, String long);
  Future<GenericResponse> getSpecialisation();
  Future<GenericResponse> generateOtp(GenerateOtpRequest request);
  Future<GenericResponse> validateOtp(ValidateOtpRequest request, int id);
}
