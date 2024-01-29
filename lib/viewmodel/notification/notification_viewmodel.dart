import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/notifications/get_notification_response.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/services/notifications/notifications_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';
class NotificationViewModel extends CustomBaseViewModel {
  var _notificationService = locator<NotificationService>();
  var _snackBarService = locator<SnackBarService>();
  List<GetNotificationResponse> _notificationList = [];
  List<GetNotificationResponse> get notificationList => _notificationList;
  String loadingMsg = "";
  GetNotificationResponse getNotificationResponse = GetNotificationResponse();

Future getNotificationInfo() async {
  try {
    loadingMsg = fetchingNotifications;
    setState(ViewState.Loading);

    var response = await _notificationService
        .getNotificationInfo(SessionManager.getUser.id ?? 0);

    if (response.hasError == true ?? false) {
      setState(ViewState.Error);
    } else {
      var data = response.result as List;

      data.forEach((element) {
        _notificationList.add(GetNotificationResponse.fromMap(element));
      });

      if (notificationList.length >= 1)
        setState(ViewState.Completed);
      else
        setState(ViewState.Empty);
    }
  }
  catch (e) {
    setState(ViewState.Error);
  }
}

}
