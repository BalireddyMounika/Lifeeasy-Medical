import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final Widget child;
  final Function onDateSelect;
  final DateTime? initialDate;
  const CustomDatePicker(
      {Key? key,
      required this.child,
      required this.onDateSelect,
      this.initialDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        ).then((value) {
          onDateSelect(value);
        });
      },
      child: AbsorbPointer(
        child: child,
      ),
    );
  }
}
