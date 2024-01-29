import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/common_widgets/search_view.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/add_notes/add_note_viewmodel.dart';
import 'package:stacked/stacked.dart';


class AddNoteListView extends StatefulWidget {
  GetAppointmentResponse appointmentResponse = GetAppointmentResponse();
  AddNoteListView(this.appointmentResponse);
  @override
  State<StatefulWidget> createState() => _AddListView();
}
class _AddListView extends State<AddNoteListView> {
  late AddNoteViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNoteViewModel>.reactive(
      onModelReady: (model) => model.getNoteInfo(),
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(

            appBar: CommonAppBar(
              title: addedNotes,
              isClearButtonVisible: true,
              onBackPressed: () {
                Navigator.pop(context);
              },

              onClearPressed: () {
                locator<NavigationService>()
                    .navigateToAndRemoveUntil(Routes.dashboardView);
              },
            ),

            body: _currentWidget()
        );
      },
      viewModelBuilder: () => AddNoteViewModel(widget.appointmentResponse),
    );
  }
  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(loadingMessage: _viewModel.loadingMsg,);
      case ViewState.Empty:
        return  EmptyListWidget("Nothing Found");
      case ViewState.Completed:
        return _body();

      case ViewState.Error:
        return const Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(fontSize: 18),
            ));

      default:
        return _body();
    }
  }
  Widget _body () {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Column(
        children: [
          Card(

            elevation: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/1.5,
              child: ClipRect(child: Text(_viewModel.addNoteData.selfNote??"",style: mediumTextStyle.copyWith(color: Colors.grey),))
            ),
          ),
        ],
      ),
    );
  }
  Widget _itemContainer(index) {
    return Card(
      elevation: 2,
      child: Container(
          margin: dashBoardMargin,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dateContainer("Ram Kumar"),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _details("Name","Kumar"),
                  _details("Mobile", "9876547867"),

                ],
              ),
            ],
          )),
    );
  }
  Widget _dateContainer(String title) {
    return Center(
      child: Center(
        child: Container(
          height: 40,
          width: 700,
          child: Row(
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(color: baseColor, fontSize: 16),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: baseColor)
          ),
        ),
      ),
    );
  }
  Widget _details(String title, String data) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "$title : ", style: TextStyle(color: Colors.black,fontSize: 15)),
                      TextSpan(text: data, style: TextStyle( color:Colors.grey,)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(4),
    );
  }
}






