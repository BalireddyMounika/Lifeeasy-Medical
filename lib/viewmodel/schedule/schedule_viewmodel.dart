import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/schedule/CreateScheduleRequest.dart';
import 'package:lifeeazy_medical/models/schedule/ScheduleListReqponse.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/schedule/schedule_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class ScheduleViewModel extends CustomBaseViewModel {
  TextEditingController searchController = TextEditingController();
  TextEditingController consultationTypeController = TextEditingController();
  TextEditingController selectClinicController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController slotStartTimeController = TextEditingController();
  TextEditingController slotEndTimeController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDaeController = TextEditingController();

  RxList<ScheduleListResponse> scheduleList = RxList();
  RxList<ScheduleListResponse> tempScheduleList = RxList();
  RxList<String> clinicNameList = RxList();

  RxString selectedCategory = RxString('All');

  late int clinicId;

  ScheduleService scheduleService = locator<ScheduleService>();

  List<String> consultationTypeList = ["Teleconsultation", "Home", "InClinic"];

  initialiseData() {
    getScheduleResponse();
  }

  createSchedule() async {
    CreateScheduleRequest requestData = CreateScheduleRequest(
      hcpId: SessionManager.getUser.id,
      fromDate: fromDateController.text,
      toDate: toDaeController.text,
      clinicId: 0,
      typeConsultation: consultationTypeController.text,
    );
    GenericResponse response =
        await scheduleService.createSchedule(requestData);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Schedule Created');
    } else {
      Fluttertoast.showToast(msg: '${response.message}');
    }
  }

  getScheduleResponse() async {
    GenericResponse response = await scheduleService.getScheduleData(
        hcpId: SessionManager.getUser.id ?? 0);
    if (response.statusCode == 200) {
      scheduleList.clear();
      tempScheduleList.clear();
      var data = response.result as List;
      data.forEach((element) {
        scheduleList.add(ScheduleListResponse.fromMap(element));
      });
      tempScheduleList.value = scheduleList;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Clinic data not found');
    }
  }

  filterByCategory(String category) {
    selectedCategory.value = category;
    if (category != 'All') {
      tempScheduleList.value = scheduleList
          .where((e) => e.scheduleV2Id?.typeConsultation == category)
          .toList();
    } else {
      tempScheduleList.value = scheduleList;
    }
  }

  filerScheduleList(String value) {
    if (value.isNotEmpty) {
      tempScheduleList.value = scheduleList
          .where((e) =>
              ("${e.scheduleV2Id?.clinicId?.clinicName} ${e.fees} ${e.scheduleV2Id?.typeConsultation}  ")
                  .toLowerCase()
                  .contains(value.trim().toLowerCase()))
          .toList();
      tempScheduleList.refresh();
    } else {
      tempScheduleList.assignAll(scheduleList);
    }
  }
}
