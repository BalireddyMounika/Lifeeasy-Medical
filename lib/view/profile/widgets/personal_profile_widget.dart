
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PersonalProfileWidget extends ViewModelWidget<ProfileViewModel>
{
  @override
  Widget build(BuildContext context, viewModel) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _body(),
            _education(),
            _specialization(),
            _mci(),
            _state(),
            _Number(),
            _years(),
            _timings(),
            _slot(),

          ]

        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save,),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () => {},
      ),
      );



  }


  Widget _body()
  {
    return Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.person,color: Colors.blue,size: 24,),
              SizedBox(
                width: 20,
              ),
              Text(raghu,style: TextStyle(color: Colors.black,fontSize: 15),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(4),

    );
  }
  Widget _education()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.auto_stories,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Text(qualification,style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _specialization()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.dynamic_feed,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Text(specialization,style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _mci()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.image,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Text(mCINumber,style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _state()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.file_copy_outlined,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Text(mCIStateCouncil,style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _Number()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.phone,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Text("+91 - 9987654321",style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _years()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.cases_rounded,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Text("Experiance - 9Years",style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _timings()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.calendar_today_outlined,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text("In-Person Timings Tuesday  Session1:8:00am-8:30am", maxLines: 3,
                style: TextStyle(color: Colors.black,fontSize: 15),
              ),
            ),

          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );

  }
  Widget _slot()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.watch_later,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text("slot Timinings:30mins Appointment Type:in-clinic",maxLines:2,style: TextStyle(color: Colors.black,fontSize: 13
              ),
              ),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );
  }


}

