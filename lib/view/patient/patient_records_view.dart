import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/common_widgets/search_view.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';

class PatientRecordsView extends StatelessWidget {
  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CommonAppBar(
        title: patientRecords,
        onBackPressed: () {
          Navigator.pop(context);
        },
        isClearButtonVisible: true,
        onClearPressed: () {
          locator<NavigationService>()
              .navigateToAndRemoveUntil(Routes.dashboardView);
        },
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      margin: dashBoardMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchView(),
          Flexible(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return _itemContainer();
                }),
          ),
        ],
      ),
    );
  }

  // Widget _details(String title) {
  //   return Container(
  //     child: Center(
  //       child: Row(
  //         children: [
  //           Column(
  //             children: [
  //               Text(
  //                 title,
  //                 style: TextStyle(color: Colors.grey, fontSize: 15),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     margin: EdgeInsets.all(8),
  //   );
  // }
  Widget _itemContainer() {
    return Card(
      elevation: 2,
      child: Container(
        child: Column(
          children: [
            _details("Ram Kumar"),
            _details("ram@gmail.com"),
            _details("individual id :2357846"),
            _details("Blood Group : O+"),
            _details("Mobile # : 9985643768"),
            Divider(
              color: Colors.black,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
               children: [
                   Flexible(child: _data("")),

               ],
             ),
            Divider(
              color: Colors.black,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Text(viewRecords,style: TextStyle(color: Colors.black,fontSize: 14),),
                  margin: EdgeInsets.all(9),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            // CheckboxListTile(
            //   title: Text("title text"),
            //   value: checkedValue,
            //   onChanged: (newValue) {  },
            //   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            // )
          ],
        ),
      ),
    );

  }


  Widget _details(String title) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(10),
      // padding: EdgeInsets.all(1),
    );
  }

  Widget _data(String title) {
    return GridView.builder(
      itemCount: 6,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing:140,

        mainAxisSpacing: 2,
        childAspectRatio: (2/ 0.8),
      ),
      itemBuilder: (context, index,) {
        return GestureDetector(
          onTap: () {
            // _viewModel.selectTimeSlots(index);
          },
            child: Row(
              children: <Widget>[
                 Checkbox(
                     checkColor: Colors.green,
                     value: false,
                    onChanged: (value) {
                    print(value);}),
              Expanded(child: Text(allergies,style: TextStyle(color: Colors.grey),)),



              ],
            ),
          // child:Row(
          //   children: <Widget>[
          //     SizedBox(
          //       width: 10,
          //     ), //SizedBox
          //     Text(
          //       "Allergies",
          //       style: TextStyle(fontSize: 17.0),
          //     ), //Text
          //     SizedBox(width: 10), //SizedBox
          //     /** Checkbox Widget **/
          //     Checkbox(
                // value: this.value,
                 // onChanged: (bool value) {
                 //   setState(() {
                 //      this.value = value;
                 //   });
                 // },
              // ),
                // value: this.value,
                // onChanged: (bool value) {
                //   setState(() {
                //     this.value = value;
                //   });
                // },
               //Checkbox
            // ], //<Widget>[]
          // ), //Row



          // child: Container(
          //   child: Center(
          //     child: Text(
          //       title,
          //       style: TextStyle(color: Colors.black, fontSize: 4),
          //     ),
          //   ),
          //   margin: EdgeInsets.all(7),
          //   padding: EdgeInsets.all(2),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.green),
          //     borderRadius: BorderRadius.circular(2),
          //   ),
          // ),
        );
      },
    );
  }

}

