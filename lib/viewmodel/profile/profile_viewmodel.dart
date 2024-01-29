import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/authentication/location_response_model.dart';
import 'package:lifeeazy_medical/models/profile/clinic_info_request.dart';
import 'package:lifeeazy_medical/models/profile/clinic_list_response.dart';
import 'package:lifeeazy_medical/models/profile/educational_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/hcp_detail_response.dart';
import 'package:lifeeazy_medical/models/profile/personal_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/personal_profile_update_request.dart';
import 'package:lifeeazy_medical/models/profile/professional_profile_request.dart';
import 'package:lifeeazy_medical/models/profile/scheduler_request.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/prefs/local_storage_services.dart';
import 'package:lifeeazy_medical/services/common_api/common_api_service.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/services/profile/profile_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

enum ProfileImageState { Loading, Completed, Error, Idle, Empty }

class ProfileViewModel extends CustomBaseViewModel {
  String loaderMsg = "";
  bool isScheduleEdit = false;
  bool isClinicEdit = false;
  String signatureImageUrl = '';

  List<ClinicListResponse> clinicListResponse = [];

  List<ConsultantTypeModel> consultantTypeList = [];
  List<String> selectedConsultantType = [];
  List<String> _specializationList = [];
  List<String> get specializationList => _specializationList;
  ProfessionalProfileRequest professionalProfileRequest =
      ProfessionalProfileRequest();

  PersonalProfileRequest profileRequest = new PersonalProfileRequest();
  var _profileService = locator<ProfileServices>();
  var _dialogService = locator<DialogService>();
  var _snackBarService = locator<SnackBarService>();
  var _commonService = locator<CommonApiService>();
  var _prefs = locator<LocalStorageService>();
  TextEditingController cityTextController = TextEditingController(text: "");
  TextEditingController addressTextController = TextEditingController(text: "");
  TextEditingController stateTextController = TextEditingController(text: "");
  TextEditingController zipCodeTextController = TextEditingController(text: "");
  TextEditingController firstnameController = TextEditingController(text: "");
  TextEditingController lastnameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();

  ProfileViewModel() {
    consultantTypeList.add(
        new ConsultantTypeModel(name: "In-clinic", index: 0, isSelected: true));
    consultantTypeList.add(new ConsultantTypeModel(
        name: "Teleconsultation", index: 1, isSelected: false));
    consultantTypeList.add(
        new ConsultantTypeModel(name: "Home", index: 2, isSelected: false));

    //selectedConsultantType.add("InClinic");
    profileRequest.state = SessionManager.getLocation.state;
    profileRequest.city = SessionManager.getLocation.city;
    profileRequest.address = SessionManager.getLocation.address;
    profileRequest.pincode = SessionManager.getLocation.pinCode.toString();
  }

  late ProfileViewModel _viewModel;
  late FocusNode timezoneFocusNode = new FocusNode();
  late FocusNode mobileFocusNode = new FocusNode();
  late FocusNode emailFocusNode = new FocusNode();
  late FocusNode cityFocusNode = new FocusNode();
  late FocusNode addressFocusNode = new FocusNode();
  late FocusNode zipcodeFocusNode = new FocusNode();
  late FocusNode submitFocusNode = new FocusNode();
  late FocusNode collegeFocusNode = new FocusNode();
  late FocusNode yearsFocusNode = new FocusNode();
  late FocusNode degreeFocusNode = new FocusNode();
  late FocusNode educationFocusNode = new FocusNode();
  late FocusNode professionalFocusNode = new FocusNode();
  late FocusNode mciFocusNode = new FocusNode();
  late FocusNode mciStateFocusNode = new FocusNode();
  late FocusNode areaFocusNode = new FocusNode();
  late FocusNode experienceFocusNode = new FocusNode();
  late FocusNode patientsFocusNode = new FocusNode();
  late FocusNode handledFocusNode = new FocusNode();
  late FocusNode slotFocusNode = new FocusNode();

  var stateList = [
    "State",
    "Andhra Pradesh",
    "Telangana",
    "Others",
  ];
  var degreeList = [
    "Degree",
    "MBBS",
    "MS",
    "MD",
    "BAMS",
    "BHMS",
    " BPT" "Others",
  ];
  var collegeList = [
    "College/University",
    "GITAM",
    " AIIMS",
    "CMC Vellore",
    "others",
  ];
  var yearList = [
    "Year",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "others",
  ];
  var educationList = [
    "Education Location",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Telangana",
    "Others",
  ];
  var experianceList = [
    "Experiance",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  var currentList = [true, false];

  int degree = 0;
  int year = 0;
  int expInYears = 0;
  int currentStatus = 0;
  int specialisation = 0;
  int stateIndex = 0;
  int selectedClinicId = 0;

  // GetProfileResponse getProfileResponse = new GetProfileResponse();
  ProfileImageState _profileState = ProfileImageState.Idle;

  ProfileImageState get profileState => _profileState;

  void setProfileState(ProfileImageState viewState) {
    _profileState = viewState;
    notifyListeners();
  }

  String clinicFromDays = " ";
  String clinicToDays = " ";

  String clinicFromTime = " ";
  String clinicToTime = " ";

  ClinicInfoRequest clinicInfoRequest = new ClinicInfoRequest();
  ScheduleRequest schedulerInfoRequest = new ScheduleRequest();
  HcpDetailResponse hcpDetailResponse = new HcpDetailResponse();

  EducationalProfileRequest educationalProfileRequest =
      EducationalProfileRequest();

  initialisedDate() async {
    await getClinicList();
    // await getSchedulerInfo();
  }

  void showSnackBar() {
    _snackBarService.showSnackBar(
        title: "Working", snackbarType: SnackbarType.success);
  }

  void selectConsultantType(index) {
    selectedConsultantType = [];
    consultantTypeList.forEach((element) {
      if (element.index == index)
        element.isSelected == true
            ? element.isSelected = false
            : element.isSelected = true;
    });
    notifyListeners();
  }

  Future getAllSpecialization() async {
    var response = await _commonService.getSpecialisation();

    var data = response.result as List;
    data.forEach((element) {
      _specializationList.add(element["Specialization"]);
    });

    if (data.length > 0)
      professionalProfileRequest.specialization =
          specializationList[specialisation];
  }

  Future addPersonalProfile() async {
    try {
      loaderMsg = "Adding Profile";
      setState(ViewState.Loading);
      profileRequest.state = stateTextController.text;
      profileRequest.hcpId = SessionManager.getUser.id;
      profileRequest.profilePicture =
          SessionManager.profileImageUrl ?? "string";

      var response = await _profileService.postPersonalProfile(profileRequest);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);

        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future addClinic() async {
    try {
      loaderMsg = "Adding Clinic Details";
      setState(ViewState.Loading);
      clinicInfoRequest.hcpId = SessionManager.getUser.id;
      var response = await _profileService.postClinicInfo(clinicInfoRequest);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);

        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future addEducationalProfile() async {
    try {
      loaderMsg = "Adding Educational Profile";
      setState(ViewState.Loading);
      educationalProfileRequest.hcpId = SessionManager.getUser.id;
      var response = await _profileService
          .postEducationalProfile(educationalProfileRequest);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);

        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future updatePersonalProfile() async {
    try {
      loaderMsg = "Updating Profile";
      setState(ViewState.Loading);
      profileRequest.state = stateTextController.text;
      profileRequest.hcpId = SessionManager.getUser.id;
      profileRequest.profilePicture = SessionManager.profileImageUrl;
      var response = await _profileService.updatePersonalProfile(
          new PersonalProfileUpdateRequest(
              hcpId: new HcpId(
                firstname: firstnameController.text,
                lastname: lastnameController.text,
                email: emailController.text,
              ),
              profilePicture: profileRequest.profilePicture,
              address: profileRequest.address,
              state: stateTextController.text,
              pincode: profileRequest.pincode,
              timezone: profileRequest.timezone,
              city: profileRequest.city),
          hcpDetailResponse.profile!.id ?? 0);
      // setState(ViewState.Loading);
      // profileRequest.state = stateTextController.text;
      // profileRequest.hcpId = SessionManager.getUser.id;
      // profileRequest.profilePicture = SessionManager.profileImageUrl;
      // var response = await _profileService.updatePersonalProfile(
      //
      //     profileRequest, SessionManager.getUser.id ?? 0);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        SessionManager.getUser.firstName = firstnameController.text;
        SessionManager.getUser.lastName = lastnameController.text;
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future updateClinic() async {
    try {
      loaderMsg = "Updating Clinic Details";
      setState(ViewState.Loading);
      clinicInfoRequest.hcpId = SessionManager.getUser.id;
      if (clinicInfoRequest.hcpId != null) {
        var response = await _profileService.updateClinicInfo(
            clinicInfoRequest, clinicInfoRequest.id ?? 0);
        if (response.statusCode == 200) {
          setState(ViewState.Completed);
          getClinicList();
          _snackBarService.showSnackBar(
              title: response.message ?? somethingWentWrong,
              snackbarType: SnackbarType.success);
        } else {
          setState(ViewState.Completed);
          _snackBarService.showSnackBar(
              title: response.message ?? somethingWentWrong,
              snackbarType: SnackbarType.error);
        }
      } else {
        Fluttertoast.showToast(msg: 'First fill profile details.');
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future updateEducationalProfile() async {
    try {
      loaderMsg = "Update Educational Profile";
      setState(ViewState.Loading);
      educationalProfileRequest.hcpId = SessionManager.getUser.id;
      var response = await _profileService.updateEducationalProfile(
          educationalProfileRequest, SessionManager.getUser.id ?? 0);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);

        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future addProfessionalProfile() async {
    try {
      loaderMsg = "Adding Professional Profile";
      setState(ViewState.Loading);
      professionalProfileRequest.hcpId = SessionManager.getUser.id;
      professionalProfileRequest.appointmentType = ["Teleconsultation", "Home"];
      professionalProfileRequest.patientsHandledPerSlot = 1;
      professionalProfileRequest.patientsHandledPerDay = 20;

      professionalProfileRequest.currentStatus = 'Active';
      professionalProfileRequest.signature = signatureImageUrl;

      var response = await _profileService
          .postProfessionalProfile(professionalProfileRequest);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future updateProfessionalProfile() async {
    try {
      loaderMsg = "Updating Professional Profile";
      setState(ViewState.Loading);
      professionalProfileRequest.hcpId = SessionManager.getUser.id;
      professionalProfileRequest.signature = signatureImageUrl;
      consultantTypeList.forEach((element) {
        if (element.isSelected == true)
          selectedConsultantType.add(element.name ?? "");
      });
      professionalProfileRequest.appointmentType =
          selectedConsultantType.length >= 1
              ? selectedConsultantType
              : ["In-clinic"];

      professionalProfileRequest.currentStatus = 'Active';

      var response = await _profileService.updateProfessionalProfile(
          professionalProfileRequest, SessionManager.getUser.id ?? 0);

      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future addSchedulerProfile() async {
    try {
      loaderMsg = "Adding Scheduler Info";
      setState(ViewState.Loading);
      schedulerInfoRequest.hcpId = SessionManager.getUser.id;

      var response =
          await _profileService.postSchedulerInfo(schedulerInfoRequest);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future updateSchedulerProfile() async {
    try {
      loaderMsg = "Updating Scheduler Info";
      setState(ViewState.Loading);
      schedulerInfoRequest.hcpId = SessionManager.getUser.id;

      var response = await _profileService.updateSchedulerInfo(
          schedulerInfoRequest, SessionManager.getUser.id ?? 0);
      if (response.statusCode == 200) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.success);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  // Future getClinicInfo() async {
  //   loaderMsg = "Fetching Clinic Details";
  //   setState(ViewState.Loading);
  //
  //   try {
  //     var response =
  //         await _profileService.getClinicInfo(SessionManager.getUser.id ?? 0);
  //     if (response.statusCode == 200) {
  //       isClinicEdit = true;
  //       clinicInfoRequest = ClinicInfoRequest.fromMap(response.result[0]);
  //       setState(ViewState.Completed);
  //     } else {
  //       setState(ViewState.Completed);
  //       _snackBarService.showSnackBar(
  //           title: response.message ?? somethingWentWrong,
  //           snackbarType: SnackbarType.error);
  //     }
  //   } catch (e) {
  //     setState(ViewState.Completed);
  //     _snackBarService.showSnackBar(
  //         title: somethingWentWrong, snackbarType: SnackbarType.error);
  //   }
  // }

  Future getClinicList() async {
    loaderMsg = "Fetching Clinic Data";
    setState(ViewState.Loading);
    try {
      var response =
          await _profileService.getClinicList(SessionManager.getUser.id ?? 0);
      if (response.statusCode == 200) {
        var data = response.result as List;
        clinicListResponse.clear();
        data.forEach((e) {
          clinicListResponse.add(ClinicListResponse.fromMap(e));
        });
        setState(ViewState.Completed);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  updateClinicData({required ClinicListResponse data}) {
    clinicNameController.text = data.clinicName ?? '';
    clinicAddressController.text = data.address ?? '';
    clinicInfoRequest.id = data.id;
    isClinicEdit = true;
    notifyListeners();
  }

  void fillProfile() {
    cityTextController.text = profileRequest.city ?? '';
    stateTextController.text = profileRequest.state ?? '';
    addressTextController.text = profileRequest.address ?? '';
    zipCodeTextController.text =
        profileRequest.pincode == 'null' ? '' : profileRequest.pincode ?? "";
  }

  Future getSchedulerInfo() async {
    loaderMsg = "Fetching Schedule Details";
    setState(ViewState.Loading);
    try {
      var response = await _profileService
          .getSchedulerInfo(SessionManager.getUser.id ?? 0);
      if (response.statusCode == 200) {
        isScheduleEdit = true;
        schedulerInfoRequest = ScheduleRequest.fromMap(response.result);
        setState(ViewState.Completed);
      } else {
        if (isClinicEdit == false)
          setState(ViewState.Error);
        else
          setState(ViewState.Completed);
        // _snackBarService.showSnackBar(
        //     title: "Clinic details mandatory before Scheduler",
        //     snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future getHcpDetailInfo() async {
    loaderMsg = "Fetching Your Details";

    setState(ViewState.Loading);

    getAllSpecialization();
    try {
      var response = await _profileService
          .getHcpDetailInfo(SessionManager.getUser.id ?? 0);
      if (response.statusCode == 200) {
        hcpDetailResponse = HcpDetailResponse.fromMap(response.result);
        emailController.text = hcpDetailResponse.email ?? "";
        firstnameController.text = hcpDetailResponse.firstname ?? "";
        lastnameController.text = hcpDetailResponse.lastname ?? "";
        profileRequest = hcpDetailResponse.profile ??
            new PersonalProfileRequest(
                state: SessionManager.getLocation.state,
                city: SessionManager.getLocation.city,
                pincode: SessionManager.getLocation.pinCode.toString(),
                address: SessionManager.getLocation.address);

        if (profileRequest.profilePicture == null)
          setProfileState(ProfileImageState.Idle);
        else {
          SessionManager.profileImageUrl = profileRequest.profilePicture;
          setProfileState(ProfileImageState.Completed);
        }

        educationalProfileRequest =
            hcpDetailResponse.education ?? new EducationalProfileRequest();
        professionalProfileRequest =
            hcpDetailResponse.professional ?? new ProfessionalProfileRequest();
        signatureImageUrl = hcpDetailResponse.professional?.signature ?? '';
        hcpDetailResponse.professional?.appointmentType?.forEach((element) {
          consultantTypeList.forEach((cElement) {
            if (cElement.name == element) cElement.isSelected = true;
          });
        });

        fillProfile();

        setState(ViewState.Completed);
      } else {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
            title: response.message ?? somethingWentWrong,
            snackbarType: SnackbarType.error);
      }
    } catch (e) {
      setState(ViewState.Completed);
      _snackBarService.showSnackBar(
          title: somethingWentWrong, snackbarType: SnackbarType.error);
    }
  }

  Future addUserProfileImage(file) async {
    try {
      setProfileState(ProfileImageState.Loading);
      var response = await _commonService.postImage(file);
      if (response.hasError == false) {
        var data = response.result as Map<String, dynamic>;
        var image = data["Image"];
        _prefs.setProfileImage(image);
        setProfileState(ProfileImageState.Completed);
        SessionManager.profileImageUrl = image;
      } else {
        setProfileState(ProfileImageState.Error);
      }
    } catch (e) {
      setProfileState(ProfileImageState.Error);
    }
  }

  void setClinicFromDate(date) {
    clinicInfoRequest.fromDate = date;
    clinicFromDays = date;
    notifyListeners();
  }

  void reload() {
    notifyListeners();
  }

  Future updateLocation(var data) async {
    if (data != null) {
      var s = data;
      var country = "";
      var state = "";
      var city = "";
      var address = "";
      var length = s!.split(',').length;
      for (int i = length; i >= 0; i--) {
        country = s!.split(',')[length - 1];
        if (length > 1) state = s!.split(',')[length - 2];
        if (length > 2) city = s!.split(',')[length - 3];

        if (i < length - 3) address = s!.split(',')[i] + "," + address;
      }

      SessionManager.setLocation = new LocationResponseModel(
          lat: 00.0,
          long: 00.0,
          city: city,
          country: country,
          pinCode: 0,
          state: state,
          address:
              address.isEmpty ? "$state,$country" : "$address $city $country");

      cityTextController.text = SessionManager.getLocation.city ?? '';
      addressTextController.text = SessionManager.getLocation.address ?? '';
      stateTextController.text = SessionManager.getLocation.state ?? '';

      locator<LocalStorageService>()
          .setLocation(SessionManager.getLocation.toJson());
    }

    notifyListeners();
  }
}

class ConsultantTypeModel {
  String? name;
  bool? isSelected;
  int? index;

  ConsultantTypeModel({this.name, this.isSelected, this.index});
}
