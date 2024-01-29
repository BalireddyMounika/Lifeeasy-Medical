import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

import '../../common_widgets/popup_dialog.dart';
import '../../constants/strings.dart';
import '../../enums/snackbar_type.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../models/pharmacy/pharmacy_order_request.dart';
import '../../models/pharmacy/pharmacy_order_response.dart';
import '../../models/profile/generic_response.dart';
import '../../routes/route.dart';
import '../../services/common_service/dialog_services.dart';
import '../../services/common_service/navigation_service.dart';
import '../../services/common_service/snackbar_service.dart';
import '../../services/pharmacy/pharmacy_services.dart';

class PharmacyDashBoardViewModel extends CustomBaseViewModel {
  var _pharmacyService = locator<PharmacyService>();
  var _snackBarService = locator<SnackBarService>();
  var _navigationService = locator<NavigationService>();
  var _dialogService = locator<DialogService>();
  List<PharmacyOrderResponse> _pharmacyOrderList = [];

  List<PharmacyOrderResponse> get pharmacyOrderList => _pharmacyOrderList;
  String loadingMsg = "";

  Future getPharmacyOrders() async {
    _pharmacyOrderList = [];
    setState(ViewState.Loading);
    try {
      var response = await _pharmacyService
          .getPharmacyOrdersByProfID(SessionManager.getUser.id ?? 0);

      if (response.statusCode == 200) {
        var data = response.result as List;
        data.forEach((element) {
          _pharmacyOrderList.add(PharmacyOrderResponse.fromMap(element));
        });

        if (_pharmacyOrderList.length >= 1)
          setState(ViewState.Completed);
        else
          setState(ViewState.Empty);
      } else {
        setState(ViewState.Empty);
      }
    } catch (e) {
      setState(ViewState.Empty);
      _snackBarService.showSnackBar(
        snackbarType: SnackbarType.error,
        title: somethingWentWrong,
      );
    }
  }

  Future<GenericResponse> updatePharmacyOrder(
      PharmacyOrderResponse responseData) async {
    var response = GenericResponse();
    loadingMsg = "Updating Order Status";
    try {
      setState(ViewState.Loading);

      var request = new PharmacyOrdersRequest(
        userId: responseData.userId,
        professionalId: responseData.professionalId ?? 0,
        userAddress: responseData.userAddress ?? "",
        username: responseData.username,
        userPhoneNumber: responseData.userPhoneNumber,
        userSecondaryPhoneNumber: responseData.userSecondaryPhoneNumber,
        pharmacyId: responseData.pharmacyId?.id,
        chronicIllnessQualifier: 'yes',
        uploadDocument: responseData.uploadDocument,
        deliveredDate: responseData.deliveredDate,
        deliveredTime: '08:00pm',
        itemQuantity: responseData.itemQuantity,
        orderStatus: 'delivered',
        transactionId: "string",
        paymentStatus: 'completed',
        prescribedBy: responseData.prescribedBy,
        total: responseData.total,
      );
      var data = await _pharmacyService.updatePharmacyOrders(
          request, responseData.id ?? 0);

      if (data.statusCode == 200) {
        _dialogService.showDialog(
            DialogType.SuccessDialog,
            message,
            "Delivery Successfully Completed",
            Routes.pharmacyDashBoardView,
            done,
            isStackedCleared: false);
        setState(ViewState.Completed);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
          snackbarType: SnackbarType.error,
          title: data.message ?? somethingWentWrong,
        );
      }
    } catch (e) {
      _snackBarService.showSnackBar(
        snackbarType: SnackbarType.error,
        title: somethingWentWrong,
      );
      setState(ViewState.Completed);
    }

    return response;
  }
}
