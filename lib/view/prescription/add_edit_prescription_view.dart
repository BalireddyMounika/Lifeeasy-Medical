import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/view/prescription/widgets/medication_widget.dart';
import 'package:lifeeazy_medical/viewmodel/prescription/prescription_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddEditPrescriptionView extends StatefulWidget {
  GetAppointmentResponse appointmentResponse;

  AddEditPrescriptionView(this.appointmentResponse);

  @override
  State<StatefulWidget> createState() => _AddeditprescriptionView();
}

class _AddeditprescriptionView extends State<AddEditPrescriptionView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  // final _picker = ImagePicker();
  //  late File _image;
  //  bool isImageSelected = false;
  late PrescriptionViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrescriptionViewModel>.reactive(

      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
          appBar: CommonAppBar(
            title: addprescription,
            onBackPressed: () {
              Navigator.pop(context);
            },
            onClearPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.dashboardView, (route) => false);
            },
          ),
          body: _currentWidget(),
        );
      },
      viewModelBuilder: () =>
          PrescriptionViewModel.add(widget.appointmentResponse),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        DefaultTabController(
          initialIndex: _selectedIndex,
          length: 2,
          child: TabBar(
            indicatorColor: secondaryColor,
            isScrollable: false,
            unselectedLabelColor: darkColor,
            labelColor: baseColor,
            automaticIndicatorColorAdjustment: true,
            controller: _tabController,
            onTap: (index) {
              _tabController.animateTo(index);
            },
            tabs: [
              Tab(text: medication),
              // Tab(
              //   text: "Lab/Imaging",
              // ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [MedicationWidget()],
          ),
        ),
      ],
    );
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: _viewModel.loadingMsg,
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
}

// class AddeditprescriptionView extends StatelessWidget {
// @override
// Widget build(BuildContext context) {
// TODO: implement build
// return Scaffold(
//   appBar: CommonAppBar(
//     title:  " Add Prescription ",
//     onBackPressed: () {
//       Navigator.pop(context);
//     },
//     isClearButtonVisible: true,
//     onClearPressed: () {
//       locator<NavigationService>()
//           .navigateToAndRemoveUntil(Routes.dashboardView);
//     },
//   ),
//
// );
// }
