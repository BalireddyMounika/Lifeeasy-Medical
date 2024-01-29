import 'package:lifeeazy_medical/models/pharmacy/order_medicine_request.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';
import '../../common_widgets/popup_dialog.dart';
import '../../constants/strings.dart';
import '../../enums/snackbar_type.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../models/pharmacy/pharmacy_order_request.dart';
import '../../models/pharmacy/pharmacy_order_response.dart';
import '../../models/profile/generic_response.dart';
import '../../net/session_manager.dart';
import '../../routes/route.dart';
import '../../services/common_service/dialog_services.dart';
import '../../services/common_service/navigation_service.dart';
import '../../services/common_service/snackbar_service.dart';
import '../../services/pharmacy/pharmacy_services.dart';

class AddPharmacyMedicineViewModel extends CustomBaseViewModel {

   int orderId = 0;
   PharmacyOrderResponse responseData = new PharmacyOrderResponse();

   AddPharmacyMedicineViewModel(this.responseData);
  var _pharmacyService = locator<PharmacyService>();
  var _snackBarService = locator<SnackBarService>();
  var _navigationService = locator<NavigationService>();
  var _dialogService = locator<DialogService>();
  String loadingMsg = "";
  PharmacyMedicineModel orderMedicineRequest = PharmacyMedicineModel();
  List<PharmacyMedicineModel> _medicineRequestList = [PharmacyMedicineModel()];
   List<PharmacyMedicineModel> get medicineRequestList => _medicineRequestList;

   Future addPharmacyMedicine() async {
    try {
      loadingMsg = "Adding Your Pharmacy";
      setState(ViewState.Loading);

      _medicineRequestList.forEach((element) {
        element.orderId = responseData.id;
        element.total = (element.quantity! * element.cost!).toString();
      });
      var response = await _pharmacyService.orderMedicine(new OrderMedicineRequest(
        medicine:  _medicineRequestList
      ));

      if (response.statusCode == 200) {

        updatePharmacyOrder(responseData);

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


   addMoreMedication()
   {
     _medicineRequestList.add(PharmacyMedicineModel());
     notifyListeners();
   }

   deleteMedicine(index)
   {
     if(index!=0){
     _medicineRequestList.removeAt(index);
     notifyListeners();}
   }

   Future<GenericResponse> updatePharmacyOrder(PharmacyOrderResponse responseData) async {
     var response = GenericResponse();
      loadingMsg = "Updating Order Status";

      int total = 0;
      _medicineRequestList.forEach((element) {

        total =  total + int.parse(element.total!);
      });
     try {
       setState(ViewState.Loading);

       var request = new PharmacyOrdersRequest(
         userId: responseData.userId,
         professionalId: responseData.professionalId??0,
         userAddress: responseData.userAddress??"",
         username: responseData.username,
         userPhoneNumber:responseData.userPhoneNumber,
         userSecondaryPhoneNumber:responseData.userSecondaryPhoneNumber,
         pharmacyId: responseData.pharmacyId?.id,
         chronicIllnessQualifier: 'yes',
         uploadDocument: responseData.uploadDocument,
         deliveredDate:responseData.deliveredDate,
         deliveredTime: '08:00pm',
         itemQuantity: orderMedicineRequest.quantity,
         orderStatus: 'In-Process',
         transactionId: "string",
         paymentStatus: 'pending',
         prescribedBy:responseData.prescribedBy,
         total: total,
       );
       var data = await _pharmacyService.updatePharmacyOrders(request,responseData.id??0);

       if (data.statusCode == 200) {
         _dialogService.showDialog(
             DialogType.SuccessDialog, message, "Medicine Successfully Added", Routes.pharmacyDashBoardView, done,isStackedCleared:false);
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
