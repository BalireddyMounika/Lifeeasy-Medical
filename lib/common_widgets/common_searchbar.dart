import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';

class CommonSearchbar extends StatelessWidget {
  final double? width;
  final TextEditingController textController;
  final Function(String)? onChange;
  const CommonSearchbar(
      {Key? key, this.width, required this.textController, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        onChanged: onChange,
        controller: textController,
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.baseColor)),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.baseColor),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: AppColors.baseColor,
                width: 1.0,
              ),
            )),
            child: Icon(
              Icons.search,
              size: 22,
              color: AppColors.baseColor,
            ),
          ),
          suffixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
        ),
      ),
    );
  }
}
