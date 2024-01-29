import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/models/portfolio/partner_type_masterdata_model.dart';
import 'package:lifeeazy_medical/models/portfolio/partner_type_request.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

import '../../enums/snackbar_type.dart';
import '../../get_it/locator.dart';
import '../../models/portfolio/professional_type_request.dart';
import '../../routes/route.dart';
import '../../services/common_service/snackbar_service.dart';
import '../../services/portfolio/portfolio_services.dart';

class PortfolioViewModel extends CustomBaseViewModel {
  var _portfolioServices = locator<PortfolioServices>();
  var _snackBarService = locator<SnackBarService>();
  var _navigationService = locator<NavigationService>();

  List<ProfessionalTypeRequest> _profTypeList = [];
  List<ProfessionalTypeRequest> get profTypeList => _profTypeList;

  List<PartnerTypeMasterDataModel> _partnerMasterDataList = [];
  List<PartnerTypeMasterDataModel> get partnerMasterDataList =>
      _partnerMasterDataList;

  List<PartnerTypeRequest> _partnerTypeList = [];
  List<PartnerTypeRequest> get partnerTypeList => _partnerTypeList;
  bool isBusinesOwnerVisible = true;
  bool isPractinionerVisible = true;
  bool isPharmacyVisible = true;
  ProfessionalTypeRequest typeRequest = ProfessionalTypeRequest();
  PartnerTypeRequest partnerTypeRequest = PartnerTypeRequest();

  String loadingMsg = "";
  // Future addBusinessType(type) async {
  //   try {
  //     typeRequest.professionalId = SessionManager.getUser.id;
  //     typeRequest.professionalTypeId = type;
  //
  //     setState(ViewState.Loading);
  //     var response = await _portfolioServices.postProfessionalType(typeRequest);
  //
  //     if (response.statusCode == 200) {
  //       setState(ViewState.Completed);
  //       if (type == 2)
  //         _navigationService.navigateTo(Routes.selectPartnerTypeView);
  //       else
  //         _navigationService.navigateTo(Routes.dashboardView);
  //     } else {
  //       setState(ViewState.Completed);
  //       _snackBarService.showSnackBar(
  //           title: response.message, snackbarType: SnackbarType.error);
  //       _navigationService.navigateTo(Routes.selectPartnerTypeView);
  //     }
  //   } catch (e) {
  //     setState(ViewState.Completed);
  //     _snackBarService.showSnackBar(
  //         title: somethingWentWrong, snackbarType: SnackbarType.error);
  //     _navigationService.navigateTo(Routes.selectPartnerTypeView);
  //   }
  // }

  init() async {
    await getPartnerMasterData();
    await getPartnerType();
  }

  Future getPartnerMasterData() async {
    try {
      loadingMsg = "Fetching Partners";
      setState(ViewState.Loading);
      var response = await _portfolioServices.getAllPartners();

      if (response.statusCode == 200) {
        var data = response.result as List;
        if (data.length >= 1)
          data.forEach((element) {
            _partnerMasterDataList
                .add(PartnerTypeMasterDataModel.fromMap(element));
          });

        setState(ViewState.Completed);
      } else {
        setState(ViewState.Completed);
        // _snackBarService.showSnackBar(
        //     title: response.message, snackbarType: SnackbarType.error);
        // _navigationService.navigateTo(Routes.selectPartnerTypeView);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
      // _navigationService.navigateTo(Routes.selectPartnerTypeView);
    }
  }

  Future addPartnerType(type) async {
    try {
      partnerTypeRequest.professionalId = SessionManager.getUser.id;
      partnerTypeRequest.partnerId = type;

      setState(ViewState.Loading);
      var response =
          await _portfolioServices.postPartnerType(partnerTypeRequest);

      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        if (type == 1)
          _navigationService.navigateTo(Routes.dashboardView);
        else
          _navigationService.navigateTo(Routes.pharmacyDashBoardView);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message, snackbarType: SnackbarType.error);
        // _navigationService.navigateTo(Routes.pharmacyDashBoardView);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
      // _navigationService.navigateTo(Routes.pharmacyDashBoardView);
    }
  }

  // Future getProfessionalType()async
  // {
  //   try
  //   {
  //     loadingMsg = "Fetching your portfolio";
  //   setState(ViewState.Loading);
  //   var response = await _portfolioServices.getProfessionalTypeByProfId(SessionManager.getUser.id??0);
  //
  //   if (response.statusCode == 200) {
  //
  //
  //     var data = response.result as List;
  //
  //     if(data.length == 0)
  //       {
  //          isBusinesOwnerVisible = true;
  //          isPractinionerVisible =  true;
  //       }
  //     data.forEach((element) {
  //
  //       profTypeList.add(ProfessionalTypeRequest.fromMap(element));
  //
  //     });
  //
  //     profTypeList.forEach((element) {
  //
  //       if(element.professionalTypeId == 1)
  //         isPractinionerVisible = false;
  //
  //       if(element.professionalTypeId == 2)
  //         isBusinesOwnerVisible = false;
  //
  //     });
  //
  //     setState(ViewState.Completed);
  //
  //   } else {
  //     setState(ViewState.Completed);
  //     // _snackBarService.showSnackBar(
  //     //     title: response.message, snackbarType: SnackbarType.error);
  //    // _navigationService.navigateTo(Routes.selectPartnerTypeView);
  //   }
  // } catch (e) {
  // setState(ViewState.Completed);
  // _snackBarService.showSnackBar(
  // title: somethingWentWrong, snackbarType: SnackbarType.error);
  // //_navigationService.navigateTo(Routes.selectPartnerTypeView);
  // }
  // }

  Future getPartnerType() async {
    try {
      loadingMsg = "Fetching your portfolio";
      setState(ViewState.Loading);
      var response = await _portfolioServices
          .getPartnerTypeByProfId(SessionManager.getUser.id ?? 0);

      if (response.statusCode == 200) {
        var data = response.result as List;
        if (data.length >= 1)
          data.forEach((element) {
            partnerTypeList.add(PartnerTypeRequest.fromMap(element));
          });

        if (partnerTypeList
            .where((element) =>
                element.partnerId == partnerMasterDataList.first.id)
            .isNotEmpty) isPractinionerVisible = false;

        if (partnerTypeList
            .where(
                (element) => element.partnerId == partnerMasterDataList[4].id)
            .isNotEmpty) isPharmacyVisible = false;
        setState(ViewState.Completed);
      } else {
        setState(ViewState.Completed);
        // _snackBarService.showSnackBar(
        //     title: response.message, snackbarType: SnackbarType.error);
        // _navigationService.navigateTo(Routes.selectPartnerTypeView);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
      // _navigationService.navigateTo(Routes.selectPartnerTypeView);
    }
  }
}
