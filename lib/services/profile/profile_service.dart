import 'package:lifeeazy_medical/models/profile/clinic_info_request.dart';
import 'package:lifeeazy_medical/models/profile/educational_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/profile/personal_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/personal_profile_update_request.dart';
import 'package:lifeeazy_medical/models/profile/professional_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/scheduler_request.dart';

abstract class ProfileServices {
  Future<GenericResponse> postPersonalProfile(PersonalProfileRequest request);
  Future<GenericResponse> postProfessionalProfile(
      ProfessionalProfileRequest request);
  Future<GenericResponse> postEducationalProfile(
      EducationalProfileRequest request);
  Future<GenericResponse> postClinicInfo(ClinicInfoRequest request);
  Future<GenericResponse> postSchedulerInfo(ScheduleRequest request);
  Future<GenericResponse> getClinicInfo(int hcpId);
  Future<GenericResponse> getClinicList(int hcpId);
  Future<GenericResponse> getSchedulerInfo(int hcpId);
  Future<GenericResponse> getHcpDetailInfo(int hcpId);
  //Update Services for Profile
  Future<GenericResponse> updateProfessionalProfile(
      ProfessionalProfileRequest request, int hcpId);
  Future<GenericResponse> updateEducationalProfile(
      EducationalProfileRequest request, int hcpId);
  Future<GenericResponse> updatePersonalProfile(
      PersonalProfileUpdateRequest request, int hcpId);
  Future<GenericResponse> updateClinicInfo(
      ClinicInfoRequest request, int hcpId);
  Future<GenericResponse> updateSchedulerInfo(
      ScheduleRequest request, int hcpId);
}
