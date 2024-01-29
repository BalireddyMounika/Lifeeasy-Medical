import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/appointments/appointment_status_update_request.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/models/location/google_auto_complete_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/services/appointments/appointment_services.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

import '../../models/authentication/location_response_model.dart';
import '../../models/authentication/verification_check_response_model.dart';
import '../../routes/route.dart';
import '../../services/authentication/auth_servcices.dart';

class DashBoardViewModel extends CustomBaseViewModel {
  var _appointmentService = locator<AppointmentService>();
  var _dialogService = locator<DialogService>();
  var navigationService = locator<NavigationService>();
  var _commonService = locator<CommonApiService>();
  var _prefs = locator<LocalStorageService>();
  var _authService = locator<AuthService>();

  List<GetAppointmentResponse> _appointmentList = [];

  String location = "Enter City or Locality";
  String authCode = '0000';

  List<GetAppointmentResponse> get appointmentList => _appointmentList;
  GetAppointmentResponse profileRequest = new GetAppointmentResponse();
  VerificationCheckResponseModel verifiedModel =
      new VerificationCheckResponseModel();

  List<Predictions> _autoCompleteList = [];

  List<Predictions> get autoCompleteList => _autoCompleteList;

  String loadingMsg = "";

  DashBoardViewModel();

  Future<VerificationCheckResponseModel> getIsDoctorVerified() async {
    try {
      var response =
          await _authService.isDoctorVerified(SessionManager.getUser.id ?? 0);
      if (response.hasError ?? false) {
        _dialogService.showDialog(
            DialogType.WarningDialog, message, response.message, "", done);
      } else {
        verifiedModel = VerificationCheckResponseModel.fromMap(response.result);
      }
    } catch (e) {}

    return verifiedModel;
  }

  getAuthCode() {
    if (SessionManager.getUser.id.toString().length == 4)
      authCode = '${SessionManager.getUser.id ?? 0}';
    else if (SessionManager.getUser.id.toString().length == 3)
      authCode = '0${SessionManager.getUser.id ?? 0}';
    else if (SessionManager.getUser.id.toString().length == 2)
      authCode = '00${SessionManager.getUser.id ?? 0}';
    else
      authCode = '000${SessionManager.getUser.id ?? 0}';
    notifyListeners();
  }

  Future getAppointmentList() async {
    _appointmentList = [];
    try {
      loadingMsg = fetchingAppointments;
      setState(ViewState.Loading);
      var response = await _appointmentService
          .getAppointmentById(SessionManager.getUser.id ?? 0);
      profileRequest.profile = SessionManager.profileImageUrl ?? "String";
      if (response.hasError ?? false) {
        _dialogService.showDialog(
            DialogType.ErrorDialog, message, response.message, "", done);
      } else {
        var data = response.result as List;
        data.forEach((element) {
          _appointmentList.add(GetAppointmentResponse.fromMap(element));
        });
        getAuthCode();
        var temp = _appointmentList;
        _appointmentList =
            temp.where((element) => (element.status == "CREATED" || element.status == "ACCEPTED")).toList();
        _appointmentList.length == 0
            ? setState(ViewState.Empty)
            : setState(ViewState.Completed);
      }
    } catch (e) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Error);
    }
  }

  Future getAutoComplete(String value) async {
    try {
      _autoCompleteList = [];
      setState(ViewState.Loading);
      var response = await _commonService.getAutoCompleteSearch(value);

      var data = response.result["predictions"];

      var predictionList = data as List;

      predictionList.forEach((element) {
        _autoCompleteList.add(Predictions.fromMap(element));
      });

      if (_autoCompleteList.length >= 1)
        setState(ViewState.Completed);
      else
        setState(ViewState.Empty);
    } catch (e) {
      setState(ViewState.Error);
    }
  }

  Future updateAppointmentStatus(
      int appointmentId, String status, int index) async {
    try {
      loadingMsg = "Updating Status";
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
        locator<NavigationService>().navigateTo(
          Routes.getAppointmentView,
        );
        setState(ViewState.Completed);
      }
    } catch (e) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Error);
    }
  }

  Future updateLocation(var data) async {
    if (data != null) {
      var s = data;
      var country = "";
      var state = "";
      var city = "";
      var address = "";
      var length = s!.split(',').length;
      for (int i = length; i >= 0; i--) {
        country = s!.split(',')[length - 1];
        if (length > 1) state = s!.split(',')[length - 2];
        if (length > 2) city = s!.split(',')[length - 3];

        if (i < length - 3) address = s!.split(',')[i] + "," + address;
      }

      SessionManager.setLocation = new LocationResponseModel(
          lat: 00.0,
          long: 00.0,
          city: city,
          country: country,
          pinCode: 0,
          state: state,
          address:
              address.isEmpty ? "$state,$country" : "$address $city $country");

      _prefs.setLocation(SessionManager.getLocation.toJson());

      // data = data.split(',').first;

    }
    notifyListeners();
  }
}
