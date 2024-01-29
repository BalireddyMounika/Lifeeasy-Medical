import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/view/profile/widgets/educational_info_widget.dart';
import 'package:lifeeazy_medical/view/profile/widgets/personal_info_widget.dart';
import 'package:lifeeazy_medical/view/profile/widgets/professional_info_widget.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfileView();
}

class _MyProfileView extends State<AddProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final _picker = ImagePicker();
  late File _image;
  bool isImageSelected = false;
  late ProfileViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
//      viewModel.reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              title: myDetails,
              onBackPressed: () {
                Navigator.pop(context);
              },
              onClearPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.dashboardView, (route) => false);
              },
            ),
            body: _currentWidget());
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            SimpleDialog dialog = SimpleDialog(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            var image = await _picker.pickImage(
                                source: ImageSource.camera, imageQuality: 60);
                            setState(() {
                              _image = File(image?.path ?? "");
                              isImageSelected = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: baseColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  camera,
                                  style: mediumTextStyle,
                                )
                              ],
                            ),
                          )),
                      InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            var image = await _picker.pickImage(
                                source: ImageSource.gallery, imageQuality: 60);
                            setState(() {
                              _image = File(image?.path ?? "");
                              isImageSelected = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image,
                                  color: baseColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  gallery,
                                  style: mediumTextStyle,
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            );

            showDialog(context: context, builder: (_) => dialog);
          },
          child: isImageSelected
              ? SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: baseColor,
                    foregroundImage: Image.file(
                      _image,
                      fit: BoxFit.contain,
                    ).image,
                  ))
              : Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: darkColor,
                      size: 40,
                    ),
                  ),
                ),
        ),
        DefaultTabController(
          initialIndex: _selectedIndex,
          length: 3,
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
              Tab(text: "Personal"),
              Tab(
                text: "Educational",
              ),
              Tab(
                text: "Professional",
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              PersonalInfoWidget(),
              EducationalInfoView(),
              // ProfessionalInfoWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _currentWidget() {
    switch (_viewModel.state) {
      case ViewState.Loading:
        return Loader(
          loadingMessage: _viewModel.loaderMsg,
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

      default:
        return _body();
    }
  }
}
