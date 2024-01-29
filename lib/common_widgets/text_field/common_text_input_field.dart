import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';

class CommonTextInputField extends StatelessWidget {
  final TextEditingController textController;
  final String? label;
  final Icon? suffixIcon;
  final int? maxLength;
  final bool? isEnable;
  final String? hintText;
  final double? textFieldHeight;
  final TextInputType? textInputType;
  final validator;
  const CommonTextInputField({
    Key? key,
    this.label,
    this.suffixIcon,
    required this.textController,
    this.maxLength,
    this.isEnable,
    this.textFieldHeight,
    this.textInputType,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '$label',
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : SizedBox(),
        SizedBox(
            height: 40,
            child: TextFormField(
                validator: validator,
                keyboardType: textInputType,
                enabled: isEnable,
                scrollPadding: EdgeInsets.zero,
                controller: textController,
                decoration: InputDecoration(
                  hintText: hintText,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: suffixIcon,
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  constraints: BoxConstraints(minHeight: 40),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.unSelectedColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.baseColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.redColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.baseColor)),
                  // suffixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
                ))),
      ],
    );
  }
}
