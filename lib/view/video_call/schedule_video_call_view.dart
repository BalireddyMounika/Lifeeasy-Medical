//
// import 'package:flutter/material.dart';
// import 'package:lifeeazy_medical/common_widgets/button_container.dart';
// import 'package:lifeeazy_medical/common_widgets/common_appbar.dart';
// import 'package:lifeeazy_medical/common_widgets/loader.dart';
// import 'package:lifeeazy_medical/constants/colors.dart';
// import 'package:lifeeazy_medical/constants/strings.dart';
// import 'package:lifeeazy_medical/enums/viewstate.dart';
// import 'package:lifeeazy_medical/routes/route.dart';
// import 'package:lifeeazy_medical/viewmodel/video_call/video_call_viewmodel.dart';
// import 'package:stacked/stacked.dart';
//
// import '../../models/appointments/get_appointment_response.dart';
//
// class ScheduleVideoCallView extends StatefulWidget {
//  final GetAppointmentResponse appointmentResponse;
//   const ScheduleVideoCallView({Key? key ,  required this.appointmentResponse}) : super(key: key);
//
//   @override
//   _ScheduleVideoCallState createState() => _ScheduleVideoCallState();
// }
//
// class _ScheduleVideoCallState extends State<ScheduleVideoCallView> {
//   late VideoCallViewModel _viewModel;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<VideoCallViewModel>.reactive(
//         viewModelBuilder: () => VideoCallViewModel(appointmentResponse:widget.appointmentResponse),
//         onModelReady: (model) => model.scheduleVideoCall(),
//         builder: (context, viewModel, child) {
//           _viewModel = viewModel;
//           return Scaffold(
//             appBar: CommonAppBar(
//               title: startTeleconsultation,
//               isClearButtonVisible: true,
//               onBackPressed: () {
//                 Navigator.pop(context);
//               },
//               onClearPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, Routes.dashboardView, (route) => false);
//               },
//             ),
//             bottomSheet: ButtonContainer(
//               buttonText: makeCall,
//               onPressed: () {
//                 _viewModel.scheduleVideoCall();
//               },
//             ),
//             body: _currentWidget(),
//           );
//         });
//   }
//
//   Widget _body() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
//           child: TextField(
//             enabled: false,
//             controller: _viewModel.channelControler,
//             decoration: InputDecoration(
//               errorBorder: commonBorder(),
//               focusedErrorBorder: commonBorder(),
//               focusedBorder: commonBorder(),
//               enabledBorder: commonBorder(),
//               errorText:
//                   _viewModel.validateError ? channelnameismandatory : null,
//               hintText: chanelToken,
//             ),
//           ),
//         ),
//         Text(
//           'Duration : 00:00',
//         ),
//         Text('')
//       ],
//     );
//   }
//
//   Widget _currentWidget() {
//     switch (_viewModel.state) {
//       case ViewState.Loading:
//         return Loader(
//           loadingMessage: _viewModel.loadingMsg,
//           loadingMsgColor: Colors.black,
//         );
//
//       case ViewState.Completed:
//         return _body();
//
//       default:
//         return _body();
//     }
//   }
//
//   OutlineInputBorder commonBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//       borderSide: BorderSide(width: 2, color: baseColor),
//     );
//   }
//
//   // Future<void> onJoin() async {
//   //   // update input validation
//   //   setState(() {
//   //     _channelController.text.isEmpty
//   //         ? _validateError = true
//   //         : _validateError = false;
//   //   });
//   //   if (_channelController.text.isNotEmpty) {
//   //     // await for camera and mic permissions before pushing video page
//   //     await _viewModel.handleCameraAndMic(Permission.camera);
//   //     await _viewModel.handleCameraAndMic(Permission.microphone);
//   //     // push video page with given channel name
//   //     Map maps = new Map();
//   //     maps["channelName"] = _channelController.text;
//   //   }
//   // }
//
//   // Future<void> _handleCameraAndMic(Permission permission) async {
//   //   final status = await permission.request();
//   //   print(status);
//   // }
// }
