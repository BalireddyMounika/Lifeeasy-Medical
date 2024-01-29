import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/styles.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';

import '../../main.dart';

class SnackBarService {
  void showSnackBar({String? title, SnackbarType? snackbarType}) {
    final SnackBar snackBar = SnackBar(
      content: Text(title ?? "",
          style: mediumTextStyle.copyWith(color: Colors.white)),
      backgroundColor: getColor(snackbarType ?? SnackbarType.simple),
      duration: new Duration(seconds: 3),
    );
    globalContextKey.currentState?.showSnackBar(snackBar);
  }

  Color getColor(SnackbarType snackbarType) {
    switch (snackbarType) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.info:
        return Colors.blueGrey;
      case SnackbarType.simple:
        return baseColor;

      default:
        return baseColor;
    }
  }
}
