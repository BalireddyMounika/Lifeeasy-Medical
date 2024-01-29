import 'dart:async';
import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';

class DialogService {
  Function? _showDialogListener;
  Completer? _dialogCompleter;

  void registerDialogListener(Function showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future showDialog(DialogType dialogType,String title,String? msg,String routes,String buttonText,{bool isStackedCleared =false}) {
    _dialogCompleter = Completer();
    _showDialogListener!(dialogType,title,msg,routes,buttonText,isStackedCleared);
    return _dialogCompleter!.future;
  }

  void dialogComplete() {
    _dialogCompleter!.complete();
    _dialogCompleter = null;
  }
}