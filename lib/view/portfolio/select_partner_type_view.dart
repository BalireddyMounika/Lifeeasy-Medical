import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/portfolio/portfolio_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../common_widgets/empty_list_widget.dart';
import '../../common_widgets/loader.dart';
import '../../constants/strings.dart';
import '../../constants/styles.dart';
import '../../enums/viewstate.dart';
import '../../get_it/locator.dart';
import '../../prefs/local_storage_services.dart';
import '../../routes/route.dart';

class SelectPartnerTypeView extends StatelessWidget {
  SelectPartnerTypeView({Key? key}) : super(key: key);

  late PortfolioViewModel _viewModel;
  late BuildContext context;
  // get children => null;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ViewModelBuilder<PortfolioViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (BuildContext context, PortfolioViewModel model, Widget? child) {
        _viewModel = model;
        return Scaffold(
            bottomSheet: ButtonContainer(
              buttonText: "Log Out",
              onPressed: () {
                locator<LocalStorageService>().setIsLogIn(false);
                locator<NavigationService>()
                    .navigateToAndRemoveUntil(Routes.loginView);
              },
            ),
            body: _currentWidget());
      },
      viewModelBuilder: () => PortfolioViewModel(),
    );
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: "",
          loadingMsgColor: Colors.black,
        );

      case ViewState.Completed:
        return _body();

      case ViewState.Error:
        return Center(
            child: Text(
          somethingWentWrong,
          style: mediumTextStyle,
        ));
      case ViewState.Empty:
        return EmptyListWidget("Nothing Found");
      default:
        return _body();
    }
  }

  Widget commonCard(String name, bool isVisible, index) {
    return GestureDetector(
      onTap: () {
        if (name == 'CertifiedHCP' || name == 'Pharmacy') {
          if (_viewModel.isPractinionerVisible == true && index == 0)
            _viewModel
                .addPartnerType(_viewModel.partnerMasterDataList[index].id);
          else if (_viewModel.isPractinionerVisible == false && index == 0)
            locator<NavigationService>()
                .navigateToAndRemoveUntil(Routes.dashboardView);
          if (_viewModel.isPharmacyVisible == true && index == 4)
            _viewModel
                .addPartnerType(_viewModel.partnerMasterDataList[index].id);
          else if (_viewModel.isPharmacyVisible == false && index == 4)
            locator<NavigationService>()
                .navigateToAndRemoveUntil(Routes.pharmacyDashBoardView);
        }
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: name == 'CertifiedHCP' || name == 'Pharmacy'
              ? baseColor
              : disableColor,
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (name == 'Pharmacy') ...{
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      name + "(Beta)",
                      textAlign: TextAlign.center,
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                } else ...{
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                },
                Visibility(
                  visible: index == 0
                      ? _viewModel.isPractinionerVisible
                      : _viewModel.isPharmacyVisible,
                  child: Text("Not Registered",
                      textAlign: TextAlign.center,
                      style: smallTextStyle.copyWith(
                          color: disableColor, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            if (name != 'CertifiedHCP' && name != 'Pharmacy') ...{
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Coming Soon',
                  style: bodyTextStyle.copyWith(color: Colors.white),
                ),
              )
            }
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpaceLarge,
        Text(
          "Select Partner Type",
          style: titleTextStyle.copyWith(color: redColor),
        ),
        Flexible(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: kToolbarHeight, left: 5, right: 5),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: _viewModel.partnerMasterDataList.length,
                itemBuilder: (context, index) {
                  return commonCard(
                      _viewModel.partnerMasterDataList[index].partnerType ?? "",
                      true,
                      index);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1 / 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
