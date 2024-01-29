
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:stacked/stacked.dart';

class CustomBaseViewModel extends BaseViewModel
{
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
