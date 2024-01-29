import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/common_widgets/popup_dialog.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/enums/snackbar_type.dart';
import 'package:lifeeazy_medical/enums/viewstate.dart';
import 'package:lifeeazy_medical/get_it/locator.dart';
import 'package:lifeeazy_medical/models/profile/generic_response.dart';
import 'package:lifeeazy_medical/models/user/user.dart';
import 'package:lifeeazy_medical/models/vide_call/schedule_call_status.dart';
import 'package:lifeeazy_medical/models/vide_call/schedule_call_status_responce.dart';
import 'package:lifeeazy_medical/models/vide_call/video_call_responce.dart';
import 'package:lifeeazy_medical/net/session_manager.dart';
import 'package:lifeeazy_medical/routes/route.dart';
import 'package:lifeeazy_medical/services/common_service/dialog_services.dart';
import 'package:lifeeazy_medical/services/common_service/navigation_service.dart';
import 'package:lifeeazy_medical/services/common_service/snackbar_service.dart';
import 'package:lifeeazy_medical/services/video_call/video_call_service.dart';
import 'package:lifeeazy_medical/viewmodel/transaction/base_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/appointments/get_appointment_response.dart';

class VideoCallViewModel extends CustomBaseViewModel {
  Map<int, User> userMap = new Map<int, User>();
  int localIndex = 0;
  int remoteIndex = 1;
  bool displaySwitch = false;
  int? localUid;
  final channelControler = TextEditingController(text: "");
  bool validateError = false;
  bool isRemoteUserJoined = false;
  var loadingMsg = "";
  late RtcEngine engine;
  bool muted = false;
  int appointmentId;
  int userId ;
  List<GetScheduleCallStatusResponse> _scheduleCallStatusList = [];
  var _dialogService = locator<DialogService>();

  int count = 0;
  Timer? timer;

  //new
  bool isDisplaySwitch = false;
  bool isMicMute = false;
  int? remoteUId;
  bool localUserJoined = false;

  /// Agora credential modify this only

  String channel = 'test';
  String appId = '8cd2dce03a7643b0820f28f175877a73';
  var token =
      '007eJxTYFBV4ZxyKDQzeW8P67ecO7dCSm/4iyzX+b229pLQD8eDgcUKDBbJKUYpyakGxonmZibGSQYWRgZpRhZphuamFubmiebGOkeXJzcEMjIcDrvNzMgAgSC+GINPZlpqamJVZXx5ZklGfmlJfEl+dmoeAwMA3gMnTw==';

  //new end

  initializeData({required int agoraChannelName})async{
    appointmentId = agoraChannelName ;
    await getAgoraToke(channelName: agoraChannelName.toString());
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine.initialize( RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          onLocalUserJoin();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          remoteUId = remoteUid;
          onRemoteUserJoin(remoteUid: remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          onRemoteUserOffline(remoteUid);
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future getAgoraToke({required String channelName}) async {

    try {
      var response = await _videoCallService.agoraToken(channelName);
      if (response.hasError == false) {
        channel = response.result["channelName"];
        token = response.result["token"];
      }else{
        _dialogService.showDialog(
            DialogType.ErrorDialog, message, response.message, "", done);
        setState(ViewState.Completed);
      }
    } catch (error) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Completed);
    }

  }

  void onRemoteUserJoin({required int remoteUid}) {
    isRemoteUserJoined = true;
    remoteUId = remoteUid;
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        /// callback will be executed every 1 second, increament a count value
        /// on each callback
        count++;
      },
    );
    notifyListeners();
  }

  void onLocalUserJoin() {
    localUserJoined = true;
   scheduleVideoCall();
    notifyListeners();
  }

  void switchCamera() {
    engine.switchCamera();
    notifyListeners();
  }

  //new
  void updateMicStatus() {
    isMicMute = !isMicMute;
    engine.muteLocalAudioStream(isMicMute);
    notifyListeners();
  }

  // void isLocalUserJoined() {
  //   localUserJoined = true;
  //   notifyListeners();
  // }

  // void isRemoteUserJoin(int uid) {
  //   remoteUId = uid;
  //   timer = Timer.periodic(
  //     const Duration(seconds: 1),
  //     (timer) {
  //       /// callback will be executed every 1 second, increament a count value
  //       /// on each callback
  //       count++;
  //     },
  //   );
  //   notifyListeners();
  // }

  void onRemoteUserOffline(int uid) {
    remoteUId = null;
    notifyListeners();
  }

  // void updateDisplaySwitch() {
  //   isDisplaySwitch = !isDisplaySwitch;
  //   notifyListeners();
  // }

  //new

  GetAppointmentResponse? appointmentResponse = GetAppointmentResponse();

  VideoCallViewModel({required this.userId, required this.appointmentId}) {
    userId = userId ;
    appointmentId = appointmentId ;
  }

  // VideoCallViewModel.forAppointmentId(this.appointmentId);

  var _navigationService = locator<NavigationService>();
  var _videoCallService = locator<VideoCallService>();
  var _snackBarService = locator<SnackBarService>();

  void onCallEnd(BuildContext context) async{
   await scheduleCallStatus();
    _navigationService.goBack();
  }

  void leaveChannel() {
    userMap.clear();
    notifyListeners();
  }

  // void userJoined(uid, elapsed) {
  //   userMap.addAll({uid: User(uid, false)});
  //   timer = Timer.periodic(
  //     const Duration(seconds: 1),
  //         (timer) {
  //       /// callback will be executed every 1 second, increament a count value
  //       /// on each callback
  //       count++;
  //
  //     },
  //   );
  //   notifyListeners();
  // }

  void switchDisplay() {
    if (userMap.entries.length == 2) {
      displaySwitch = !displaySwitch;
      localIndex = remoteIndex;
      remoteIndex = localIndex;
      notifyListeners();
    }
  }

  void joinChannelSuccess(
    channel,
    uid,
    elapsed,
  ) {
    localUid = uid;
    userMap.addAll(
      {
        uid: User(uid, false),
      },
    );
    // _actualStartTime = formatterTime.format(now);
    notifyListeners();
  }

  Future<GenericResponse> scheduleVideoCall() async {
    var response = GenericResponse();
    try {
      loadingMsg = schedulingVideoCall;
      setState(ViewState.Loading);

      var request = new VideoCallRequest(
          channelName: channel,
          appointmentId: appointmentId,
          userId: userId,
          title: "TeleCall Joining Reminder",
          body:
              "${SessionManager.getUser.firstName} is waiting to join the call");
      var data = await _videoCallService.postVideoCall(request);

      if (data.statusCode == 200) {
        setState(ViewState.Completed);
        _snackBarService.showSnackBar(
          snackbarType: SnackbarType.success,
          title: data.message ?? somethingWentWrong,
        );
        onJoin();
      } else {
        setState(ViewState.Error);
        _snackBarService.showSnackBar(
          snackbarType: SnackbarType.error,
          title: data.message ?? somethingWentWrong,
        );
      }
    } catch (e) {
      setState(ViewState.Error);
      _snackBarService.showSnackBar(
        snackbarType: SnackbarType.error,
        title: somethingWentWrong,
      );
    }

    return response;
  }

  // for call duration/time/id/date
  Future<GenericResponse> scheduleCallStatus() async {
    var response = GenericResponse();
    try {
      loadingMsg = pleaseWait;
      setState(ViewState.Loading);

      var request = new ScheduleCallStatus(
        appointmentId: appointmentId,
        createdDate: DateTime.now().toString().split(' ').first,
        status: 'Completed',
        duration: '${count.toString()}',
      );
      var data = await _videoCallService.postScheduleCallStatus(request);

      if (data.statusCode == 200) {
        // setState(ViewState.Completed);
        // _snackBarService.showSnackBar(
        //   snackbarType: SnackbarType.success,
        //   title: data.message ?? somethingWentWrong,
        //   );
        locator<NavigationService>()
            .navigateToAndRemoveUntil(Routes.dashboardView);
      } else {
        setState(ViewState.Error);
        _snackBarService.showSnackBar(
          snackbarType: SnackbarType.error,
          title: data.message ?? somethingWentWrong,
        );
      }
    } catch (e) {
      _snackBarService.showSnackBar(
        snackbarType: SnackbarType.error,
        title: somethingWentWrong,
      );
      setState(ViewState.Error);
    }

    return response;
  }

  Future getScheduleCallStatusList() async {
    try {
      loadingMsg = fetchingAppointments;
      setState(ViewState.Loading);
      var response = await _videoCallService
          .getScheduleCallStatusByAppointmentId(appointmentId);
      if (response.hasError ?? false) {
        setState(ViewState.Empty);
        _snackBarService.showSnackBar(
            title: noAppointmentAvailable, snackbarType: SnackbarType.error);
      } else {
        var data = response.result as List;
        data.forEach((element) {
          _scheduleCallStatusList
              .add(GetScheduleCallStatusResponse.fromMap(element));
        });

        _scheduleCallStatusList.length == 0
            ? setState(ViewState.Empty)
            : setState(ViewState.Completed);
      }
    } catch (e) {
      _dialogService.showDialog(
          DialogType.ErrorDialog, message, somethingWentWrong, "", done);
      setState(ViewState.Empty);
    }
  }

  // for handle camera and microphone
  Future<void> handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    if (status.isPermanentlyDenied) {}
    print(status);
  }

  Future<void> onJoin() async {
    // update input validation
    channelControler.text.isEmpty
        ? validateError = true
        : validateError = false;
    notifyListeners();
    if (channelControler.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await handleCameraAndMic(Permission.camera);
      await handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      Map maps = new Map();
      maps["channelName"] = channelControler.text;
      maps["appointmentId"] = appointmentResponse;
      _navigationService.navigateTo(Routes.videocallView, arguments: maps);
    }
  }
  // to mute/Unmute the microphone

  void onToggleMute() {
    muted = !muted;
    notifyListeners();
    engine.muteLocalAudioStream(muted);
  }
}
