import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';

class CommonCard extends StatelessWidget {
  final double? width;
  final Widget child;
  const CommonCard({Key? key, this.width, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.disableColor,
            blurRadius: 7.0, // has the effect of softening the shadow
            spreadRadius: 0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              1.0, // vertical, move down 10
            ),
          )
        ],
      ),
      width: width,
      child: child,
    );
  }
}
