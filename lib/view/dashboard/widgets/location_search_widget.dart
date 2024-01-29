import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/common_widgets/empty_list_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/models/location/google_auto_complete_response.dart';
import 'package:lifeeazy_medical/viewmodel/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LocationSearchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationSearchWidget();
}

class _LocationSearchWidget extends State<LocationSearchWidget> {
  late DashBoardViewModel viewModel;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ViewModelBuilder<DashBoardViewModel>.reactive(
      builder: (context, viewModel, child) {
        this.viewModel = viewModel;

        return Scaffold(
            body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              _searchBox(),
              SizedBox(
                height: 10,
              ),
              _currentStateWidget(),
            ],
          ),
        ));
      },
      viewModelBuilder: () => DashBoardViewModel(),
    );
  }

  Widget _searchList() {
    return Flexible(
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: viewModel.autoCompleteList.length,
          itemBuilder: (context, index) {
            return _listConatiner(viewModel.autoCompleteList[index]);
          }),
    );
  }

  Widget _listConatiner(Predictions model) {
    return GestureDetector(

      onTap: () {

        Navigator.of(context).pop(model.description);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            model.description!,
                            style:
                                mediumTextStyle.copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(top: 0, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        height: kToolbarHeight,
        child: Row(
          children: <Widget>[
            Container(
                child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: baseColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            Flexible(
              child: Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width - 20,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  autofocus: true,
                  onChanged: (text) {
                    viewModel.getAutoComplete(text);
                  },
                  decoration: InputDecoration(
                    hintText: "your address",
                    hintStyle: mediumTextStyle.copyWith(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Visibility(
                  visible: false, child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currentStateWidget() {
    switch (viewModel.state) {
      case ViewState.Empty:
        return EmptyListWidget("Search Not Found");
      case ViewState.Loading:
        return CircularProgressIndicator(
          strokeWidth: 0.5,
        );
        break;
      case ViewState.Completed:
        return _searchList();
        break;
      case ViewState.Error:
        return Center(
          child: Text(somethingWentWrong),
        );
        break;
      default:
        return Center(
          child: Text(
            "Your Search Will Appear Here",
            style: mediumTextStyle.copyWith(color: Colors.grey),
          ),
        );
    }
  }
}
