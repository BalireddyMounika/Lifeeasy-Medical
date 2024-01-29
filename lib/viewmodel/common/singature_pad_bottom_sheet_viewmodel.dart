
import 'dart:io';

import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class SignaturePadBottomSheetViewModel extends CustomBaseViewModel
{
  var _commonService = locator<CommonApiService>();
  var _snackBarService = locator<SnackBarService>();
  Future<String> addDoctorSignatureImage(File file) async {
    late String image;
    try {
       setState(ViewState.Loading);
      var response = await _commonService.postImage(file);
      if (response.hasError == false) {
        var data = response.result as Map<String, dynamic>;
         image = data["Image"];

        setState(ViewState.Completed);

      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(title: somethingWentWrong,snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(title: somethingWentWrong,snackbarType: SnackbarType.error);

    }

    return image;
  }
}