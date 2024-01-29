// import 'package:flutter/material.dart';
// import 'package:lifeeazy_medical/constants/ui_helpers.dart';
// import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
// import 'package:lifeeazy_medical/viewmodel/portfolio/portfolio_viewmodel.dart';
// import 'package:stacked/stacked.dart';
//
// import '../../common_widgets/common_appbar.dart';
// import '../../common_widgets/empty_list_widget.dart';
// import '../../common_widgets/loader.dart';
// import '../../constants/colors.dart';
// import '../../constants/strings.dart';
// import '../../constants/styles.dart';
// import '../../enums/viewstate.dart';
// import '../../get_it/locator.dart';
// import '../../prefs/local_storage_services.dart';
// import '../../routes/route.dart';
//
// class SelectProfessionalTypeView extends StatelessWidget {
//
//   late PortfolioViewModel _viewModel;
//
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<PortfolioViewModel>.reactive(
//         onModelReady: (model)=> model.getProfessionalType(),
//         viewModelBuilder: () => PortfolioViewModel(),
//         builder: (context, viewModel, child) {
//           _viewModel = viewModel;
//
//           return Scaffold(
//               body: _currentWidget()
//           );
//         }
//     );
//   }
//
//   Widget _body() {
//     return Center(
//       child: Container(
//         margin: EdgeInsets.only(left: 25,right: 25),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//               Text("Select Business Type",
//                 style: largeTextStyle.copyWith(fontWeight: FontWeight.w500),),
//               verticalSpaceLarge,
//
//
//               GestureDetector(
//                   onTap: () {
//                     if(_viewModel.isPractinionerVisible == true)
//                     _viewModel.addBusinessType(1);
//                     else
//                       locator<NavigationService>().navigateTo(Routes.dashboardView);
//
//                   },
//
//                   child: commonCard('Practitioner' ,isTitleVisible: _viewModel.isPractinionerVisible)),
//
//
//               Padding(
//                 padding: EdgeInsets.only(top: 20),
//               ),
//               GestureDetector(
//                   onTap: () {
//
//                      if(_viewModel.isBusinesOwnerVisible == true)
//                     _viewModel.addBusinessType(2);
//                      else
//                        locator<NavigationService>().navigateTo(Routes.selectPartnerTypeView);
//                   },
//
//                   child: commonCard('Business Owner',isTitleVisible: _viewModel.isBusinesOwnerVisible)),
//               Padding(
//                 padding: EdgeInsets.only(top: 20),
//               ),
//
//               GestureDetector(
//                   onTap: () {
//
//                     locator<LocalStorageService>().setIsLogIn(false);
//                     locator<NavigationService>().navigateToAndRemoveUntil(
//                         Routes.loginView);
//                   },
//                   child: logOutCard())
//
//             ] //
//         ),
//       ),
//     );
//   }
//
//   Widget _currentWidget() {
//     switch (_viewModel.state) {
//       case ViewState.Loading:
//         return Loader(
//           loadingMessage: "",
//           loadingMsgColor: Colors.black,
//         );
//
//       case ViewState.Completed:
//         return _body();
//
//       case ViewState.Error:
//         return Center(
//             child: Text(
//               somethingWentWrong,
//               style: mediumTextStyle,
//             ));
//       case ViewState.Empty:
//         return EmptyListWidget("Nothing Found");
//       default:
//         return _body();
//     }
//   }
//
//   Widget commonCard(String name,{bool isTitleVisible = true}) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       width: 250,
//
//       decoration: BoxDecoration(
//         color: baseColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Text(
//                 name,
//                 textAlign: TextAlign.center,
//                 style: mediumTextStyle.copyWith(color: Colors.white)
//             ),
//
//             Visibility(
//               visible:isTitleVisible,
//               child: Text(
//                   "Not a $name",
//                   textAlign: TextAlign.center,
//                   style: smallTextStyle.copyWith(color: Colors.red,fontWeight: FontWeight.w500)
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget logOutCard() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       height: 50,
//       width: 250,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           border: Border.all(color: baseColor, width: 1)
//       ),
//       child: Center(
//         child: Text(
//             "Log Out",
//             textAlign: TextAlign.center,
//             style: mediumTextStyle.copyWith(color: baseColor)
//         ),
//       ),
//     );
//   }
//
// }
