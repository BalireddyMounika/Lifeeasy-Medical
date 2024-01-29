import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lifeeazy_medical/viewmodel/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ClinicProfileWidget extends ViewModelWidget<ProfileViewModel>
{
  @override
  Widget build(BuildContext context, viewModel) {

    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          children: [
            _body(),
            _phone(),
            _details(),

            _clinic(),
            _add(),


          ],

        ),

        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
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
              Icon(Icons.person,color: Colors.blue,size: 22,),
              SizedBox(
                width: 20,
              ),
              Text("Radhavendra Clinic-Ecil",style: TextStyle(color: Colors.black,fontSize: 15),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(7),

      );
    }
  Widget _phone()
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
            Text("+91 9987654321",style: TextStyle(color: Colors.black,fontSize: 15),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );
  }
  Widget _details()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.image,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
                Expanded(
                  child: Text("LOCATIONSLOT:-CBMCompound,Asilmetta,Visakhapatnam,AndhraPradesh,530003.",maxLines: 3,style: TextStyle(color: Colors.black,fontSize:14),
                  ),
                ),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );
  }
  Widget _clinic()
  {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.calendar_today_outlined,color: Colors.blue,size: 22,),
            SizedBox(
              width: 20,
            ),
            Center(
              child: Text("Clinic Timings Add Clinic Timings",style: TextStyle(color: Colors.black,fontSize:15),
              ),
            ),
            Icon(Icons.arrow_drop_down,color: Colors.black,size: 25,),
          ],
        ),
      ),
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(4),

    );
  }
  Widget _add()
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
            Center(
              child: Text("Clinic Image Add Clinic Image",style: TextStyle(color: Colors.black,fontSize:15),
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


