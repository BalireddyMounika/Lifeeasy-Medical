import 'package:flutter/cupertino.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/constants/ui_helpers.dart';

class EmptyListWidget extends StatelessWidget
{
  String?  title;
  String?  image ="";
  EmptyListWidget(this.title,{this.image});
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(child: Image.asset(this.image == null?"images/empty.jpg":this.image??"",height: 150,width: 150,)),

          verticalSpaceMedium,

          Text(title??"NA",style: mediumTextStyle,)


      ],
    );

  }

}