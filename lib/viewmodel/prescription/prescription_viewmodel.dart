import 'package:flutter/cupertino.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/appointments/appointment_status_update_request.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/models/prescription/get_prescription_response.dart';
import 'package:lifeeazy_medical/models/prescription/lab_prescription_request.dart';
import 'package:lifeeazy_medical/models/prescription/medical_prescription_request.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/appointments/appointment_services.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/services/prescription/prescription_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

import '../../models/prescription/medication_request.dart';
import '../../models/prescription/prescription_request.dart';
import '../profile/profile_viewmodel.dart';

class PrescriptionViewModel extends CustomBaseViewModel {
  var _prescriptionService = locator<PrescriptionService>();
  var _snackBarService = locator<SnackBarService>();
  var _navigatorService = locator<NavigationService>();
  var _appointmentService = locator<AppointmentService>();
  var _commonService = locator<CommonApiService>();
  var prescriptionData = GetPrescriptionResponse();

  TextEditingController followUpDateController =
      new TextEditingController(text: "");
  List<GetPrescriptionResponse> _prescriptionList = [];
  List<GetPrescriptionResponse> get prescriptionList => _prescriptionList;

  List<GetPrescriptionResponse> _tempPrescriptionList = [];
  List<GetPrescriptionResponse> get tempPrescriptionList =>
      _tempPrescriptionList;

  String loadingMsg = "";
  GetAppointmentResponse appointmentResponse = GetAppointmentResponse();

  LabPrescriptionRequest labPrescriptionRequest = LabPrescriptionRequest();
  MedicalPrescriptionRequest medicalPrescriptionRequest =
      MedicalPrescriptionRequest();

  List<MedicationRequest> medicationRequestList = [];
  PrescriptionViewModel();
  PrescriptionViewModel.add(this.appointmentResponse) {
    medicationRequestList.add(new MedicationRequest());
  }
  ProfileImageState _profileState = ProfileImageState.Idle;
  ProfileImageState get profileState => _profileState;
  void setProfileState(ProfileImageState viewState) {
    _profileState = viewState;
    notifyListeners();
  }

  String uriImage = "String";
  PrescriptionViewModel.fromAppointment(this.appointmentResponse);

  Future getPrescriptionInfo() async {
    try {
      loadingMsg = "Fetching Prescriptions";
      setState(ViewState.Loading);

      var response = await _prescriptionService
          .getPrescriptionInfo(SessionManager.getUser.id ?? 0);

      if (response.hasError == false ?? false) {
        setState(ViewState.Error);
      } else {
        var responseMap = response.result["Hcpprescription"];
        var data = responseMap as List;

        data.forEach((element) {
          _prescriptionList.add(GetPrescriptionResponse.fromMap(element));
        });
        if (prescriptionList.length >= 1)
          setState(ViewState.Completed);
        else
          setState(ViewState.Empty);
      }

      _tempPrescriptionList = _prescriptionList;
    } catch (e) {
      setState(ViewState.Empty);
    }
  }

  Future getPrescriptionInfoByAppointmentId() async {
    try {
      loadingMsg = "Fetching Prescriptions";
      setState(ViewState.Loading);

      var response = await _prescriptionService
          .getPrescriptionInfoByAppointmentId(appointmentResponse.id ?? 0);

      if (response.hasError == false ?? false) {
        setState(ViewState.Error);
      } else {
        var responseMap = response.result["Hcpprescription"];
        var data = responseMap as List;

        data.forEach((element) {
          _prescriptionList.add(GetPrescriptionResponse.fromMap(element));
        });
        if (prescriptionList.length >= 1)
          setState(ViewState.Completed);
        else
          setState(ViewState.Empty);
      }
    } catch (e) {
      setState(ViewState.Empty);
    }
  }

  Future postLabPrescriptionInfo() async {
    try {
      loadingMsg = "Adding Prescriptions";
      setState(ViewState.Loading);
      labPrescriptionRequest.hcpId = SessionManager.getUser.id ?? 0;

      var response = await _prescriptionService
          .postLabPrescriptionInfo(labPrescriptionRequest);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  addMoreMedication() {
    medicationRequestList.add(new MedicationRequest());
    notifyListeners();
  }

  deleteAddedMedication(index) {
    if (medicationRequestList.length > 1) {
      medicationRequestList.removeAt(index);
      notifyListeners();
    }
  }

  searchFilter(String chr) {
    if (chr.isEmpty) {
      _prescriptionList = _tempPrescriptionList;
    } else {
      _prescriptionList = _tempPrescriptionList
          .where((element) =>
              element.userId!.firstname!
                  .toLowerCase()
                  .contains(chr.toLowerCase()) ==
              true)
          .toList();
    }

    notifyListeners();
  }

  Future postPrescription() async {
    try {
      loadingMsg = "Adding Prescriptions";
      setState(ViewState.Loading);

      var response = await _prescriptionService.postPrescription(
          new PrescriptionRequest(
              hcpId: SessionManager.getUser.id ?? 0,
              userId: appointmentResponse.userId!.id ?? 12,
              appointmentId: appointmentResponse.id ?? 0,
              signature: uriImage == "" ? "String" : uriImage,
              nextFollowUpDate: followUpDateController.text,
              familyMemberId: appointmentResponse.familyMemberId == null
                  ? null
                  : appointmentResponse.familyMemberId!.id));
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        var id = response.result["id"];
        postMedication(id);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message, snackbarType: SnackbarType.error);
      }
    } catch (e) {
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
      setState(ViewState.Completed);
    }
  }

  Future postMedication(int id) async {
    medicationRequestList.forEach((element) {
      element.prescriptionId = id;
    });
    loadingMsg = "Adding Medication";
    setState(ViewState.Loading);
    try {
      var response = await _prescriptionService.postMedication(
          new MedicationRequestModel(medication: medicationRequestList));
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        updateAppointmentStatus();
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message, snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future updateAppointmentStatus() async {
    try {
      loadingMsg = "Confirming Appointments";
      setState(ViewState.Loading);
      var response = await _appointmentService.updateAppointmentStatus(
          appointmentResponse.id ?? 0,
          new UpdateAppointmentStatusRequest(
            status: "CONFIRMED",
          ));
      if (response.hasError ?? false) {
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      } else {
        Map maps = new Map();
        maps["appointmentId"] = appointmentResponse.id;
        _navigatorService.navigateToAndRemoveUntil(Routes.prescriptionView,
            arguments: maps);
        // _snackBarService.showSnackBar(
        //     title: response.message ?? somethingWentWrong,
        //     snackbarType: SnackbarType.success);
      }
    } catch (e) {
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
      setState(ViewState.Error);
    }
  }

  Future addUserProfileImage(file) async {
    try {
      setProfileState(ProfileImageState.Loading);
      var response = await _commonService.postImage(file);
      if (response.hasError == false) {
        var data = response.result as Map<String, dynamic>;
        var image = data["Image"];
        uriImage = image;
        setProfileState(ProfileImageState.Completed);
      } else {
        setProfileState(ProfileImageState.Error);
      }
    } catch (e) {
      setProfileState(ProfileImageState.Error);
    }
  }

  void reload() {
    notifyListeners();
  }
}
