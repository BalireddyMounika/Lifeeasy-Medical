import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/models/pharmacy/register_pharmacy_request.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/pharmacy/pharmacy_services.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';
import '../../common_widgets/popup_dialog.dart';
import '../../constants/strings.dart';
import '../../enums/snackbar_type.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../routes/route.dart';
import '../../services/common_service/navigation_service.dart';
import '../../services/common_service/snackbar_service.dart';

class MyPharmacyViewModel extends CustomBaseViewModel {
  var _pharmacyService = locator<PharmacyService>();
  var _snackBarService = locator<SnackBarService>();
  var _navigationService = locator<NavigationService>();
  var _dialogService = locator<DialogService>();
  TextEditingController pharmacyOpenTimeController = TextEditingController();
  TextEditingController pharmacyCloseTimeController = TextEditingController();
  TextEditingController pharmacyNameController = TextEditingController();
  TextEditingController pharmacyRegNumberController = TextEditingController();
  TextEditingController pharmacyEmailController = TextEditingController();
  TextEditingController pharmacyAuthEmailController = TextEditingController();
  TextEditingController pharmacyContactNumController = TextEditingController();
  TextEditingController pharmacyAuthContactController = TextEditingController();
  TextEditingController pharmacyWebUrlController = TextEditingController();
  TextEditingController pharmacyAuthFirstNameController =
      TextEditingController();
  TextEditingController pharmacyAuthLastNameController =
      TextEditingController();
  TextEditingController pharmacyAddressController = TextEditingController();
  TextEditingController pharmacyLicenceController = TextEditingController();
  String loadingMsg = "";
  bool isEdit = false;

  RegisterPharmacyRequest pharmacyRequest = RegisterPharmacyRequest();

  Future addMyPharmacy() async {
    try {
      loadingMsg = "Adding Your Pharmacy";
      setState(ViewState.Loading);
      pharmacyRequest.professionalId = SessionManager.getUser.id;
      pharmacyRequest.partnerTypeId = 4;
      pharmacyRequest.deviceToken = "NA";
      pharmacyRequest.uploadPharmacyImages = "NA";
      pharmacyRequest.uploadRegistrationDocuments = "NA";
      pharmacyRequest.pharmacyStatus = "Active";
      pharmacyRequest.pharmacyName = pharmacyNameController.text;
      pharmacyRequest.pharmacyRegistrationNumber =
          pharmacyRegNumberController.text;
      pharmacyRequest.pharmacyEmailId = pharmacyEmailController.text;
      pharmacyRequest.pharmacyContactNumber = pharmacyContactNumController.text;
      pharmacyRequest.pharmacyWebsiteUrl =
          'https//:${pharmacyWebUrlController.text}';
      pharmacyRequest.pharmacyOpenTime = pharmacyOpenTimeController.text;
      pharmacyRequest.pharmacyCloseTime = pharmacyCloseTimeController.text;
      pharmacyRequest.authorizedFirstName =
          pharmacyAuthFirstNameController.text;
      pharmacyRequest.authorizedLastName = pharmacyAuthLastNameController.text;
      pharmacyRequest.authorizedEmailId = pharmacyAuthEmailController.text;
      pharmacyRequest.authorizedMobileNumber =
          pharmacyAuthContactController.text;
      pharmacyRequest.pharmacyAddress = pharmacyAddressController.text;
      pharmacyRequest.authorizedLastName = pharmacyLicenceController.text;

      var response = await _pharmacyService.registerPharmacy(pharmacyRequest);

      if (response.statusCode == 200) {
        _dialogService.showDialog(DialogType.SuccessDialog, message,
            "Pharmacy Added Successfully", Routes.pharmacyDashBoardView, done,
            isStackedCleared: true);
        setState(ViewState.Completed);
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

  Future getPharmacyByProfId() async {
    try {
      loadingMsg = "Fetching Pharmacy";
      setState(ViewState.Loading);

      var response = await _pharmacyService
          .getPharmacyByProfId(SessionManager.getUser.id ?? 0);

      if (response.statusCode == 200) {
        pharmacyRequest = RegisterPharmacyRequest.fromMap(response.result);
        isEdit = true;
        setState(ViewState.Completed);
        fillPharmacyForm(pharmacyRequest: pharmacyRequest);
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

  Future updatePharmacy() async {
    try {
      loadingMsg = "Updating Your Pharmacy";
      setState(ViewState.Loading);
      // pharmacyRequest.professionalId = SessionManager.getUser.id;
      pharmacyRequest.partnerTypeId = 4;
      pharmacyRequest.deviceToken = "NA";
      pharmacyRequest.pharmacyName = pharmacyNameController.text;
      pharmacyRequest.pharmacyRegistrationNumber =
          pharmacyRegNumberController.text;
      pharmacyRequest.pharmacyEmailId = pharmacyEmailController.text;
      pharmacyRequest.pharmacyContactNumber = pharmacyContactNumController.text;
      pharmacyRequest.pharmacyWebsiteUrl = pharmacyWebUrlController.text;
      pharmacyRequest.pharmacyOpenTime = pharmacyOpenTimeController.text;
      pharmacyRequest.pharmacyCloseTime = pharmacyCloseTimeController.text;
      pharmacyRequest.authorizedFirstName =
          pharmacyAuthFirstNameController.text;
      pharmacyRequest.authorizedLastName = pharmacyAuthLastNameController.text;
      pharmacyRequest.authorizedEmailId = pharmacyAuthEmailController.text;
      pharmacyRequest.authorizedMobileNumber =
          pharmacyAuthContactController.text;
      pharmacyRequest.pharmacyAddress = pharmacyAddressController.text;
      pharmacyRequest.authorizedLastName = pharmacyLicenceController.text;

      var response = await _pharmacyService.updatePharmacy(
          pharmacyRequest, pharmacyRequest.id ?? 0);

      if (response.statusCode == 200) {
        _snackBarService.showSnackBar(
            title: response.message, snackbarType: SnackbarType.success);

        setState(ViewState.Completed);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message, snackbarType: SnackbarType.info);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.info);
    }
  }

  Future selectTime(
      {required BuildContext context,
      required TextEditingController controller}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
      notifyListeners();
    }
  }

  fillPharmacyForm({required RegisterPharmacyRequest pharmacyRequest}) {
    pharmacyNameController.text = pharmacyRequest.pharmacyName ?? '_';
    pharmacyRegNumberController.text =
        pharmacyRequest.pharmacyRegistrationNumber ?? '_';
    pharmacyEmailController.text = pharmacyRequest.authorizedEmailId ?? '_';
    pharmacyOpenTimeController.text = pharmacyRequest.pharmacyOpenTime ?? '_';
    pharmacyCloseTimeController.text = pharmacyRequest.pharmacyCloseTime ?? '_';
    pharmacyContactNumController.text =
        pharmacyRequest.pharmacyContactNumber ?? '_';
    pharmacyWebUrlController.text = pharmacyRequest.pharmacyWebsiteUrl ?? '_';
    pharmacyAuthFirstNameController.text =
        pharmacyRequest.authorizedFirstName ?? '_';
    pharmacyAuthLastNameController.text =
        pharmacyRequest.authorizedLastName ?? '_';
    pharmacyAuthEmailController.text = pharmacyRequest.authorizedEmailId ?? '_';
    pharmacyAuthContactController.text =
        pharmacyRequest.authorizedMobileNumber ?? '_';
    pharmacyAddressController.text = pharmacyRequest.pharmacyAddress ?? '_';
    pharmacyLicenceController.text =
        pharmacyRequest.authorizedLicenseNumber ?? '_';
    notifyListeners();
  }
}
