
import 'package:lifeeazy_medical/models/appointments/appointment_status_update_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

abstract class  AppointmentService
{

  Future<GenericResponse> getAppointmentById(int id);
  Future<GenericResponse> updateAppointmentStatus(int id, UpdateAppointmentStatusRequest request);

}

