import 'package:stacked/stacked.dart';

class SignInOtpViewModel extends BaseViewModel
{
  int _currentScreen = 1;
  get currentScreen => _currentScreen;
  SignInOtpViewModel();
  void incrementCurrentScreenValue() {
    if (_currentScreen != 3) {
      _currentScreen = _currentScreen + 1;
    }
    notifyListeners();
  }

  void decrementCurrentScreenValue() {

    if (_currentScreen != 1)
      _currentScreen = _currentScreen - 1;
    notifyListeners();
  }
}