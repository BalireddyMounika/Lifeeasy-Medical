import 'package:flutter/cupertino.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/add_notes/get_note_response.dart';
import 'package:lifeeazy_medical/models/add_notes/post_note_request.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';

import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/add_notes/add_note_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class AddNoteViewModel extends CustomBaseViewModel {
  var _addNoteService = locator<AddNoteService>();
  var _snackBarService = locator<SnackBarService>();

  var addNoteData = GetNoteResponse();
  List<GetNoteResponse> _addNoteList = [];

  TextEditingController notesController =  new  TextEditingController();

  List<GetNoteResponse> get addNoteList => _addNoteList;
  String loadingMsg = "";
  GetNoteResponse response = GetNoteResponse();
  PostNoteRequest postNoteRequest = PostNoteRequest();
  GetAppointmentResponse appointmentResponse = GetAppointmentResponse();

  AddNoteViewModel(this.appointmentResponse);


  Future getNoteInfo() async {
    try {
      loadingMsg = "Getting Added Notes";
      setState(ViewState.Loading);

      var response = await _addNoteService.getNoteInfo(appointmentResponse.id?? 0);

      if (response.hasError == true ?? false) {

         addNoteData = GetNoteResponse.fromMap(response.result);


        setState(ViewState.Completed);
      } else {
        setState(ViewState.Empty);

      }
    } catch (e) {
      setState(ViewState.Empty);
    }
  }


  Future postNoteInfo() async {
    try {
      loadingMsg = "Add Notes";
      setState(ViewState.Loading);
      postNoteRequest.hcpId = SessionManager.getUser.id ?? 0;
      postNoteRequest.appointmentId = appointmentResponse.id;
      postNoteRequest.selfNote = notesController.text;
      print(postNoteRequest);
      var response = await _addNoteService.postNoteInfo(postNoteRequest);
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
}
