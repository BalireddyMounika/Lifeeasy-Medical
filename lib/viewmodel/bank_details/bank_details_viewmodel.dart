import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/bank_details/get_bank_response.dart';
import 'package:lifeeazy_medical/models/bank_details/post_bank_request.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/bank_details/bank_details_service.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class BankDetailsViewModel extends CustomBaseViewModel {
  var _bankService = locator<BankDetailsService>();
  var _snackBarService = locator<SnackBarService>();
  var _commonService = locator<CommonApiService>();

  String loadingMsg = "";
  String uriImage = "";
  bool isEdit = false;
  GetBankDetailsResponse getBankDetailsResponse = GetBankDetailsResponse();
  PostBankDetailsRequest postBankDetailsRequest = PostBankDetailsRequest();

  ProfileImageState _profileState = ProfileImageState.Idle;

  ProfileImageState get profileState => _profileState;

  void setProfileState(ProfileImageState viewState) {
    _profileState = viewState;
    notifyListeners();
  }

  Future getBankDetailsInfo() async {
    try {
      loadingMsg = "Fetching Bank Details";
      setState(ViewState.Loading);
      var response =
          await _bankService.getBankDetailsInfo(SessionManager.getUser.id ?? 0);

      if (response.hasError == true ?? false) {
        _snackBarService.showSnackBar(
            title: "Not Available", snackbarType: SnackbarType.error);

        setState(ViewState.Completed);
      } else {
        var data = response.result as Map<String, dynamic>;

        postBankDetailsRequest = PostBankDetailsRequest.fromMap(data);
        uriImage = postBankDetailsRequest.uploadDocuments ?? "";
        setProfileState(ProfileImageState.Completed);

        isEdit = true;

        setState(ViewState.Completed);
      }
    } catch (e) {
      _snackBarService.showSnackBar(
          title: "Not Available", snackbarType: SnackbarType.error);
      setState(ViewState.Completed);
    }
  }

  Future postBankDetailsInfo() async {
    try {
      loadingMsg = "Adding Bank Details";
      setState(ViewState.Loading);
      postBankDetailsRequest.hcpId = SessionManager.getUser.id ?? 0;
      postBankDetailsRequest.uploadDocuments = uriImage;
      postBankDetailsRequest.uploadPancard = "NA";

      var response =
          await _bankService.postBankDetailsInfo(postBankDetailsRequest);
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

  Future updateBankDetails() async {
    try {
      loadingMsg = "Update BankDetails";
      setState(ViewState.Loading);
      postBankDetailsRequest.hcpId = SessionManager.getUser.id;
      postBankDetailsRequest.uploadDocuments = uriImage;
      var response =
          await _bankService.updateBankDetails(postBankDetailsRequest);
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
}
