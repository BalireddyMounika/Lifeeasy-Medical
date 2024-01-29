import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/dimens.dart';

class ListSelector extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final String title;
  final List<String> data;
  final String emptyLabel;

  const ListSelector({
    Key? key,
    required this.child,
    required this.onTap,
    required this.title,
    required this.data,
    this.emptyLabel = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    RxList<String> tempList = RxList(data);

    return GestureDetector(
      onTap: () => Get.bottomSheet(
        Column(children: [
          SizedBox(height: 20.0),
          Expanded(
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  onChanged: (String val) {
                    if (val.isNotEmpty) {
                      tempList.value = [];
                      List<String> temp = data
                          .where((element) =>
                              element.toLowerCase().contains(val.toLowerCase()))
                          .toList();
                      tempList.addAll(temp);
                    } else {
                      tempList.value = data;
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    suffixIcon: Icon(Icons.search, size: 24),
                    hintText: "Search $title",
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Obx(
                    () => data.isNotEmpty
                        ? ListView(
                            padding: const EdgeInsets.only(),
                            children: [
                              for (String value in tempList)
                                ListTile(
                                    dense: true,
                                    title: Text(value),
                                    onTap: () {
                                      onTap(value);
                                      controller.text = "";
                                      tempList.value = [];
                                      tempList.value = data;
                                      Get.back();
                                    })
                            ],
                          )
                        : Center(
                            child: Text(
                            'no data',
                          )),
                  ),
                ),
              ],
            ),
          )
        ]).paddingSymmetric(horizontal: 12),
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: AbsorbPointer(
        absorbing: true,
        child: child,
      ),
    );
  }
}
