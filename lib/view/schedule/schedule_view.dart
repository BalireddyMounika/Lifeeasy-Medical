import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_card.dart';
import 'package:lifeeazy_medical/common_widgets/common_searchbar.dart';
import 'package:lifeeazy_medical/common_widgets/list_selector.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/view/schedule/create_schedule_view.dart';
import 'package:lifeeazy_medical/viewmodel/schedule/schedule_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleViewModel>.reactive(
      onViewModelReady: (model) {
        model.initialiseData();
      },
      viewModelBuilder: () => ScheduleViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          bottomNavigationBar: ButtonContainer(
            onPressed: () async {
              bool? isScheduleCreated =
                  await Get.to(() => CreateScheduleView());
              if (isScheduleCreated ?? false) {
                viewModel.getScheduleResponse();
              }
            },
            buttonText: "Create Schedule",
          ),
          appBar: AppBar(
            title: Text('Schedule'),
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommonCard(
                      child: CommonSearchbar(
                        textController: viewModel.searchController,
                        onChange: (String data) {
                          viewModel.filerScheduleList(data);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ListSelector(
                      data: [
                        "All",
                        "Teleconsultation",
                        "Home",
                        "In-clinic",
                      ],
                      onTap: (String data) {
                        viewModel.filterByCategory(data);
                      },
                      title: 'consultation',
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.baseColor),
                        ),
                        child: Row(
                          children: [
                            Obx(
                              () => Expanded(
                                child: Text(
                                  '${viewModel.selectedCategory.value}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: AppColors.baseColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Obx(
                () => Expanded(
                  child: viewModel.tempScheduleList.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: viewModel.tempScheduleList.length,
                          itemBuilder: (context, idx) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: CommonCard(
                                    child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Container(
                                          //     padding: EdgeInsets.all(17),
                                          //     decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.circular(8),
                                          //         color: Color(0xffcee7f7)),
                                          //     child: SvgPicture.asset(
                                          //         'images/icons/inclinc_icon.svg')),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${viewModel.tempScheduleList[idx].scheduleV2Id?.typeConsultation}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Color(
                                                              0xffcee7f7)),
                                                      child: SvgPicture.asset(
                                                        'images/icons/inclinc_icon.svg',
                                                        height: 20,
                                                      )),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${viewModel.tempScheduleList[idx].scheduleV2Id?.clinicId?.clinicName}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(height: 6),
                                                      Text(
                                                        "${viewModel.tempScheduleList[idx].fromTime} - ${viewModel.tempScheduleList[idx].toTime} ",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                          vertical: 12, horizontal: 12),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.unSelectedColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          )),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: AppColors.whiteColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          viewModel.tempScheduleList[idx]
                                                      .scheduleV2Id?.fromDate !=
                                                  null
                                              ? Text(
                                                  '${DateFormat("d MMM yyyy").format(viewModel.tempScheduleList[idx].scheduleV2Id?.fromDate ?? DateTime.now())} - ${DateFormat("d MMM yyyy").format(viewModel.tempScheduleList[idx].scheduleV2Id?.toDate ?? DateTime.now())}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.whiteColor),
                                                )
                                              : Text(''),
                                          Spacer(),
                                          Text(
                                            'INR ${viewModel.tempScheduleList[idx].fees}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.whiteColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                          vertical: 10, horizontal: 14),
                                    )
                                  ],
                                )),
                              ))
                      : Center(
                          child: Text(
                              'No Schedule for ${viewModel.selectedCategory}'),
                        ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
        );
      },
    );
  }
}
