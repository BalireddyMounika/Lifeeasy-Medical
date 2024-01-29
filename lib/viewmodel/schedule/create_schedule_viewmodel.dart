import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/profile/clinic_list_response.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/schedule/CreateScheduleRequest.dart';
import 'package:lifeeazy_medical/models/schedule/slot_timeing_request.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/schedule/schedule_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';

class CreateScheduleViewModel extends CustomBaseViewModel {
  TextEditingController searchController = TextEditingController();
  TextEditingController consultationTypeController = TextEditingController();
  TextEditingController selectClinicController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController slotStartTimeController = TextEditingController();
  TextEditingController slotEndTimeController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController slotTimeController = TextEditingController();

  ScheduleService scheduleService = locator<ScheduleService>();

  final createScheduleFormKey = GlobalKey<FormState>();

  List<String> consultationTypeList = ["Teleconsultation", "Home", "InClinic"];

  RxList<ClinicListResponse> clinicList = RxList();
  RxList<String> clinicNameList = RxList();
  RxInt selectedClinicId = RxInt(0);

  bool isScheduleCreated = false;

  RxString fromDate = RxString('');
  RxString toDate = RxString('');

  initializeData() {
    getClinicResponse();
  }

  createSchedule() async {
    CreateScheduleRequest requestData = CreateScheduleRequest(
      hcpId: SessionManager.getUser.id,
      fromDate: fromDate.value,
      toDate: toDate.value,
      clinicId: selectedClinicId.value,
      typeConsultation: consultationTypeController.text,
    );
    GenericResponse response =
        await scheduleService.createSchedule(requestData);
    if (response.statusCode == 200) {
      createSlotTime(schedulerId: response.result['id']);
    } else {
      Fluttertoast.showToast(
          msg: 'You have already schedule between this days');
    }
  }

  createSlotTime({required int schedulerId}) async {
    SlotTimingRequest slotTimingRequest = SlotTimingRequest(
        hcpId: SessionManager.getUser.id,
        scheduleV2Id: schedulerId,
        slotTimings: slotTimeController.text.isNotEmpty
            ? int.parse(slotTimeController.text)
            : 0,
        scheduleName: "test",
        fees: int.parse(feeController.text),
        fromTime: slotStartTimeController.text,
        toTime: slotEndTimeController.text);
    GenericResponse response =
        await scheduleService.setSlotTime(slotTimingRequest);
    if (response.statusCode == 200) {
      isScheduleCreated = true;
      Get.back(result: isScheduleCreated);
      Fluttertoast.showToast(msg: "Schedule Created");
      clearScheduleForm();
    } else {
      Fluttertoast.showToast(msg: "${response.message}");
    }
  }

  getClinicResponse() async {
    GenericResponse response = await scheduleService.getClinicData(
        hcpId: SessionManager.getUser.id ?? 0);
    if (response.statusCode == 200) {
      var data = response.result as List;
      data.forEach((element) {
        clinicList.add(ClinicListResponse.fromMap(element));
      });
      clinicList.forEach((e) {
        clinicNameList.add(e.clinicName ?? '');
      });
      print(clinicNameList);
    } else {
      Fluttertoast.showToast(msg: 'Clinic data not found');
    }
  }

  clearScheduleForm() {
    consultationTypeController.clear();
    selectClinicController.clear();
    fromDateController.clear();
    toDateController.clear();
    slotStartTimeController.clear();
    slotEndTimeController.clear();
    slotTimeController.clear();
    feeController.clear();
  }
}
