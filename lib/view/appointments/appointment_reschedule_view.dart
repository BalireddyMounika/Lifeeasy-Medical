import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/routes/route.dart';
class AppointmentrescheduleView extends StatelessWidget {
    BuildContext? _context;
    final _formkey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     // TODO: implement build
     return Scaffold(
       appBar: CommonAppBar(
         title: appointmentReschedule,
         onBackPressed: () {
           Navigator.pop(context);
         },
         onClearPressed: () {
           Navigator.pushNamedAndRemoveUntil(
               context, Routes.dashboardView, (route) => false);
         },
         // isClearButtonVisible: true,
         // onClearPressed: () {
         //   locator<NavigationService>()
         //       .navigateToAndRemoveUntil(Routes.dashboardView);
         // },
       ),
       body: _body(),
     );
   }
       Widget _body()
     {
     return Stack(
       children:[
        SingleChildScrollView(
         child: Form(
     key: _formkey,
         child: Container(
           margin: EdgeInsets.only(right: 25,left: 25),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                 child: Row(
                   children: [
                     Text(bookAppointmentSlot,style: TextStyle(color: Colors.black,fontSize: 17),),
                   ],
                 ),
                 margin: EdgeInsets.all(15),
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   _calendarView(),
                 ],
               ),
               Container(
                 child: Row(
                   children: [
                     Text("Set Time",style: TextStyle(color:Colors.black,fontSize:17),),
                   ],
                 ),
                  // margin: EdgeInsets.all(2),
                 padding: EdgeInsets.all(2),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                    Flexible(child: _timeslot("9:00Am")),

                    // _timeslot("9:00AM"),
                   // _timeslot("9:30AM"),
                   // _timeslot("10:00AM"),
                   // _timeslot("10:30AM"),

                 ],
               ),
               // Row(
               //   mainAxisAlignment: MainAxisAlignment.start,
               //   children: [
               //      _times("11:00AM"),
               //      _times("11:30AM"),
               //      _times("12:00PM"),
               //      _times("12:30AM"),
               //   ],
               // ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   _name("Username:rahul"),
                   _name("Mobile Number:9987654327"),
                   _name("AppointmentType:Video consult"),
                 ],
               ),
               Container(
                 child: Row(
                   children: [
                     Text("Appointment Date: Tue 27-09-2021 at 9:30AM",style: TextStyle(color:Colors.black,fontSize:14),),
                   ],
                 ),
                 margin: EdgeInsets.all(7),
                 // padding: EdgeInsets.all(2),
               ),
               _concern(),
               _careprovider(),
               _speciality(),
               // SizedBox(
               //   height: 30,
               // ),
     //           ButtonContainer(
     //             buttonText: "Reschedule",
     //             onPressed: () {
     //               if (_formkey.currentState!.validate()) {}
     // },
     //           )
             ],
           ),
         ),
       ),
       ),
       Align(
       alignment: Alignment.bottomCenter,
       child: ButtonContainer(
                     buttonText: "Reschedule",
                     onPressed: () {
                       if (_formkey.currentState!.validate()) {}
         },
                   )

     ),
       ]
     );
     }
     }
    Widget _calendarView()
    {
      return CalendarDatePicker(
        initialDate: DateTime.now().add(new Duration(days: 1)),
        lastDate:  DateTime.now().add(new Duration(days: 45)),
        firstDate: DateTime.now(),
        onDateChanged: (DateTime value) {
           // _viewModel.selectDate(value);
        },

      );
    }
    Widget _timeslot(String title) {
      return     GridView.builder(
          itemCount:8,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,

            mainAxisSpacing: 9,
            childAspectRatio: (2 / 0.8),
          ),
          itemBuilder: (context,index,) {
            return GestureDetector(
                onTap: (){
               // _viewModel.selectTimeSlots(index);
            },
      child: Container(
            child: Center(
              child: Text(
                        title,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
            ),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(3),
      ),
      ),
      );
      },
      );
    }
    //   return Container(
    //     child: Center(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           title,
    //           style: TextStyle(color: Colors.black, fontSize: 15),
    //         ),
    //       ),
    //     ),
    //     margin: EdgeInsets.all(6),
    //      decoration: BoxDecoration(
    //        border: Border.all(color: Colors.grey,),
    //      ),
    //      // padding: EdgeInsets.all(1)
    //
    //   );
    // }
    Widget _times(String title) {
      return Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
        margin: EdgeInsets.all(5),
         decoration: BoxDecoration(
           border: Border.all(color: Colors.grey,),
         ),
         // padding: EdgeInsets.all(1)

      );
    }
    Widget _name(String title) {
      return Container(child: Center(
              child: Center(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
          ),
           margin: EdgeInsets.all(8),
             padding: EdgeInsets.all(2)

      );
    }
    Widget _concern() {
      return TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {

        },
        onSaved: (value) {},
        validator: (value) {
          if (value!.isEmpty){
            return'Please enter some text';
 }
 },
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: concern,
          alignLabelWithHint: true,
        ),
      );
    }
    Widget _careprovider() {
      return TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
        },
        onSaved: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: careProvider,
          alignLabelWithHint: true,
        ),
      );
    }
    Widget _speciality() {
      return TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {

        },
        onSaved: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
        },
        style: mediumTextStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          labelStyle: textFieldsHintTextStyle,
          hintStyle: textFieldsHintTextStyle,
          labelText: speciality,
          alignLabelWithHint: true,
        ),
      );
    }
