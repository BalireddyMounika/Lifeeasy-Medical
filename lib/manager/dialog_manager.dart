import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';


class DialogManager extends StatefulWidget {
  final Widget child;

  DialogManager({Key? key, required this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  late BuildContext _context;
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return widget.child;
  }

  void _showDialog(DialogType dialogType, String title, String msg,
      String routes, String buttonText,bool isStackCleared) {
    showDialog(
        context: _context,
        builder: (context) => PopUpDialog(
          dialogType: dialogType,
          title: title,
          routes: routes,
          isStackCleared: isStackCleared,
          buttonText: buttonText,
          message: msg,
          // onPressed: onPressed
        ));
  }
}
