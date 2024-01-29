import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/appointments/get_appointment_response.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/viewmodel/add_notes/add_note_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddNoteView extends StatefulWidget {
  GetAppointmentResponse appointmentResponse = GetAppointmentResponse();
  AddNoteView(this.appointmentResponse);
  @override
  State<StatefulWidget> createState() => _AddNoteView();
}
class _AddNoteView extends State<AddNoteView> {
  late AddNoteViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNoteViewModel>.reactive(
      onModelReady: (model) => model.getNoteInfo,
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomSheet: ButtonContainer(
              buttonText: "Add Notes",
              onPressed: () {
                _viewModel.postNoteInfo();
              },
            ),
            appBar: CommonAppBar(
              title: "Add Notes",
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
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/1.5,
              child: TextFormField(
                autofocus: true,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,//Normal textInputField will be displayed,
                  maxLines: 100,
                controller: _viewModel.notesController,
                decoration: InputDecoration(
                  labelStyle: textFieldsHintTextStyle,
                  hintStyle: textFieldsHintTextStyle,
                  labelText: "Add Notes",
                  border: InputBorder.none,

                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(loadingMessage: _viewModel.loadingMsg,);

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
}

