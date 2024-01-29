import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimeSelector extends StatelessWidget {
  final Widget child;
  final Function onSelect;
  const CustomTimeSelector(
      {Key? key, required this.child, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((value) {
        onSelect(value);
      }),
      child: AbsorbPointer(
        child: child,
      ),
    );
  }
}
