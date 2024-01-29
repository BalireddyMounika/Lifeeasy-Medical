import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/viewmodel/video_call/video_call_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VideoCallView extends StatefulWidget {
  final int appointmentId;
  final int userId;
  const VideoCallView(
      {Key? key, required this.appointmentId, required this.userId})
      : super(key: key);

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  late VideoCallViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // destroy sdk
    _viewModel.engine.leaveChannel();
    _viewModel.engine.release();
    super.dispose();
  }

  // Future<void> initAgora() async {
  //   // retrieve permissions
  //   await [Permission.microphone, Permission.camera].request();
  //
  //   //create the engine
  //   _engine = createAgoraRtcEngine();
  //   await _engine.initialize(const RtcEngineContext(
  //     appId: appId,
  //     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  //   ));
  //
  //   _engine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         debugPrint("local user ${connection.localUid} joined");
  //         setState(() {
  //           _localUserJoined = true;
  //         });
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  //         debugPrint("remote user $remoteUid joined");
  //         setState(() {
  //           _remoteUid = remoteUid;
  //         });
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteUid,
  //           UserOfflineReasonType reason) {
  //         debugPrint("remote user $remoteUid left channel");
  //         setState(() {
  //           _remoteUid = null;
  //         });
  //       },
  //       onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
  //         debugPrint(
  //             '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
  //       },
  //     ),
  //   );
  //
  //   await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  //   await _engine.enableVideo();
  //   await _engine.startPreview();
  //
  //   await _engine.joinChannel(
  //     token: token,
  //     channelId: channel,
  //     uid: 0,
  //     options: const ChannelMediaOptions(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoCallViewModel>.reactive(
      viewModelBuilder: () => VideoCallViewModel(
          userId: widget.userId, appointmentId: widget.appointmentId),
      onModelReady: (model) =>
          model.initializeData(agoraChannelName: widget.appointmentId),
      builder: (context, viewModel, child) {
        _viewModel = viewModel;

        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: remoteVideo(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: _viewModel.localUserJoined
                        ? AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _viewModel.engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
              toolbar()
            ],
          ),
        );
      },
    );
  }

  Widget remoteVideo() {
    if (_viewModel.remoteUId != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _viewModel.engine,
          canvas: VideoCanvas(uid: _viewModel.remoteUId),
          connection: RtcConnection(channelId: _viewModel.channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              _viewModel.updateMicStatus();
            },
            child: Icon(
              _viewModel.isMicMute ? Icons.mic_off : Icons.mic,
              color: _viewModel.isMicMute ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: _viewModel.isMicMute ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _viewModel.onCallEnd(context);
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _viewModel.switchCamera();
            },
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }
}
