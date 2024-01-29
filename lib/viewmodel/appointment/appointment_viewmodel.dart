import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/appointments/appointment_status_update_request.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/models/vide_call/schedule_call_status_responce.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/appointments/appointment_services.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/services/video_call/video_call_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class AppointmentsViewModel extends CustomBaseViewModel {
  var _appointmentService = locator<AppointmentService>();
  var _dialogService = locator<DialogService>();
  var _snackBarService = locator<SnackBarService>();
  var navigationService = locator<NavigationService>();
  var _videoCallService = locator<VideoCallService>();

  GetAppointmentResponse profileRequest = new GetAppointmentResponse();

  List<GetScheduleCallStatusResponse> _scheduleCallStatusList = [];
  List<GetScheduleCallStatusResponse> get scheduleCallStatusList =>
      _scheduleCallStatusList;
  List<GetAppointmentResponse> _appointmentList = [];
  List<GetAppointmentResponse> get appointmentList => _appointmentList;
  List<GetAppointmentResponse> _tempList = [];
  String loadingMsg = "";
  String selectedFilterValue = 'All';
  var imageUlr;

  AppointmentsViewModel();

  Future getAppointmentList() async {
    try {
      loadingMsg = fetchingAppointments;
      setState(ViewState.Loading);
      var response = await _appointmentService
          .getAppointmentById(SessionManager.getUser.id ?? 0);
      profileRequest.profile = SessionManager.profileImageUrl ?? "String";
      if (response.hasError ?? false) {
        setState(ViewState.Empty);
        _snackBarService.showSnackBar(
            title: noAppointmentAvailable, snackbarType: SnackbarType.error);
      } else {
        var data = response.result as List;
        data.forEach((element) {
          _appointmentList.add(GetAppointmentResponse.fromMap(element));
        });

        _appointmentList = _appointmentList
            .where((element) => element.status != 'PENDING')
            .toList();
        _tempList = _appointmentList;
        _appointmentList.length == 0
            ? setState(ViewState.Empty)
            : setState(ViewState.Completed);
      }
    } catch (e) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Empty);
    }
  }

  void filterAppointment(String status) {
    selectedFilterValue = status ;
    if (status == "All"){
      _appointmentList = _tempList;
    }
    else
      _appointmentList =
          _tempList.where((element) => element.status == status).toList();

    notifyListeners();
  }

  Future updateAppointmentStatus(int appointmentId, String status) async {
    try {
      loadingMsg = updatingStatus;
      setState(ViewState.Loading);
      var response = await _appointmentService.updateAppointmentStatus(
          appointmentId,
          new UpdateAppointmentStatusRequest(
            status: status,
          ));
      if (response.hasError ?? false) {
        _dialogService.showDialog(
            DialogType.ErrorDialog, message, response.message, "", done);
      } else {
        _appointmentList = [];
        getAppointmentList();
        setState(ViewState.Completed);
      }
    } catch (e) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Error);
    }
  }

  Future getScheduleCallStatusList(int id) async {
    try {
      loadingMsg = fetchingAppointments;
      setState(ViewState.Loading);
      var response =
          await _videoCallService.getScheduleCallStatusByAppointmentId(id);
      if (response.hasError ?? false) {
        setState(ViewState.Error);
        _snackBarService.showSnackBar(
            title: noAppointmentAvailable, snackbarType: SnackbarType.error);
      } else {
        var data = response.result as List;
        data.forEach((element) {
          _scheduleCallStatusList
              .add(GetScheduleCallStatusResponse.fromMap(element));
        });

        _scheduleCallStatusList.length == 0
            ? setState(ViewState.Completed)
            : setState(ViewState.Completed);
      }
    } catch (e) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Error);
    }
  }
}
