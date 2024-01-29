
import 'package:lifeeazy_medical/models/prescription/lab_prescription_request.dart';
import 'package:lifeeazy_medical/models/prescription/medical_prescription_request.dart';
import 'package:lifeeazy_medical/models/prescription/medication_request.dart';
import 'package:lifeeazy_medical/models/prescription/prescription_request.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';

abstract class PrescriptionService
{

  Future<GenericResponse> getPrescriptionInfo(int id);
  Future<GenericResponse> getPrescriptionInfoByAppointmentId(int id);
  Future<GenericResponse> postLabPrescriptionInfo(LabPrescriptionRequest model);
  Future<GenericResponse> postMedicalPrescriptionInfo(MedicalPrescriptionRequest model);
  Future<GenericResponse> postMedication(MedicationRequestModel request);
  Future<GenericResponse> postPrescription(PrescriptionRequest request);
}

