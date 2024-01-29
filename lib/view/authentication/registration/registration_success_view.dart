import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/button_container.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/margins.dart';
import 'package:lifeeazy_medical/constants/screen_constants.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/routes/route.dart';

class RegistrationSuccessView extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        margin: authMargin,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: displayHeight(context)*1,),
                Center(
                  child: Container(
                    height: displayHeight(context)*3,
                    width: displayWidth(context)*3,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: baseColor,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Icon(Icons.done,size: 48,color: Colors.white,),
                    ),

                  ),
                ),


                FittedBox(
                    fit: BoxFit.contain,
                    child: Text(registerSuccessFul,style: largeTextStyle.copyWith(color: secondaryColor),)),

                SizedBox(height: displayHeight(context)*0.5,),

                Text("$welcomeMsg ${SessionManager.getUser.firstName} !!",style: headerTextStyle.copyWith(color: Colors.black,fontWeight:FontWeight.bold),),

                SizedBox(height: 10,),

                Text(onBoardMsg,style: bodyTextStyle.copyWith(color: Colors.black,),),




              ],


            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: buttonBottomPadding),
                  child: ButtonContainer(
                    buttonText: goToDashBoard,
                    onPressed: () {

                       Navigator.pushNamedAndRemoveUntil(context, Routes.selectPartnerTypeView, (route) => false);

                    },
                  ),
                ))
          ],
        ),
      ),

    );
  }
}
