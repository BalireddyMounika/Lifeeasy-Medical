import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/custom_date_picker.dart';
import 'package:lifeeazy_medical/common_widgets/list_selector.dart';
import 'package:lifeeazy_medical/common_widgets/text_field/common_text_input_field.dart';
import 'package:lifeeazy_medical/common_widgets/time_selector.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/viewmodel/schedule/create_schedule_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CreateScheduleView extends StatefulWidget {
  const CreateScheduleView({Key? key}) : super(key: key);

  @override
  State<CreateScheduleView> createState() => _CreateScheduleViewState();
}

class _CreateScheduleViewState extends State<CreateScheduleView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateScheduleViewModel>.reactive(
      onViewModelReady: (model) => model.initializeData(),
      viewModelBuilder: () => CreateScheduleViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        bottomNavigationBar: ButtonContainer(
          buttonText: 'Submit',
          onPressed: () => viewModel.createSchedule(),
        ),
        appBar: AppBar(
          title: Text('Create Schedule'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Visibility(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ListSelector(
                        onTap: (v) {
                          viewModel.consultationTypeController.text = v;
                        },
                        title: 'Consultation',
                        data: viewModel.consultationTypeList,
                        child: CommonTextInputField(
                          isEnable: false,
                          label: 'Choose Consultation type',
                          textController: viewModel.consultationTypeController,
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                              Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemCount: viewModel.clinicList.length,
                                      itemBuilder: (context, idx) => InkWell(
                                        onTap: () {
                                          Get.back();
                                          viewModel.selectedClinicId.value =
                                              viewModel.clinicList[idx].id ?? 0;
                                          viewModel.selectClinicController
                                              .text = viewModel
                                                  .clinicList[idx].clinicName ??
                                              '';
                                        },
                                        child: ListTile(
                                          title: Text(
                                              '${viewModel.clinicList[idx].clinicName}'),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              backgroundColor: AppColors.whiteColor);
                          // Get.to(ClinicListView(
                          //   data: viewModel.clinicList.value,
                          // ));
                        },
                        child: CommonTextInputField(
                            isEnable: false,
                            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                            label: 'Select Clinic',
                            textController: viewModel.selectClinicController),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: CustomDatePicker(
                      onDateSelect: (date) {
                        viewModel.fromDate.value =
                            DateFormat('yyyy-MM-dd').format(date);
                        viewModel.fromDateController.text =
                            DateFormat('dd MMM yyyy').format(date);
                      },
                      child: CommonTextInputField(
                        suffixIcon: Icon(Icons.event),
                        isEnable: false,
                        textController: viewModel.fromDateController,
                        label: 'From Date',
                      ),
                    )),
                    SizedBox(width: 12),
                    Expanded(
                        child: CustomDatePicker(
                      onDateSelect: (date) {
                        viewModel.toDate.value =
                            DateFormat('yyyy-MM-dd').format(date);
                        viewModel.toDateController.text =
                            DateFormat('dd MMM yyyy').format(date);
                      },
                      child: CommonTextInputField(
                        suffixIcon: Icon(Icons.event),
                        isEnable: false,
                        textController: viewModel.toDateController,
                        label: 'To Date',
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTimeSelector(
                        onSelect: (data) {
                          viewModel.slotStartTimeController.text =
                              MaterialLocalizations.of(context)
                                  .formatTimeOfDay(data);
                        },
                        child: CommonTextInputField(
                            isEnable: false,
                            suffixIcon: Icon(Icons.access_time),
                            label: 'Slot Start time',
                            textController: viewModel.slotStartTimeController),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomTimeSelector(
                        onSelect: (data) {
                          viewModel.slotEndTimeController.text =
                              MaterialLocalizations.of(context)
                                  .formatTimeOfDay(data);
                        },
                        child: CommonTextInputField(
                            isEnable: false,
                            suffixIcon: Icon(Icons.access_time),
                            label: 'Slot end time',
                            textController: viewModel.slotEndTimeController),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CommonTextInputField(
                    textInputType:
                        TextInputType.numberWithOptions(signed: true),
                    label: 'Slot time',
                    textController: viewModel.slotTimeController),
                SizedBox(height: 20),
                CommonTextInputField(
                    textInputType:
                        TextInputType.numberWithOptions(signed: true),
                    label: 'Fee',
                    textController: viewModel.feeController),
              ],
            ).paddingSymmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }
}
