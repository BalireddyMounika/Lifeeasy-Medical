import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeeazy_medical/common_widgets/loader.dart';
import 'package:lifeeazy_medical/common_widgets/profile_image_widget.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/view/profile/widgets/educational_info_widget.dart';
import 'package:lifeeazy_medical/view/profile/widgets/personal_info_widget.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../get_it/locator.dart';
import '../../services/common_service/navigation_service.dart';

class ProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfileView();
}

class _MyProfileView extends State<ProfileView>
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
      onModelReady: (model) {
        model.getHcpDetailInfo();
      },
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Color(0xffF9F9F9),
            appBar: AppBar(title: Text('Profile')),
            body: _currentWidget());
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpaceMedium,
            _doctorCard(),
            verticalSpaceLarge,
            Text(
              'More Details',
              style: TextStyle(fontSize: 17),
            ),
            verticalSpaceMedium,
            _personalInformation(),
            verticalSpaceMedium,
            _Educational(),
            verticalSpaceMedium,
            _Professional(),
            verticalSpaceMedium,
            _Clinic(),
            verticalSpaceMedium,
            _Schedule(),
          ],
        ),
      ),
    );
  }

  Widget _personalInformation() {
    return GestureDetector(
      onTap: () {
        Map map = Map();
        map['response'] = _viewModel.hcpDetailResponse;

        locator<NavigationService>()
            .navigateTo(Routes.personalInformationView, arguments: map);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: baseColor,
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Educational() {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(Routes.educationalInfoView);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    Icons.book_outlined,
                    color: baseColor,
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Text(
                  'Educational',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Schedule() {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(Routes.scheduleView);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    Icons.schedule,
                    color: baseColor,
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Text(
                  'Schedule',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Clinic() {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(Routes.clinicView);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    Icons.wallet_travel_rounded,
                    color: baseColor,
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Text(
                  'Clinic',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Professional() {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(Routes.professionalInfoView);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    Icons.airplay,
                    color: baseColor,
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Text(
                  'Professional',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doctorCard() {
    return Container(
      width: 362,
      height: 208,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            color: Colors.grey,
            spreadRadius: 0.05,
            blurRadius: 3,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          verticalSpaceMedium,
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                horizontalSpaceSmall,
                ProfileImageWidget(
                  circleSize: 100,
                ),
                horizontalSpaceMedium,
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_viewModel.hcpDetailResponse.firstname} ${_viewModel.hcpDetailResponse.lastname}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      verticalSpaceTiny,
                      Text(
                        '${_viewModel.hcpDetailResponse.professional?.specialization ?? 'Specialization'}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff899CA8),
                        ),
                      ),
                      verticalSpaceTiny,
                      Container(
                        // height: 50,
                        // width: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_viewModel.hcpDetailResponse.mobileNumber}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${_viewModel.hcpDetailResponse.email}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          verticalSpaceMedium,
          Container(
            height: 60,
            width: 326,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                horizontalSpaceSmall,
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Card(
                    child: Icon(
                      Icons.location_on,
                      size: 20,
                      color: baseColor,
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                Text(
                  '${SessionManager.getLocation.city ?? 'Clinic'} ${SessionManager.getLocation.state ?? 'Address'}',
                  style: TextStyle(fontSize: 14),
                ),
                //TODO add active - in active status
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyPrevious() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_tabController.index == 0)
                        showDialog(
                          context: context,
                          builder: (dialogContext) => SimpleDialog(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          Navigator.pop(dialogContext);
                                          var image = await _picker.pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 60);
                                          setState(() {
                                            _image = File(image?.path ?? "");
                                            _viewModel
                                                .addUserProfileImage(_image);
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
                                              ),
                                            ],
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () async {
                                          Navigator.pop(dialogContext);
                                          var image = await _picker.pickImage(
                                              source: ImageSource.gallery,
                                              imageQuality: 60);
                                          setState(() {
                                            _image = File(image?.path ?? "");
                                            _viewModel
                                                .addUserProfileImage(_image);
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
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                    },
                    child: _profileCurrentWidget(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${SessionManager.getUser.firstName} ${SessionManager.getUser.lastName}",
                        style: mediumTextStyle.copyWith(color: darkColor),
                      ),
                      Text(
                        "${SessionManager.getUser.email}",
                        style: mediumTextStyle.copyWith(
                            color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        "${SessionManager.getUser.mobileNumber}",
                        style: mediumTextStyle.copyWith(
                            color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
              _status(
                  'Status : ${_viewModel.currentStatus == 0 ? 'Active' : 'Not Active'}',
                  _viewModel.currentStatus),
            ],
          ),
        ),
        verticalSpaceSmall,
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
              Tab(
                text: personalProfile,
              ),
              Tab(
                text: educationalProfile,
              ),
              Tab(
                text: professionalProfile,
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
              //   ProfessionalInfoWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _topView() {
    return Row(
      children: [
        _profileCurrentWidget(),
        SizedBox(
          width: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${SessionManager.getUser.firstName} ${SessionManager.getUser.lastName}",
              style: mediumTextStyle.copyWith(color: darkColor),
            ),
            Text(
              "${SessionManager.getUser.email}",
              style: mediumTextStyle.copyWith(color: darkColor),
              textAlign: TextAlign.right,
            ),
            Text(
              "${SessionManager.getUser.mobileNumber}",
              style: mediumTextStyle.copyWith(color: darkColor),
              textAlign: TextAlign.right,
            ),
          ],
        )
      ],
    );
  }

  Widget _virtula() {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context!).nearestScope;
        },
        onSaved: (value) {},
        validator: (value) {},
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: virtula,
          suffixIcon: Icon(
            Icons.share,
            color: darkColor,
            size: 24,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _update() {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context!).nearestScope;
        },
        onSaved: (value) {},
        validator: (value) {},
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: update,
          suffixIcon: Icon(
            Icons.food_bank_outlined,
            color: Colors.green,
            size: 24,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _status(String title, var status) {
    return Container(
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: status == 0 ? baseColor : Colors.red, fontSize: 13),
          ),
        ),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: status == 0 ? baseColor : Colors.red),
        ));
  }

  Widget _updateyour() {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context!).nearestScope;
        },
        onSaved: (value) {},
        validator: (value) {},
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: updateYour,
          suffixIcon: Icon(
            Icons.food_bank_outlined,
            color: Colors.green,
            size: 24,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _profileCurrentWidget() {
    switch (_viewModel.profileState) {
      case ProfileImageState.Loading:
        return Loader(
          isScaffold: false,
        );

      case ProfileImageState.Completed:
        return SizedBox(
            height: 70,
            width: 50,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: baseColor,
              foregroundImage:
                  Image.network(SessionManager.profileImageUrl ?? "").image,
            ));

      case ProfileImageState.Error:
        return Center(
            child: Icon(
          Icons.error,
          size: 30,
        ));

      case ProfileImageState.Idle:
        return Container(
          height: 70,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ]),
          child: Center(
            child: Icon(
              Icons.add_a_photo,
              color: darkColor,
              size: 30,
            ),
          ),
        );
      default:
        return _body();
    }
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
