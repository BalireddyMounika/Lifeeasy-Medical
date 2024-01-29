import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/styles.dart';

//ignore: must_be_immutable
class ButtonContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final double? width;
  final double? height;
  final String? button;
  Color buttonColor = baseColor;

  ButtonContainer({
    this.onPressed,
    this.buttonText,
    this.height,
    this.width,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onPressed!();
      },
      child: Container(
        height: this.height ?? kToolbarHeight,
        width: this.width,
        decoration: BoxDecoration(color: this.buttonColor),
        child: Center(
          child: Text(
            this.buttonText ?? "",
            style: mediumTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class ButtonContainerWithBorder extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final double? width;
  final double? height;
  Color buttonColor = baseColor;

  ButtonContainerWithBorder({
    this.onPressed,
    this.buttonText,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onPressed!();
      },
      child: Container(
        height: this.height ?? kToolbarHeight,
        width: this.width,
        decoration: BoxDecoration(
            border: Border.all(color: buttonColor, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            this.buttonText ?? "",
            style: mediumTextStyle.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
