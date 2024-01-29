

import 'package:lifeeazy_medical/models/authentication/login_request_model.dart';
import 'package:lifeeazy_medical/models/authentication/register_request_model.dart';
import 'package:lifeeazy_medical/models/authentication/reset_password_request_model.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

abstract class AuthService
{

  Future<GenericResponse> login(LoginRequestModel model);

  Future<GenericResponse> register(RegisterRequestModel model);

  Future<GenericResponse> isPhoneNumberRegistered(String? phoneNumber);

  Future<GenericResponse> resetPassword(ResetPasswordRequestModel model);

  Future<GenericResponse> isDoctorVerified(int id);

}