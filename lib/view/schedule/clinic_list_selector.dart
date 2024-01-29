import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeeazy_medical/common_widgets/common_searchbar.dart';
import 'package:lifeeazy_medical/common_widgets/text_field/common_text_input_field.dart';
import 'package:lifeeazy_medical/models/profile/clinic_info_request.dart';

class ClinicListView extends StatelessWidget {
  final List<ClinicInfoRequest> data;
  const ClinicListView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    RxList<ClinicInfoRequest> tempList = RxList(data);
    return Scaffold(
        appBar: AppBar(
          title: Text('Clinic List'),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            CommonSearchbar(
                onChange: (val) {
                  if (val.isNotEmpty) {
                    tempList.value = [];
                    List<ClinicInfoRequest> temp = data
                        .where((element) => element.clinicName!
                            .toLowerCase()
                            .contains(val.toLowerCase()))
                        .toList();
                    tempList.addAll(temp);
                  } else {
                    tempList.value = data;
                  }
                },
                textController: controller),
            Expanded(
                child: ListView.builder(
                    itemCount: tempList.length,
                    itemBuilder: (context, idx) => ListTile(
                          onTap: () => Get.back(result: tempList[idx]),
                          title: Text('${tempList[idx]}'),
                        )))
          ],
        ));
  }
}
